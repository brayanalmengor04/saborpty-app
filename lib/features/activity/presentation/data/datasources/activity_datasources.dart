import 'package:saborpty_app/core/constants/api_routes.dart';
import 'package:saborpty_app/features/activity/presentation/data/models/activity_model.dart';
import 'package:http/http.dart' as http; 

class ActivityDatasources {
   Future<List<AcitivyDetailModel>> fetchRecentActivities(String firebaseUID) async {
    final response = await http.get(Uri.parse(ApiRoutes.pathActivityAction(firebaseUID)));

    if (response.statusCode == 200) {
      return acitivyDetailModelFromJson(response.body);
    } else {
      throw Exception('Error al cargar actividades');
    }
  }
  Future<void> deleteActivityByUser(String firebaseUID, int id) async {
  final url = Uri.parse(ApiRoutes.pathDeleteActivityByUser(firebaseUID, id));
  final response = await http.delete(url);
  if (response.statusCode != 200) {
    throw Exception('Error al eliminar la actividad');
  }
}
}