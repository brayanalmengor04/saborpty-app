import 'package:flutter/material.dart';
import 'package:saborpty_app/core/constants/app_colors.dart';
import 'package:saborpty_app/features/recipes/data/models/RecipeModelDetail.dart';

class PresentationTab extends StatelessWidget {
  final Recipe recipe;

  const PresentationTab({super.key, required this.recipe});

  Widget _buildChip(String label) {
    return Chip(
      backgroundColor: AppColors.borderRadius,
      label: Text(label, style: const TextStyle(color: AppColors.textSecondary)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              recipe.title ?? 'Receta Sin Título',
              style: const TextStyle(
                fontSize: 22,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              recipe.description ?? 'Una receta increíble que te encantará.',
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              children: [
                _buildChip('Duración: ${recipe.durationMinutes} min'),
                _buildChip('Dificultad: ${recipe.difficulty}'),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              "✨ ¡Disfruta cocinando con SaborPTY! ✨",
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
