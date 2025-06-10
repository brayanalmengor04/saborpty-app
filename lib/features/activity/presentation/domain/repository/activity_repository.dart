import 'package:saborpty_app/features/activity/presentation/data/models/activity_model.dart';

abstract class ActivityRepository {
   Future<List<AcitivyDetailModel>> getAllRecentActivitiesFavorite (String firebaseUID);
}