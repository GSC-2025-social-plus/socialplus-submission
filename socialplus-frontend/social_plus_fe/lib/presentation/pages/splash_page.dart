import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      // 로딩 끝나면 홈으로 이동
      context.go('/home');
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Image.asset('assets/images/splash_logo.png', width: 180),
      ),
    );
  }
}
