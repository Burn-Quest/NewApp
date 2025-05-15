import 'package:shared_preferences/shared_preferences.dart';

class QuizScore {
  static const String _key = 'bestScore';

  static Future<void> saveBestScore(double score) async {
    final prefs = await SharedPreferences.getInstance();
    double? current = prefs.getDouble(_key);
    if (current == null || score > current) {
      await prefs.setDouble(_key, score);
    }
  }

  static Future<double> loadBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_key) ?? 0.0;
  }
}
