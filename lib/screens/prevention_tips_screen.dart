import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../models/prevention_tip.dart';

class PreventionTipsScreen extends StatelessWidget {
  const PreventionTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dicas de Prevenção')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: preventionTips.length,
        itemBuilder: (context, index) {
          final tip = preventionTips[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          tip.icon,
                          color: AppColors.primary,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          tip.title,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    tip.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (tip.whatToDo != null) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'O que fazer:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.success,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tip.whatToDo!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                  if (tip.whatNotToDo != null) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'O que não fazer:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.error,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tip.whatNotToDo!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
