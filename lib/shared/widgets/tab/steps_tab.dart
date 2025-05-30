import 'package:flutter/material.dart';
import 'package:saborpty_app/core/constants/app_colors.dart';

class StepsTab extends StatelessWidget {
  final List<String> steps;

  const StepsTab({super.key, required this.steps});

  Widget _buildStepTile(int number, String step) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.startColor,
            child: Text('$number', style: const TextStyle(color: AppColors.secondary)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(step, style: const TextStyle(fontSize: 15, color: AppColors.textPrimary)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const Text(
            "Pasos para preparar",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 8),
          ...steps.asMap().entries.map((e) => _buildStepTile(e.key + 1, e.value)),
        ],
      ),
    );
  }
}
