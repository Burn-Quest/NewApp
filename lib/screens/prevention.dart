import 'package:burnquest/models/prevention_tip.dart';
import 'package:flutter/material.dart';
import '../utils/app_theme.dart'; // Aqui você pode ajustar para sua cor primária

class Prevention extends StatefulWidget {
  const Prevention({super.key});

  @override
  State<Prevention> createState() => _PreventionState();
}

class _PreventionState extends State<Prevention> {
  int _currentIndex = 0;

  void _nextTip() {
    if (_currentIndex < preventionTips.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      // Quando terminar, volte para a tela inicial
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTip = preventionTips[_currentIndex];

    return Scaffold(
      backgroundColor:
          AppColors.background, // Cor de fundo, você pode alterar se necessário
      appBar: AppBar(
        title: const Text("Dicas de Prevenção"),
        backgroundColor:
            AppColors.primary, // Defina sua cor de fundo aqui também
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Exibe o título e a descrição da dica
            Text(
              currentTip.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              currentTip.description,
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Ícone relacionado à dica
            Icon(currentTip.icon, size: 80, color: AppColors.secondary),
            const SizedBox(height: 20),
            // O que fazer
            if (currentTip.whatToDo != null) ...[
              Text(
                'O que fazer:',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.success,
                ),
              ),
              Text(
                currentTip.whatToDo!,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 20),
            // O que não fazer
            if (currentTip.whatNotToDo != null) ...[
              Text(
                'O que não fazer:',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.error,
                ),
              ),
              Text(
                currentTip.whatNotToDo!,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 40),
            // Botão Próximo
            ElevatedButton(
              onPressed: _nextTip,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'Próximo',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
