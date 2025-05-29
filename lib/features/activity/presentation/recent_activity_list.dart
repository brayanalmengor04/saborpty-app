import 'package:flutter/material.dart';
import 'package:saborpty_app/features/activity/presentation/activity_item.dart';

class RecentActivityList extends StatelessWidget {
  const RecentActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      {
        'icon': Icons.access_time,
        'title': 'Cocinaste Sancocho Panameño',
        'time': 'Hace 2 horas',
      },
      {
        'icon': Icons.favorite,
        'title': 'Guardaste Arroz con Pollo',
        'time': 'Ayer',
      },
      {
        'icon': Icons.menu_book,
        'title': 'Viste Ceviche Panameño',
        'time': 'Hace 3 días',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text("Actividad Reciente",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: activities
                .map((activity) => ActivityItem(
                      icon: activity['icon'] as IconData,
                      title: activity['title'] as String,
                      time: activity['time'] as String,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
