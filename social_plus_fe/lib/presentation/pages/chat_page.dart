import 'package:flutter/material.dart';
import 'package:social_plus_fe/presentation/widgets/app_scaffold.dart';
import 'package:social_plus_fe/presentation/constants/colors.dart';
import 'package:social_plus_fe/presentation/constants/text_styles.dart';

class ChatPage extends StatefulWidget {
  static const routeName = '/chat';
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessage> _messages = [
    ChatMessage(text: '안녕, 오랜만이야.', isMe: false),
    ChatMessage(text: '잘 지냈어? 😊', isMe: true),
  ];
  final TextEditingController _controller = TextEditingController();

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    // 1) 내 메시지 추가
    setState(() {
      _messages.add(ChatMessage(text: text, isMe: true));
    });
    _controller.clear();

    // 2) (모의) 상대방 답장 추가 — 바로 혹은 약간 지연시켜서
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _messages.add(ChatMessage(text: text, isMe: false));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'Lesson1',
      selectedNavIndex: 1,
      onNavTap: (idx) {
        /* 탭 이동 */
      },
      body: Column(
        children: [
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
                  return ChatBubble(msg: msg);
                },
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.mic, size: 28),
                    color: AppColors.gray,
                    onPressed: () {},
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
      backgroundColor: AppColors.background,
    );
  }
}

class ChatMessage {
  final String text;
  final bool isMe;
  ChatMessage({required this.text, this.isMe = false});
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
