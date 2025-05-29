import 'package:flutter/material.dart';
import 'package:saborpty_app/features/achievement/presentation/achievement_card.dart';

class AchievementList extends StatelessWidget {
  const AchievementList({super.key});

  @override
  Widget build(BuildContext context) {
    final achievements = [
      {
        'icon': Icons.restaurant_menu,
        'title': 'Primera Receta',
        'description': 'Cocinaste tu primera receta',
        'color': Colors.deepPurple,
      },
      {
        'icon': Icons.star,
        'title': '5 Estrellas',
        'description': 'Calificaste 5 recetas',
        'color': Colors.amber,
      },
      {
        'icon': Icons.local_fire_department,
        'title': 'Racha de 3',
        'description': '3 días cocinando seguidos',
        'color': Colors.red,
      },
      {
        'icon': Icons.explore,
        'title': 'Explorador',
        'description': 'Viste 20 recetas diferentes',
        'color': Colors.indigo,
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 0.8,
        children: achievements
            .map((ach) => AchievementCard(
                  icon: ach['icon'] as IconData,
                  title: ach['title'] as String,
                  description: ach['description'] as String,
                  color: ach['color'] as Color,
                ))
            .toList(),
      ),
    );
  }
}
