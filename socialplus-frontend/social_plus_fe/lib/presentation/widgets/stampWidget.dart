import 'package:flutter/material.dart';

class StampWidget extends StatelessWidget {
  final String assetPath = 'assets/images/missionComplete.png';
  const StampWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(assetPath, width: 48, height: 48, fit: BoxFit.contain);
  }
}
