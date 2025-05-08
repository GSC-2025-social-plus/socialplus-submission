import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_plus_fe/presentation/constants/colors.dart';
import 'package:social_plus_fe/presentation/constants/text_styles.dart';
import '../viewmodels/lesson_select_viewmodel.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/primary_action_button.dart';

class LessonSelectScreen extends StatelessWidget {
  const LessonSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LessonSelectViewModel>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildCommonAppBar(username: '김민성님'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Lesson ',
                  style: AppTextStyles.subtitle.copyWith(color: AppColors.primary),
                  children: [
                    TextSpan(
                      text: '1',
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
                ),
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
                  final viewModel = context.watch<LessonSelectViewModel>();
                  final isActive = index == viewModel.activeLessonIndex;

                  return _buildLessonBox(
                    index + 1,
                    isActive,
                    isActive ? () => viewModel.onSelect(index) : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 1, onTap: (index) {
        //TODO: 내비게이션 처리
      },),
    );
  }

  Widget _buildLessonBox(
      int lessonNumber,
      bool isActive,
      VoidCallback? onTap,
      ) {
    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.none,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.lightGray,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              if (isActive)
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Lesson$lessonNumber',
                  style: AppTextStyles.subtitle.copyWith(
                    color: isActive ? Colors.white : AppColors.gray,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: List.generate(2, (row) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(2, (col) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                          child: Image.asset(
                            'assets/images/onBtnMissionCount.png',
                            width: 35,
                            height: 35,
                            fit: BoxFit.fill,
                            color: isActive ? Colors.white : AppColors.gray,
                          ),
                        );
                      }),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
