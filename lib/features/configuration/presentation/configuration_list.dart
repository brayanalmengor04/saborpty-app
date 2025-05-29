import 'package:flutter/material.dart';
import 'package:saborpty_app/core/constants/app_colors.dart';
import 'package:saborpty_app/features/configuration/data/configuration_items.dart';

class ConfigurationItem {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  ConfigurationItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });
}

class ConfigurationList extends StatelessWidget {
  const ConfigurationList({super.key});

  @override
  Widget build(BuildContext context) {
    final items = getConfigurationItems(context);

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: item.onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shawdowCard,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.borderRadius,
                  child: Icon(item.icon, color: AppColors.textSecondary),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSecondary)),
                      const SizedBox(height: 4),
                      Text(item.description,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black54)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
          ),
        );
      },
    );
  }
}
