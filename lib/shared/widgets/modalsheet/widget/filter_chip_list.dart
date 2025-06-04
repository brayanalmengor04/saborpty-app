import 'package:flutter/material.dart';

class FilterChipList extends StatelessWidget {
  const FilterChipList({super.key});

  @override
  Widget build(BuildContext context) {
    final filters = ['Todas', 'Favoritas', 'Cocinadas', 'Por cocinar'];

    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return Chip(
            label: Text(filters[index]),
            backgroundColor: index == 0 ? Colors.orange.shade100 : Colors.grey.shade200,
          );
        },
      ),
    );
  }
}
