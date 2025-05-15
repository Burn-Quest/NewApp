import 'package:burnquest/models/util/quizScore.dart';
import 'package:burnquest/screens/prevention.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _bestScore = 0.0;

  double _dragExtent = 0.3; // Tamanho inicial
  final double _maxHeight = 0.75; // Tamanho máximo
  final double _minHeight = 0.25; // Tamanho mínimo
  bool _canAccessQuiz = false; // Controla se o Quiz pode ser acessado

  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    _checkQuizAccess();
    _checkQuizAccess();
    _loadBestScore();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(systemNavigationBarColor: Colors.transparent),
    );
  }

  void _loadBestScore() async {
    double score = await QuizScore.loadBestScore();
    setState(() {
      _bestScore = score;
    });
  }

  Future<void> _resetQuizAccess() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenAllScreens', false);
    setState(() {
      _canAccessQuiz = false;
    });
  }

  void _checkQuizAccess() async {
    final prefs = await SharedPreferences.getInstance();
    bool hasSeenAllScreens = prefs.getBool('hasSeenAllScreens') ?? false;
    setState(() {
      _canAccessQuiz = hasSeenAllScreens;
    });
  }

  void _markScreensAsSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenAllScreens', true);
    setState(() {
      _canAccessQuiz = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 0,
              right: 10,
              child: Center(
                child: Image.asset(
                  'assets/images/BurnQuestLogo.png',
                  width: 350,
                ),
              ),
            ),

            // Título
            Positioned(
              top: 150, // ajustado para ficar abaixo da imagem
              left: 0,
              right: 0,
              child: Center(
                child: const Text(
                  'Prevenção de Queimaduras',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // Botão e avisos
            Positioned(
              top: 350,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Prevention(),
                          ),
                        ).then((_) {
                          _markScreensAsSeen();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.background,
                        padding: const EdgeInsets.symmetric(
                          vertical: 25,
                          horizontal: 50,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Começar a aprender!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: !_canAccessQuiz,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withAlpha((0.1 * 255).round()),
                        border: Border.all(color: AppColors.warning),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: const Text(
                        'Complete as telas do "Começar a aprender" para acessar o Quiz',
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.warning,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _canAccessQuiz,
                    child: Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: Text(
                        'Melhor resultado no quiz: ${_bestScore.toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            DraggableScrollableSheet(
              controller: _sheetController,
              initialChildSize: _minHeight,
              minChildSize: _minHeight,
              maxChildSize: _maxHeight,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          final newExtent =
                              _dragExtent == _minHeight
                                  ? _maxHeight
                                  : _minHeight;
                          _sheetController.animateTo(
                            newExtent,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          setState(() {
                            _dragExtent = newExtent;
                          });
                        },
                        child: SizedBox(
                          height: 40,
                          child: Icon(
                            _dragExtent == _minHeight
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: AppColors.primary,
                            size: 60,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          controller: scrollController,
                          padding: const EdgeInsets.all(16.0),
                          children: [
                            GridView.count(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              shrinkWrap: true,
                              children: [
                                _buildMenuCard(
                                  context,
                                  'Dicas de Prevenção',
                                  Icons.lightbulb_outline,
                                  AppColors.primary,
                                  '/prevention_tips',
                                ),
                                _buildMenuCard(
                                  context,
                                  'Quiz',
                                  Icons.quiz_outlined,
                                  AppColors.secondary,
                                  '/quiz',
                                  onTap:
                                      _canAccessQuiz
                                          ? () {
                                            Navigator.pushNamed(
                                              context,
                                              '/quiz',
                                            ).then((result) {
                                              if (result != null &&
                                                  result is double) {
                                                _loadBestScore(); // Atualiza a pontuação exibida
                                              }
                                            });
                                          }
                                          : null,
                                  isEnabled: _canAccessQuiz,
                                ),
                              ],
                            ),
                            const SizedBox(height: 300),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 80,
                                    child: _buildMenuCard(
                                      context,
                                      'Créditos',
                                      Icons.info_outline,
                                      AppColors.accent,
                                      '/credits',
                                      iconSize: 32,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: SizedBox(
                                    height: 80,
                                    child: _buildMenuCard(
                                      context,
                                      'Sair',
                                      Icons.exit_to_app,
                                      AppColors.error,
                                      null,
                                      iconSize: 32,
                                      fontSize: 14,
                                      onTap: () => _showExitDialog(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    String? route, {
    VoidCallback? onTap,
    double iconSize = 48,
    double fontSize = 16,
    bool isEnabled = true,
  }) {
    return Opacity(
      opacity: isEnabled ? 1.0 : 0.2,
      child: IgnorePointer(
        ignoring: !isEnabled,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            onTap:
                onTap ??
                () {
                  if (route != null) {
                    Navigator.pushNamed(context, route);
                  }
                },
            borderRadius: BorderRadius.circular(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: iconSize, color: color),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Sair do aplicativo?'),
            content: const Text('Você tem certeza que deseja sair?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () async {
                  await _resetQuizAccess();
                  Navigator.pop(context, true);
                },
                child: const Text('Sair'),
              ),
            ],
          ),
    ).then((value) {
      if (value == true) {
        SystemNavigator.pop();
      }
    });
  }
}
