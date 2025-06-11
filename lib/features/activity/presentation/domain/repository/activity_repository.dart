import 'package:saborpty_app/features/activity/presentation/data/models/activity_model.dart';

abstract class ActivityRepository {
   Future<List<AcitivyDetailModel>> getAllRecentActivitiesByUser (String firebaseUID);
  Future<void> deleteActivityByUser(String firebaseUID, int id);  
}