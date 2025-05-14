// lib/presentation/widgets/app_scaffold.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import '../viewmodels/user_preferences_viewmodel.dart';
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

  void _handleNavTap(BuildContext context, int index) async {

    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        final prefsViewModel = context.read<UserPreferencesViewModel>();
        await prefsViewModel.loadPreferences();
        final type = prefsViewModel.conversationType;;
        context.go(type != null && type.isNotEmpty
            ? '/lesson-selection'
            : '/type-choose');

        break;
      case 2:
        // context.go('/profile');
        break;
    }
  }


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
      ),
      body: body,
      bottomNavigationBar: CustomBottomNavBar(
          currentIndex: selectedNavIndex,
          onTap: (index) => _handleNavTap(context, index)
      ),
    );
  }
  Widget _buildNavIcon(IconData icon, int idx) {
    final color = idx == selectedNavIndex ? Colors.blue : Colors.grey;
    return Icon(icon, color: color, size: 32);
  }
}
