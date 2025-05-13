import 'package:burnquest/models/util/quizScore.dart';
import 'package:flutter/material.dart';
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
  List<bool?> _answers = [];

  @override
  void initState() {
    super.initState();
    _answers = List.filled(quizQuestions.length, null);
  }

  void _answerQuestion(int answerIndex) {
    if (_answers[_currentQuestionIndex] != null) return;

    final isCorrect =
        answerIndex == quizQuestions[_currentQuestionIndex].correctAnswerIndex;

    setState(() {
      _answers[_currentQuestionIndex] = isCorrect;
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
      _answers = List.filled(quizQuestions.length, null);
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
    return List.generate(question.answers.length, (index) {
      final isCorrect = index == question.correctAnswerIndex;
      final isSelected = _answers[_currentQuestionIndex] != null;

      Color? bgColor;
      if (isSelected) {
        if (isCorrect) {
          bgColor = AppColors.success;
        } else if (_answers[_currentQuestionIndex] == false &&
            index != question.correctAnswerIndex) {
          bgColor = Colors.grey.shade300;
        }
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
          onTap: isSelected ? null : () => _answerQuestion(index),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color:
                  isSelected
                      ? (isCorrect ? AppColors.success : Colors.grey)
                      : Colors.grey.shade300,
              width: 1,
            ),
          ),
          leading: CircleAvatar(
            backgroundColor:
                isSelected
                    ? (isCorrect ? AppColors.success : Colors.grey)
                    : AppColors.primary,
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warning.withAlpha((0.1 * 255).round()),
        border: Border.all(color: AppColors.warning),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        quizQuestions[_currentQuestionIndex].explanation ??
            'Resposta incorreta. Consulte as dicas de prevenção para mais informações.',
        style: const TextStyle(
          fontSize: 20,
          color: AppColors.warning,
          fontWeight: FontWeight.bold,
        ),
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
