import 'package:flutter/material.dart';

class AppColors {
  /// 배경색 (밝은 회색)
  static const Color background = Color(0xFFF3F3F3);

  /// 주요 색상 (버튼 등 강조용)
  static const Color primary = Color(0xFF007AFF);

  /// 회색 (중간 정보, 보조 텍스트 등)
  static const Color gray = Color(0xFF787878);

  /// 본문 텍스트 기본 색상
  static const Color text = Color(0xFF212529);

  /// 채팅 말풍선 배경색
  static const Color chatBackground = Color(0xFFE9E9EB);
}

/* 사용 예시

Container(
  color: AppColors.chatBackground,
  child: Text(
    "소플!",
    style: TextStyle(color: AppColors.text),
  ),
)

ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
  ),
  onPressed: () {},
  child: Text("보내기", style: TextStyle(color: Colors.white)),
)

 */