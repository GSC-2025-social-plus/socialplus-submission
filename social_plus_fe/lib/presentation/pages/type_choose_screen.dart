import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:social_plus_fe/presentation/constants/colors.dart';
import 'package:social_plus_fe/presentation/constants/text_styles.dart';
import 'package:social_plus_fe/presentation/widgets/app_scaffold.dart';
import '../viewmodels/user_preferences_viewmodel.dart';
import '../widgets/type_option_card.dart';

class TypeChooseScreen extends StatelessWidget {
  const TypeChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backgroundColor: AppColors.background,
      title: "김민성님",
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
            TypeOptionCard(
              iconPath: 'assets/images/friends.png',
              text: '친구와의 대화, 감정 표현이 어렵다면\n여기를 눌러보세요!',
              onTap: () async {
                final prefs = context.read<UserPreferencesViewModel>();
                await prefs.saveConversationType('daily');
                Future.microtask(() {
                  context.go('/lesson-selection');
                });
              },
            ),
            const SizedBox(height: 20),
            TypeOptionCard(
              iconPath: 'assets/images/business.png',
              text: '상사나 동료와의 대화가 어렵다면\n여기를 눌러보세요!',
              onTap: () {
                context.push('/job-type');
              },
            ),
          ],
        ),
      ),
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