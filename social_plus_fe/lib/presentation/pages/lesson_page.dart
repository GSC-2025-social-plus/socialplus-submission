import 'package:flutter/material.dart';
import 'package:social_plus_fe/presentation/widgets/app_scaffold.dart';
import 'package:social_plus_fe/presentation/pages/chat_page.dart';
import 'package:social_plus_fe/presentation/constants/colors.dart';
import 'package:social_plus_fe/presentation/constants/text_styles.dart';

/// ──────────────── Lesson 모델 ─────────────────
class Lesson {
  final String text;
  final String assetPath;
  const Lesson({required this.text, required this.assetPath});
}

class LessonListScreen extends StatelessWidget {
  static const routeName = '/lessonlist';

  // String → Lesson 객체로 교체
  final List<Lesson> lessons = const [
    Lesson(
      text: '먼저 인사하고 오늘 기분을 물어보기',
      assetPath: 'assets/images/missionBullet.png',
    ),
    Lesson(
      text: '상대방의 관심사 한 가지씩 물어보기',
      assetPath: 'assets/images/missionBullet.png',
    ),
    Lesson(text: '공통 관심사 찾기', assetPath: 'assets/images/missionBullet.png'),
    Lesson(
      text: '다음 절에 대해 안내보고 제안하기',
      assetPath: 'assets/images/missionBullet.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: 'Lesson1',
      selectedNavIndex: 0,
      onNavTap: (idx) {
        /* 탭 이동 로직 */
      },
      backgroundColor: AppColors.background,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '오늘은 친구와 오랜만에 일본 식사를 하기로 했어요.\n'
                    '가볍게 안부 인사와 함께 소소한 대화를 이어나가볼까요?\n'
                    '다음은 대화할 때 먼저 생각해볼 질문 세 가지예요!',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.text,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: lessons.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, i) {
                        return LessonCard(lesson: lessons[i]);
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, ChatPage.routeName);
                    },
                    icon: Image.asset(
                      'assets/images/RightArrowCircle.png',
                      width: 24,
                      height: 24,
                      // 만약 흰색으로 칠해진 벡터 아이콘이 아니라면 color: Colors.white는 제거하세요.
                      color: Colors.white,
                    ),
                    label: Text(
                      '시작하기',
                      style: AppTextStyles.subtitle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// ──────────────── LessonCard ─────────────────
class LessonCard extends StatelessWidget {
  final Lesson lesson;
  const LessonCard({required this.lesson, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        height: 56,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  lesson.assetPath,
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  lesson.text,
                  style: AppTextStyles.body.copyWith(color: AppColors.text),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
