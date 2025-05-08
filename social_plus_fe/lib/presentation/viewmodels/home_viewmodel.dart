import 'package:flutter/material.dart';
import 'package:social_plus_fe/domain/models/lesson.dart';
import 'package:social_plus_fe/data/repositories/lesson_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final LessonRepository _repository;

  HomeViewModel(this._repository);

  List<Lesson> _lessons = [];
  bool _isLoading = false;

  List<Lesson> get lessons => _lessons;
  bool get isLoading => _isLoading;

  Future<void> loadLessons() async {
    _isLoading = true;
    notifyListeners();

    _lessons = await _repository.fetchPopularLessons();

    _isLoading = false;
    notifyListeners();
  }
}
