// lib/presentation/widgets/app_scaffold.dart
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import 'custom_bottom_nav_bar.dart';

class CommonScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final int selectedNavIndex; // 0:Home, 1:Chat, 2:Profile
  final ValueChanged<int>? onNavTap;
  final Color backgroundColor;

  const CommonScaffold({
    required this.title,
    required this.body,
    this.selectedNavIndex = 1,
    this.onNavTap,
    this.backgroundColor = AppColors.background,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: Text(
          title,
          style: AppTextStyles.subtitleR.copyWith(color: AppColors.text),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.headset_mic_outlined, color: Colors.black),
            onPressed: () {}, // 기능은 나중에 채워도 됨
          ),
        ],
      ),
      body: body,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          // TODO: 내비게이션 처리
        },
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int idx) {
    final color = idx == selectedNavIndex ? Colors.blue : Colors.grey;
    return Icon(icon, color: color, size: 32);
  }
}
