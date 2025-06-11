import 'package:saborpty_app/features/activity/presentation/data/datasources/activity_datasources.dart';
import 'package:saborpty_app/features/activity/presentation/data/models/activity_model.dart';
import 'package:saborpty_app/features/activity/presentation/domain/repository/activity_repository.dart';

class ActivityRepositoryImpl implements ActivityRepository { 

  final ActivityDatasources datasources= ActivityDatasources();
  @override
  Future<List<AcitivyDetailModel>> getAllRecentActivitiesByUser(String firebaseUID) {
    return datasources.fetchRecentActivities(firebaseUID);
  }
  @override
  Future<void> deleteActivityByUser(String firebaseUID, int id) {
   return datasources.deleteActivityByUser(firebaseUID, id);
  }
}