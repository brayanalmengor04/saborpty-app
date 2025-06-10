import 'package:saborpty_app/features/activity/presentation/data/datasources/activity_datasources.dart';
import 'package:saborpty_app/features/activity/presentation/data/models/activity_model.dart';
import 'package:saborpty_app/features/activity/presentation/domain/repository/activity_repository.dart';

class ActivityReposirotyImpl implements ActivityRepository { 

  final ActivityDatasources datasources= ActivityDatasources();
  @override
  Future<List<AcitivyDetailModel>> getAllRecentActivitiesFavorite(String firebaseUID) {
    return datasources.fetchRecentActivities(firebaseUID);
  }
}