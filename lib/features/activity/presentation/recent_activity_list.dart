import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saborpty_app/features/activity/presentation/activity_item.dart';
import 'package:saborpty_app/features/activity/presentation/data/models/activity_model.dart';
import 'package:saborpty_app/features/activity/presentation/domain/maper/activity_maper.dart';
import 'package:saborpty_app/features/activity/presentation/domain/repository/activity_reposiroty_impl.dart';
import 'package:saborpty_app/features/activity/presentation/domain/repository/activity_repository.dart';

class RecentActivityList extends StatelessWidget {
  final User? user;
  final ActivityRepository repository = ActivityReposirotyImpl();

  RecentActivityList({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AcitivyDetailModel>>(
      future: repository.getAllRecentActivitiesFavorite(user!.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar actividades'));
        }
        final activities = snapshot.data ?? [];

        if (activities.isEmpty) {
          return const Center(child: Text('No hay actividades recientes'));
        }
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
                children: activities.map((activity) {
                  final icon = ActivityMapper.getIconFromType(activity.type);
                  final title = ActivityMapper.getTitleFromActivity(activity);
                  final time = activity.time ?? '';
                  return ActivityItem(
                    icon: icon,
                    title: title,
                    time: time,
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
