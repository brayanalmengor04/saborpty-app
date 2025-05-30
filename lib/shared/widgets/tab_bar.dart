import 'package:flutter/material.dart';
import 'package:saborpty_app/core/constants/app_colors.dart';

class CustomTabBar extends StatelessWidget {
  final TabController tabController;

  const CustomTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          color: AppColors.textSecondary.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        indicatorPadding: const EdgeInsets.all(4),
        labelColor: AppColors.textSecondary,
        unselectedLabelColor: AppColors.secondary.withOpacity(0.6),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 13,
        ),
        tabs: const [
          _MinimalTab(icon: Icons.auto_graph_outlined, label: "Presentación"),
          _MinimalTab(icon: Icons.food_bank_outlined, label: "Ingredientes"),
          _MinimalTab(icon: Icons.outdoor_grill_outlined, label: "Pasos"),
        ],
      ),
    );
  }
}

class _MinimalTab extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MinimalTab({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
    );
  }
}
