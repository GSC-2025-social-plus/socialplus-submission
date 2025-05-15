import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_plus_fe/presentation/constants/colors.dart';
import 'package:social_plus_fe/presentation/constants/text_styles.dart';
import 'package:social_plus_fe/presentation/widgets/app_scaffold.dart';
import '../viewmodels/lesson_select_viewmodel.dart';
import '../viewmodels/user_preferences_viewmodel.dart';
import '../widgets/lesson_box.dart';

class LessonSelectionScreen extends StatelessWidget {
  const LessonSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LessonSelectViewModel>();
    final prefsViewModel = context.watch<UserPreferencesViewModel>();
    final lessonCompletion = prefsViewModel.lessonCompletion;

    return CommonScaffold(
      backgroundColor: AppColors.background,
      selectedNavIndex: 1,
      title: "레슨 선택하기",
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: () {
                  final nextIndex = lessonCompletion.indexOf(false);
                  final nextLesson = nextIndex == -1 ? null : nextIndex + 1;

                  if (nextLesson == null) {
                    return TextSpan(
                      text: '축하해요! 모든 레슨을 완료했어요!',
                      style: AppTextStyles.subtitle.copyWith(color: AppColors.primary),
                    );
                  }

                  return TextSpan(
                    children: [
                      TextSpan(
                        text: 'Lesson ',
                        style: AppTextStyles.subtitle.copyWith(color: AppColors.primary),
                      ),
                      TextSpan(
                        text: '$nextLesson',
                        style: AppTextStyles.subtitle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      TextSpan(
                        text: '부터 진행해봅시다!',
                        style: AppTextStyles.caption.copyWith(color: AppColors.gray),
                      ),
                    ],
                  );
                }(),
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 1,
                ),
                  itemBuilder: (context, index) {
                    final prefs = context.watch<UserPreferencesViewModel>();
                    final isCompleted = prefs.lessonCompletion[index];
                    final isActive = index == 0 || prefs.lessonCompletion[index - 1];

                    return LessonBox(
                      index: index,
                      isActive: isActive,
                      isCompleted: isCompleted,
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
