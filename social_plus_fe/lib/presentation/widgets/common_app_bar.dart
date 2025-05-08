import 'package:flutter/material.dart';
import 'package:social_plus_fe/presentation/constants/colors.dart';
import 'package:social_plus_fe/presentation/constants/text_styles.dart';

PreferredSizeWidget buildCommonAppBar({required String username}) {
  return AppBar(
    backgroundColor: AppColors.background,
    elevation: 0,
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {},
    ),
    title: Text(
      'Welcome, $username',
      style: AppTextStyles.subtitleR.copyWith(color: AppColors.text),
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.headset_mic_outlined, color: Colors.black),
        onPressed: () {},
      ),
    ],
  );
}
