import 'package:social_plus_fe/domain/models/lesson.dart';

class LessonRepository {
  Future<List<Lesson>> fetchPopularLessons() async {
    // TODO: 나중에 API 연결
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      Lesson(
        title: '감정 조절이 필요한 상황',
        description: '화나거나 기쁠 때,\n어떻게 행동할까요?',
        imagePath: 'assets/images/converstation.png',
        isAvailable: true,
      ),
      Lesson(
        title: '상대방을 배려하는 대화',
        description: '친구, 가족과 갈등 없이 소통하는 법!',
        imagePath: 'assets/images/converstation.png',
        isAvailable: false,
      ),
    ];
  }
}
