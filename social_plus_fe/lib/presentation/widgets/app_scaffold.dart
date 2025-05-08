// lib/presentation/widgets/app_scaffold.dart
import 'package:flutter/material.dart';
import '../constants/colors.dart';

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
    this.backgroundColor = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [IconButton(icon: Icon(Icons.lock_outline), onPressed: () {})],
      ),
      body: body,
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavIcon(Icons.home_outlined, 0),
            _buildNavIcon(Icons.chat_bubble_outline, 1),
            _buildNavIcon(Icons.person_outline, 2),
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int idx) {
    final color = idx == selectedNavIndex ? Colors.blue : Colors.grey;
    return Icon(icon, color: color, size: 32);
  }
}
