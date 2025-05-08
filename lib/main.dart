import 'package:flutter/material.dart';
import 'screens/prevention.dart';
import 'screens/home_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/credits_screen.dart';
import 'screens/prevention_tips_screen.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const BurnPreventionApp());
}

class BurnPreventionApp extends StatelessWidget {
  const BurnPreventionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prevenção de Queimaduras',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/prevention_tips': (context) => const PreventionTipsScreen(),
        '/quiz': (context) => const QuizScreen(),
        '/credits': (context) => const CreditsScreen(),
        '/prevention': (context) => const Prevention(),
      },
    );
  }
}
