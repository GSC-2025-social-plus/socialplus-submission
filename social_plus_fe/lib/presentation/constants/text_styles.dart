import 'package:flutter/material.dart';

class AppTextStyles {
  static const String _fontFamily = 'Pretendard';

  /// 타이틀 (예: 페이지 제목)
  static const TextStyle heading1 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: _fontFamily,
  );

  /// 서브 타이틀 (예: 섹션 제목)
  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: _fontFamily,
  );

  /// 서브 타이틀 레귤러
  static const TextStyle subtitleR = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  /// 본문 (예: 일반 텍스트)
  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    fontFamily: _fontFamily,
  );

  /// 캡션 (예: 설명, 시간 등)
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );

  /// 라벨 (예: 뱃지, 알림 카운터)
  static const TextStyle label = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    fontFamily: _fontFamily,
  );
}

/* 사용 예시

Text('당신의 상황에 맞는 대화 연습을 선택해보세요!', style: AppTextStyles.heading1)

Text('레슨 진행하기', style: AppTextStyles.body.copyWith(color: Colors.black))

Text('친구와의 대화, 감정 표현이 어렵다면 여기를 눌러보세요!', style: AppTextStyles.caption.copyWith(color: Colors.grey))

Text('수정하기', style: AppTextStyles.label.copyWith(color: Colors.white))

 */