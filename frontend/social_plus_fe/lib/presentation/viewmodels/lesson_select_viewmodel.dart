import 'package:flutter/material.dart';

import '../../core/utils/scenario_id_mapper.dart';

class LessonSelectViewModel extends ChangeNotifier {
  int activeLessonIndex = 0; // ex: 서버에서 받아온 진행 가능한 레슨 번호

  int getActiveLessonIndex() => activeLessonIndex;

  Future<void> loadFromServer() async {
    // 예시: 서버에서 받아온 진행 가능 레슨 번호
    await Future.delayed(const Duration(milliseconds: 300));
    activeLessonIndex = 2;
    notifyListeners();
  }

  void onSelect(int index) {
    if (index == activeLessonIndex) {
      // 레슨 진입 처리
    }
  }
}


