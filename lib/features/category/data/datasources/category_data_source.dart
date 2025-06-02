
import 'package:saborpty_app/features/category/data/models/category_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; 

class CategoryDataSource {

  final String baseUrl ='https://saborpty-backend-production.up.railway.app/api/v1/categories';
  Future<List<CategoryModel>> getCategories() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar las categorías');
    }
  }


}