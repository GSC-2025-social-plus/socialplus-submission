import 'package:flutter/material.dart';
import 'package:social_plus_fe/presentation/constants/colors.dart';
import 'package:social_plus_fe/presentation/constants/text_styles.dart';
import 'package:social_plus_fe/presentation/widgets/custom_bottom_nav_bar.dart';
import '../widgets/common_app_bar.dart';

class JobTypeScreen extends StatelessWidget {
  const JobTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildCommonAppBar(username: '김민성'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          children: [
            Text(
              '직무 유형을 선택하세요',
              style: AppTextStyles.heading1.copyWith(color: AppColors.text),
            ),
            const SizedBox(height: 40),
            _buildJobButton(
              icon: Image.asset('assets/images/coffee.png'),
              label: '카페 및 서비스직',
              onTap: () {},
            ),
            const SizedBox(height: 20),
            _buildJobButton(
              icon: Image.asset('assets/images/manufacturing.png'),
              label: '제조 및 포장',
              onTap: () {},
            ),
            const SizedBox(height: 20),
            _buildJobButton(
              icon: Image.asset('assets/images/ITBusiness.png'),
              label: 'IT 단순직',
              onTap: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 1, onTap: (index) {
        //TODO: 내비게이션 처리
      }),
    );
  }

  Widget _buildJobButton({
    required Widget icon,
    required String label,
    required VoidCallback onTap,
  }) {
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
            SizedBox(
              width: 40,
              child: icon,
            ),
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
