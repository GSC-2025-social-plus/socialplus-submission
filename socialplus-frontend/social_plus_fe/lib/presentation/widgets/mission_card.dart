import 'package:flutter/material.dart';
import '../../domain/models/scenario.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart'; // Mission 모델

class MissionCard extends StatelessWidget {
  final Mission mission;

  const MissionCard({super.key, required this.mission});

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
                  'assets/images/missionBullet.png',
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  mission.description,
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
