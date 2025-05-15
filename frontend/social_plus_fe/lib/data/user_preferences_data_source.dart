import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserPreferencesDataSource {
  Future<void> saveConversationType(String type) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('conversationType', type);
  }

  Future<String?> loadConversationType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('conversationType');
  }

  Future<void> saveLessonCompletion(String type, List<bool> completionList) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lessonCompletion_$type', jsonEncode(completionList));
  }

  Future<List<bool>> loadLessonCompletion(String type) async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('lessonCompletion_$type');
    if (jsonString == null) return [false, false, false, false];
    List<dynamic> list = jsonDecode(jsonString);
    return list.map((e) => e as bool).toList();
  }
}
