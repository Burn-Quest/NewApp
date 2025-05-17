import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Créditos')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/images/app_icon.png',
                fit: BoxFit.cover,
                width: 150,
                height: 150,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Burn Quest',
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            const Text(
              'Nome da disciplina:',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Desenvolvimento de Software',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            const Text(
              'Nome do professsor responsável:',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Prof. Dr. Elvio Gilberto da Silva',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            const Text(
              'Nomes completos dos integrantes e colaboradores do grupo:',
              style: TextStyle(fontSize: 18,),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Abner Wallace da Costa Rodrigues\nMaria Antonia Rodrigues Vieira\nVictor Silva Murakami\nVinicius Henrique Dalaqua da Silva',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            const Text(
              'DESENVOLVIMENTO:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Image.asset(
              'assets/images/logo_creditos/ciencia_da_computacaoLogo.jpg'
            ),
            const SizedBox(height: 32),
            const Text(
              'APOIO:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Image.asset(
                'assets/images/logo_creditos/coordenadoriaLogo.jpg'
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              icon: const Icon(Icons.home),
              label: const Text('Voltar para o Início'),
            ),
          ],
        ),
      ),
    );
  }
}
