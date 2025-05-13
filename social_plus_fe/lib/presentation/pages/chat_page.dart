import 'package:flutter/material.dart';
import 'package:social_plus_fe/presentation/widgets/app_scaffold.dart';
import 'package:social_plus_fe/presentation/constants/colors.dart';
import 'package:social_plus_fe/presentation/constants/text_styles.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:async';

class ChatPage extends StatefulWidget {
  static const routeName = '/chat';

  static const String _defaultUserId = 'user123';
  static const String _defaultScenarioId = 'park_friend_scenario';

  /* 추후 연결을 위한 부분 */
  final int lessonIndex;
  final String userId;
  final String scenarioId;

  const ChatPage({
    super.key,
    required this.lessonIndex,
    this.scenarioId = _defaultScenarioId,
    this.userId = _defaultUserId,
  });
/* 추후 연결을 위한 부분 */

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();

  static const String _startUrl =
      'https://startconversation-imrcv7okwa-uc.a.run.app';
  static const String _sendUrl = 'https://sendmessage-imrcv7okwa-uc.a.run.app';
  static const String _userId = 'user123';
  static const String _scenarioId = 'park_friend_scenario';


  String? _sessionId; // startConversation 으로 받은 세션 ID
  String? _sessionStatus; // sendMessage 응답의 sessionStatus
  List<String> _completedMissions = []; // sendMessage 응답의 completedMissions

  // 음성 인식
  late stt.SpeechToText _speech;
  bool _isListening = false;

  Timer? _silenceTimer; // 일정 시간이 지나면 자동으로 음성인식을 종료하기 위한 타이머 변수

  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (result) {
          setState(() {
            _controller.text = result.recognizedWords;
            _controller.selection = TextSelection.fromPosition(
              TextPosition(offset: _controller.text.length),
            );
          });
          // 타이머 리셋
          _resetSilenceTimer();
        },
        localeId: 'ko_KR',
      );
      _resetSilenceTimer();
    }
  }

  void _resetSilenceTimer() {
    _silenceTimer?.cancel();
    _silenceTimer = Timer(const Duration(seconds: 3), () {
      _stopListening();
    });
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
    _silenceTimer?.cancel(); // 타이머 정리
  }


  @override
  void initState() {
    super.initState();
    _startConversation();
    _speech = stt.SpeechToText();
  }

  /// 1) startConversation 호출
  Future<void> _startConversation() async {
    final uri = Uri.parse(_startUrl);
    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userId': _userId, 'scenario': _scenarioId}),
    );
    if (res.statusCode != 200) {
      throw Exception('startConversation failed: status ${res.statusCode}');
    }

    final data = jsonDecode(res.body) as Map<String, dynamic>;
    setState(() {
      _sessionId = data['sessionId'] as String?;
      _messages.add(
        ChatMessage(
          text: data['botInitialMessage'] as String,
          isMe: false,
          showStamp: false, // 기본적으로 스탬프는 표시하지 않음
        ),
      );
    });
  }

  /// 2) sendMessage 호출
  Future<void> _sendMessage(String userMessage) async {
    if (_sessionId == null) return;

    final uri = Uri.parse(_sendUrl);
    final res = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': _userId,
        'sessionId': _sessionId,
        'message': userMessage,
      }),
    );
    if (res.statusCode != 200) {
      throw Exception('sendMessage failed: status ${res.statusCode}');
    }

    final data = jsonDecode(res.body) as Map<String, dynamic>;
    setState(() {
      _messages.add(
        ChatMessage(
          text: data['botMessage'] as String,
          isMe: false,
          showStamp: false, // 기본값: 스탬프 표시 안 함
        ),
      );
      _sessionStatus = data['sessionStatus'] as String?;
      _completedMissions =
          (data['completedMissions'] as List<dynamic>).cast<String>();
    });
  }

  void _handleSend() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      // 1) 내 메시지 화면에 추가
      _messages.add(ChatMessage(text: text, isMe: true, showStamp: false));
    });
    _controller.clear();

    // 2) 백엔드로 전송하고 응답 처리
    await _sendMessage(text);
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'Lesson1',
      selectedNavIndex: 1,
      onNavTap: (idx) {
        /* 탭 이동 */
      },
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // ─── 채팅 메시지 리스트 ──────────────────
          Expanded(
            child: Container(
              color: AppColors.background,
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                itemCount: _messages.length,
                itemBuilder: (_, i) {
                  final msg = _messages[_messages.length - 1 - i];
                  return _MessageWithStamp(msg: msg);
                },
              ),
            ),
          ),

          // ─── 입력 영역 ──────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(_isListening ? Icons.mic_off : Icons.mic, size: 28),
                    color: AppColors.gray,
                    onPressed: _isListening ? _stopListening : _startListening,
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

/// 메시지와, 상대방 메시지 뒤에만 스탬프를 붙여주는 위젯
class _MessageWithStamp extends StatelessWidget {
  final ChatMessage msg;
  const _MessageWithStamp({required this.msg, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bubble = ChatBubble(msg: msg);

    // 상대방 메시지이면서, showStamp가 true일 때만 도장 표시
    if (!msg.isMe && msg.showStamp) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bubble,
          const SizedBox(height: 6),
          Image.asset(
            'assets/images/missionComplete.png',
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
        ],
      );
    }

    // 그 외에는 말풍선만
    return bubble;
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  final bool showStamp; // ◀ 추가: 스탬프 표시 여부

  ChatMessage({
    required this.text,
    this.isMe = false,
    this.showStamp = false, // 기본값 false
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
