import 'package:flutter/material.dart';
import 'package:saborpty_app/features/weekly_meal/data/models/weekly_meal_model.dart';

class WeeklyMealCard extends StatelessWidget {
  final WeeklyMealModel meal;

  const WeeklyMealCard({required this.meal, super.key});

  @override
  Widget build(BuildContext context) {
    final hasMeal = meal.name != null;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 12),
        // Línea del timeline + círculo del día
        Column(
          children: [
            Container(
              width: 2,
              height: 8,
              color: Colors.orange.shade300,
            ),
            CircleAvatar(
              backgroundColor: hasMeal ? Colors.orange : Colors.grey.shade400,
              radius: 14,
              child: Text(
                meal.day.substring(0, 1),
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
            Container(
              width: 2,
              height: 50,
              color: Colors.orange.shade300,
            ),
          ],
        ),
        const SizedBox(width: 10),
        // Card con contenido
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: hasMeal ? Colors.white : Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.06),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: hasMeal
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.name!,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${meal.category} • ${meal.time}",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Añadir receta para ${meal.day}",
                        style: TextStyle(
                          color: Colors.orange.shade700,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                      const Icon(Icons.add_circle_outline, color: Colors.orange, size: 20),
                    ],
                  ),
          ),
        ),
        const SizedBox(width: 12),
      ],
    );
  }
}
