import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saborpty_app/features/activity/presentation/activity_item.dart';
import 'package:saborpty_app/features/activity/presentation/data/models/activity_model.dart';
import 'package:saborpty_app/features/activity/presentation/domain/maper/activity_maper.dart';
import 'package:saborpty_app/features/activity/presentation/domain/repository/activity_repository_impl.dart';
import 'package:saborpty_app/features/activity/presentation/domain/repository/activity_repository.dart';
class RecentActivityList extends StatefulWidget {
  final User? user;
  const RecentActivityList({super.key, required this.user});
  @override
  State<RecentActivityList> createState() => _RecentActivityListState();
}

class _RecentActivityListState extends State<RecentActivityList> {
  final ActivityRepository repository = ActivityRepositoryImpl();
  late Future<List<AcitivyDetailModel>> _activitiesFuture;
  @override
  void initState() {
    super.initState();
    _activitiesFuture = repository.getAllRecentActivitiesByUser(widget.user!.uid);
  }
  Future<void> _deleteActivity(int id) async {
    await repository.deleteActivityByUser(widget.user!.uid, id);
    setState(() {
      _activitiesFuture = repository.getAllRecentActivitiesByUser(widget.user!.uid);
    });
  }
  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("¿Eliminar actividad?"),
        content: const Text("¿Estás seguro de que deseas eliminar esta actividad?"),
        actions: [
          TextButton(child: const Text("Cancelar"), onPressed: () => Navigator.of(ctx).pop(false)),
          ElevatedButton(child: const Text("Eliminar"), onPressed: () => Navigator.of(ctx).pop(true)),
        ],
      ),
    ) ?? false;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AcitivyDetailModel>>(
      future: _activitiesFuture,
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
              child: Text("Actividad Reciente", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: activities.map((activity) {
                  final icon = ActivityMapper.getIconFromType(activity.type);
                  final title = ActivityMapper.getTitleFromActivity(activity);
                  final time = activity.time ?? '';
                  return Dismissible(
                    key: Key(activity.id.toString()),
                    direction: DismissDirection.startToEnd,
                    confirmDismiss: (_) => _showConfirmationDialog(context),
                    onDismissed: (_) => _deleteActivity(activity.id!),
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.delete_rounded, color: Colors.white),
                    ),
                    child: ActivityItem(
                      icon: icon,
                      title: title,
                      time: time,
                    ),
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
