import 'package:flutter/material.dart';
import 'package:saborpty_app/features/activity/presentation/data/models/activity_model.dart';

class ActivityMapper {
  static IconData getIconFromType(String? type) {
    switch (type) {
      case 'favorite':
        return Icons.favorite;
      case 'favorite_deleted':
        return Icons.delete_outline;
      case 'recipe_rate':
        return Icons.local_dining;
      case 'comment':
        return Icons.comment;
      case 'rate':
        return Icons.star;
      default:
        return Icons.help_outline;
    }
  }

  static String getTitleFromActivity(AcitivyDetailModel activity) {
    switch (activity.type) {
      case 'favorite':
        return activity.description ?? 'Agregaste a favoritos';
      case 'favorite_deleted':
        return activity.description ?? 'Eliminaste una receta';
      case 'recipe_rate':
        return activity.description ?? 'Calificaste una receta';
      case 'comment':
        return activity.description ?? 'Comentaste una receta';
      case 'otro':
        return activity.description ?? 'Calificaste una receta';
      default:
        return activity.description ?? 'Actividad desconocida';
    }
  }
}
