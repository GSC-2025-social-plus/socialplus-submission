import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_plus_fe/presentation/constants/colors.dart';
import 'package:social_plus_fe/presentation/constants/text_styles.dart';
import 'package:social_plus_fe/presentation/routes/route_names.dart';

class LessonBox extends StatelessWidget {
  final int index;
  final bool isActive;
  final bool isCompleted;

  const LessonBox({
    super.key,
    required this.index,
    required this.isActive,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final lessonNumber = index + 1;

    return Material(
      color: Colors.transparent,
      clipBehavior: Clip.none,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: isActive&&!isCompleted
            ? () {
          context.push('${RouteNames.lesson}?index=$index');
        }
            : null,
        child: Stack(
          children: [
            Ink(
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
                      'Lesson $lessonNumber',
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
            if (isCompleted)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Center( 
                    child: Image.asset(
                      'assets/images/missionComplete.png',
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
