import 'package:shared_preferences/shared_preferences.dart';

class QuizScore {
  static double bestScore = 0;

  static Future<void> loadBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    bestScore = prefs.getDouble('best_quiz_score') ?? 0;
  }
}
