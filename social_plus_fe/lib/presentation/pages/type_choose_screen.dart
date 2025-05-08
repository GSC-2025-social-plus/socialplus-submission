import 'package:flutter/material.dart';
import 'package:social_plus_fe/presentation/constants/colors.dart';
import 'package:social_plus_fe/presentation/constants/text_styles.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class TypeChooseScreen extends StatelessWidget {
  const TypeChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildCommonAppBar(username: '김민성'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Center(
              child: Text(
                '당신의 상황에 맞는\n대화 연습을 선택해보세요!',
                textAlign: TextAlign.center,
                style: AppTextStyles.heading1.copyWith(color: AppColors.text)
              ),
            ),
            const SizedBox(height: 40),
            _buildOptionCard(
              context,
              iconPath: 'assets/images/friends.png',
              text: '친구와의 대화, 감정 표현이 어렵다면\n여기를 눌러보세요!',
            ),
            const SizedBox(height: 20),
            _buildOptionCard(
              context,
              iconPath: 'assets/images/business.png',
              text: '상사나 동료와의 대화가 어렵다면\n여기를 눌러보세요!',
            ),
          ],
        ),
      ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: 1,
          onTap: (index) {
            //TODO: 내비게이션 처리
          },
        )
    );
  }

  Widget _buildOptionCard(BuildContext context, {
    required String iconPath,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(iconPath, width: 48, height: 48),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.caption.copyWith(color: AppColors.gray),
            ),
          ),
        ],
      ),
    );
  }
}