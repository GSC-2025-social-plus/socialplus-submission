import 'package:flutter/material.dart';
import 'package:social_plus_fe/presentation/constants/colors.dart';
import 'package:social_plus_fe/presentation/constants/text_styles.dart';

class JobTypeButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;

  const JobTypeButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            SizedBox(width: 40, child: icon),
            const SizedBox(width: 50),
            Text(
              label,
              style: AppTextStyles.subtitle.copyWith(color: AppColors.black50),
            ),
          ],
        ),
      ),
    );
  }
}
