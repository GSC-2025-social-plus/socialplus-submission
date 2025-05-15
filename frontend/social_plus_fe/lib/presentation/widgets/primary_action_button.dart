import 'package:flutter/material.dart';
import 'package:social_plus_fe/presentation/constants/colors.dart';
import 'package:social_plus_fe/presentation/constants/text_styles.dart';

class PrimaryActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final Widget? icon;
  final MainAxisAlignment alignment;

  const PrimaryActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.icon,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Row(
          mainAxisAlignment: alignment,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: AppTextStyles.subtitle.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
