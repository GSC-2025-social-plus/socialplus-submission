import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:social_plus_fe/presentation/constants/colors.dart';
import 'package:social_plus_fe/presentation/constants/text_styles.dart';
import 'package:social_plus_fe/presentation/routes/route_names.dart';
import 'package:social_plus_fe/presentation/widgets/app_scaffold.dart';
import '../viewmodels/user_preferences_viewmodel.dart';
import '../widgets/job_type_button.dart';

class JobTypeScreen extends StatelessWidget {
  const JobTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backgroundColor: AppColors.background,
      title: "직무 유형 선택하기",
      selectedNavIndex: 1,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          children: [
            Text(
              '직무 유형을 선택하세요',
              style: AppTextStyles.heading1.copyWith(color: AppColors.text),
            ),
            const SizedBox(height: 40),
            JobTypeButton(
              icon: Image.asset('assets/images/coffee.png'),
              label: '카페 및 서비스직',
              onTap: () async {
                final prefs = context.read<UserPreferencesViewModel>();
                await prefs.saveConversationType('job-cafe');
                Future.microtask(() {
                  context.go(RouteNames.lessonSelection);
                });
              },
            ),
            const SizedBox(height: 20),
            JobTypeButton(
              icon: Image.asset('assets/images/manufacturing.png'),
              label: '제조 및 포장',
              onTap: () async {
                final prefs = context.read<UserPreferencesViewModel>();
                await prefs.saveConversationType('job-manufacture');
                Future.microtask(() {
                  context.go(RouteNames.lessonSelection);
                });
              },
            ),
            const SizedBox(height: 20),
            JobTypeButton(
              icon: Image.asset('assets/images/ITBusiness.png'),
              label: 'IT 단순직',
              onTap: () async {
                final prefs = context.read<UserPreferencesViewModel>();
                await prefs.saveConversationType('job-it');
                Future.microtask(() {
                  context.go(RouteNames.lessonSelection);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
