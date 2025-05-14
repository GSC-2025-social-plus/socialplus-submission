import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:social_plus_fe/presentation/constants/colors.dart';
import 'package:social_plus_fe/presentation/constants/text_styles.dart';
import 'package:social_plus_fe/presentation/widgets/app_scaffold.dart';
import 'package:social_plus_fe/presentation/widgets/primary_action_button.dart';
import 'package:social_plus_fe/presentation/viewmodels/user_preferences_viewmodel.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;
import '../routes/route_names.dart';

class ChatPage extends StatefulWidget {
  static const routeName = '/chat';

  static const String _defaultUserId = 'user123';
  static const String _defaultScenarioId = 'park_friend_scenario';

  final int lessonIndex;
  final String userId;
  final String scenarioId;

  const ChatPage({
    Key? key,
    required this.lessonIndex,
    this.userId = _defaultUserId,
    this.scenarioId = _defaultScenarioId,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();
  late final stt.SpeechToText _speech;
  bool _isListening = false;
  Timer? _silenceTimer;
  String? _sessionId;
  String? _sessionStatus;
  List<String> _completedMissions = [];

  bool _acceptSttInput = true;
  bool _micPermissionGranted = true;

  static const String _startUrl =
      'https://startconversation-imrcv7okwa-uc.a.run.app';
  static const String _sendUrl = 'https://sendmessage-imrcv7okwa-uc.a.run.app';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _startConversation();
  }

  Future<void> _startConversation() async {
    final res = await http.post(
      Uri.parse(_startUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': widget.userId,
        'scenario': widget.scenarioId,
      }),
    );
    if (res.statusCode != 200) {
      throw Exception('startConversation failed: ${res.statusCode}');
    }
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    setState(() {
      _sessionId = data['sessionId'] as String?;
      _messages.add(
        ChatMessage(text: data['botInitialMessage'] as String, isMe: false),
      );
    });
  }

  Future<void> _sendMessage(String userMessage) async {
    if (_sessionId == null) return;
    final res = await http.post(
      Uri.parse(_sendUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': widget.userId,
        'sessionId': _sessionId,
        'message': userMessage,
      }),
    );
    if (res.statusCode != 200) {
      throw Exception('sendMessage failed: ${res.statusCode}');
    }
    final data = jsonDecode(res.body) as Map<String, dynamic>;
    final completed =
        (data['completedMissions'] as List<dynamic>).cast<String>();
    final sessionStatus = data['sessionStatus'] as String?;

    setState(() {
      _sessionStatus = sessionStatus;
      _completedMissions = completed;
      _messages.add(
        ChatMessage(
          text: data['botMessage'] as String,
          isMe: false,
          completedMissions: completed,
        ),
      );
    });

    // 레슨 완료 시 저장
    if (sessionStatus == 'ended') {
      context.read<UserPreferencesViewModel>().onLessonCompleted(
        context,
        widget.lessonIndex,
      );
    }
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(text: text, isMe: true));
    });
    _controller.clear();
    _sendMessage(text);
  }

  void _startListening() async {
    bool available = await _speech.initialize();

    setState(() {
      _micPermissionGranted = available; // 권한 상태 저장
    });

    if (!available) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("마이크 권한이 필요해요! 설정에서 허용해주세요.")),
      );
      return;
    }

    if (available) {
      setState(() {
        _isListening = true;
        _acceptSttInput = true;
      });
      _speech.listen(
        onResult: (result) {
          if (!_acceptSttInput) return;
          setState(() {
            _controller.text = result.recognizedWords;
            _controller.selection = TextSelection.fromPosition(
              TextPosition(offset: _controller.text.length),
            );
          });
          _resetSilenceTimer();
        },
        localeId: 'ko_KR',
      );
      _resetSilenceTimer();
    }
  }

  void _resetSilenceTimer() {
    _silenceTimer?.cancel();
    _silenceTimer = Timer(const Duration(seconds: 3), _stopListening);
  }

  void _stopListening() {
    _speech.stop();
    _silenceTimer?.cancel();
    setState(() {
      _isListening = false;
      _acceptSttInput = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'Lesson ${widget.lessonIndex + 1}',
      selectedNavIndex: 1,
      onNavTap: (_) {},
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // 채팅 리스트
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final msg = _messages[_messages.length - 1 - i];
                return _MessageWithStamp(msg: msg);
              },
            ),
          ),

          // 세션 종료 시 “다음 레슨 진행하기” 버튼, 아니면 입력창
          if (_sessionStatus == 'ended')
            Padding(
              padding: const EdgeInsets.all(16),
              child: PrimaryActionButton(
                text: '다음 레슨 진행하기',
                icon: Image.asset(
                  'assets/images/leftArrowCircle.png',
                  width: 24,
                  height: 24,
                ),
                alignment: MainAxisAlignment.center,
                width: double.infinity,
                onPressed: () {
                  final nextIndex = widget.lessonIndex + 1;
                  const scenarios = [
                    'emotion_conversation_scenario',
                    'make_decision_scenario',
                    'ask_for_help_scenario',
                  ];
                  final nextScenario =
                      scenarios[(nextIndex - 1).clamp(0, scenarios.length - 1)];
                  context.go(
                    '${RouteNames.chat}?index=$nextIndex&scenarioId=$nextScenario',
                  );
                },
              ),
            )
          else
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: IconButton(
                        icon: Icon(
                          _micPermissionGranted ? Icons.mic : Icons.mic_off,
                          size: _isListening ? 32 : 28,
                        ),
                        color: _isListening
                            ? AppColors.primary
                            : AppColors.gray.withOpacity(_micPermissionGranted ? 1.0 : 0.4),
                        onPressed: _micPermissionGranted
                            ? (_isListening ? _stopListening : _startListening)
                            : null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.chatBackground,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: TextField(
                          controller: _controller,
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.text,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '메시지를 입력하세요',
                            hintStyle: AppTextStyles.body.copyWith(
                              color: AppColors.gray,
                            ),
                          ),
                          onSubmitted: (_) => _handleSend(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.send, size: 28),
                      color: AppColors.primary,
                      onPressed: _handleSend,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _MessageWithStamp extends StatelessWidget {
  final ChatMessage msg;
  const _MessageWithStamp({required this.msg, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bubble = ChatBubble(msg: msg);
    if (!msg.isMe && msg.completedMissions.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bubble,
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            children:
                msg.completedMissions.map((_) {
                  return Image.asset(
                    'assets/images/missionComplete.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                  );
                }).toList(),
          ),
        ],
      );
    }
    return bubble;
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final List<String> completedMissions;

  ChatMessage({
    required this.text,
    this.isMe = false,
    this.completedMissions = const [],
  });
}

class ChatBubble extends StatelessWidget {
  final ChatMessage msg;
  const ChatBubble({required this.msg, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final align = msg.isMe ? Alignment.centerRight : Alignment.centerLeft;
    final bg = msg.isMe ? AppColors.primary : AppColors.chatBackground;
    final color = msg.isMe ? Colors.white : AppColors.text;
    final radius = BorderRadius.only(
      topLeft: const Radius.circular(12),
      topRight: const Radius.circular(12),
      bottomLeft: Radius.circular(msg.isMe ? 12 : 0),
      bottomRight: Radius.circular(msg.isMe ? 0 : 12),
    );

    return Align(
      alignment: align,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(color: bg, borderRadius: radius),
        child: Text(msg.text, style: AppTextStyles.body.copyWith(color: color)),
      ),
    );
  }
}
