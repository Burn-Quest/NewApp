import 'package:burnquest/models/util/quiz_score.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quiz_question.dart';
import '../utils/app_theme.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _quizCompleted = false;
  bool _showNextButton = false;
  bool _showExplanation = false;
  List<int?> _selectedAnswerIndices = [];

  @override
  void initState() {
    super.initState();
    _selectedAnswerIndices = List.filled(quizQuestions.length, null);
  }

  Future<void> _saveBestScore(double score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('best_quiz_score', score);
  }

  void _answerQuestion(int answerIndex) {
    if (_selectedAnswerIndices[_currentQuestionIndex] != null) return;

    final isCorrect =
        answerIndex == quizQuestions[_currentQuestionIndex].correctAnswerIndex;

    setState(() {
      _selectedAnswerIndices[_currentQuestionIndex] = answerIndex;
      if (isCorrect) _score++;
      _showNextButton = true;
      _showExplanation = !isCorrect;
    });
  }

  void _goToNextQuestion() {
    setState(() {
      if (_currentQuestionIndex < quizQuestions.length - 1) {
        _currentQuestionIndex++;
        _showNextButton = false;
        _showExplanation = false;
      } else {
        _quizCompleted = true;
      }
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _quizCompleted = false;
      _showNextButton = false;
      _showExplanation = false;
      _selectedAnswerIndices = List.filled(quizQuestions.length, null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz de Prevenção')),
      body: _quizCompleted ? _buildResultScreen() : _buildQuizScreen(),
    );
  }

  Widget _buildQuizScreen() {
    final question = quizQuestions[_currentQuestionIndex];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildProgressIndicator(),
          const SizedBox(height: 8),
          _buildQuestionNumber(),
          const SizedBox(height: 24),
          _buildQuestionText(question),
          const SizedBox(height: 32),
          ..._buildAnswerCards(question),
          if (_showExplanation) _buildExplanation(),
          if (_showNextButton) _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return LinearProgressIndicator(
      value: (_currentQuestionIndex + 1) / quizQuestions.length,
      backgroundColor: Colors.grey[300],
      color: AppColors.primary,
    );
  }

  Widget _buildQuestionNumber() {
    return Text(
      'Pergunta ${_currentQuestionIndex + 1} de ${quizQuestions.length}',
      style: const TextStyle(fontSize: 16, color: AppColors.textSecondary),
    );
  }

  Widget _buildQuestionText(QuizQuestion question) {
    return Text(
      question.question,
      style: Theme.of(context).textTheme.displaySmall,
      textAlign: TextAlign.center,
    );
  }

  List<Widget> _buildAnswerCards(QuizQuestion question) {
    final selectedIndex = _selectedAnswerIndices[_currentQuestionIndex];
    final isAnswered = selectedIndex != null;

    return List.generate(question.answers.length, (index) {
      final isCorrect = index == question.correctAnswerIndex;
      final wasSelected = index == selectedIndex;

      Color? bgColor;
      Color? borderColor;
      Color? avatarColor;

      if (isAnswered) {
        if (isCorrect) {
          bgColor = AppColors.success;
          borderColor = AppColors.success;
          avatarColor = AppColors.success;
        } else if (wasSelected) {
          bgColor = AppColors.error;
          borderColor = AppColors.error;
          avatarColor = AppColors.error;
        } else {
          bgColor = Colors.grey.shade300;
          borderColor = Colors.grey.shade300;
          avatarColor = Colors.grey;
        }
      } else {
        bgColor = Colors.white;
        borderColor = Colors.grey.shade300;
        avatarColor = AppColors.primary;
      }

      return Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: bgColor,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          title: Text(
            question.answers[index],
            style: const TextStyle(fontSize: 16),
          ),
          onTap: isAnswered ? null : () => _answerQuestion(index),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: borderColor ?? Colors.grey, width: 1),
          ),
          leading: CircleAvatar(
            backgroundColor: avatarColor,
            child: Text(
              String.fromCharCode(65 + index),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildExplanation() {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacity(0.1),
        border: Border.all(color: AppColors.warning, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Explicação:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.warning,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            quizQuestions[_currentQuestionIndex].explanation ??
                'Resposta incorreta. Consulte as dicas de prevenção para mais informações.',
            style: const TextStyle(fontSize: 16, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton.icon(
        onPressed: _goToNextQuestion,
        icon: const Icon(Icons.arrow_forward),
        label: const Text('Próxima'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildResultScreen() {
    final percentage = (_score / quizQuestions.length) * 100;
    if (percentage > QuizScore.bestScore) {
      QuizScore.bestScore = percentage;
      _saveBestScore(percentage);
    }

    String message;
    Color messageColor;

    if (percentage >= 80) {
      message = 'Parabéns! Você é um especialista em prevenção de queimaduras!';
      messageColor = AppColors.success;
    } else if (percentage >= 60) {
      message =
          'Bom trabalho! Você sabe bastante sobre prevenção de queimaduras.';
      messageColor = AppColors.primary;
    } else {
      message =
          'Continue aprendendo sobre prevenção de queimaduras para se proteger melhor!';
      messageColor = AppColors.warning;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.emoji_events,
              size: 80,
              color: AppColors.secondary,
            ),
            const SizedBox(height: 24),
            Text(
              'Quiz Completo!',
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Sua pontuação: $_score de ${quizQuestions.length}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '${percentage.toStringAsFixed(0)}%',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: messageColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Text(
              message,
              style: TextStyle(fontSize: 24, color: messageColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _restartQuiz,
              icon: const Icon(Icons.replay),
              label: const Text('Tentar Novamente'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              icon: const Icon(Icons.home),
              label: const Text('Voltar para o Início'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/prevention_tips');
              },
              child: const Text('Revisar Dicas de Prevenção'),
            ),
          ],
        ),
      ),
    );
  }
}
