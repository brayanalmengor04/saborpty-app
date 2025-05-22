
import 'package:saborpty_app/features/category/data/models/category_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; 

class CategoryDataSource {
  // Future<List<CategoryModel>> fetchCategories () async {
  //   // Aqui puedo hacer la logica de api para obtener los datos usare datos estaticos por ahora 
     
  //    // Simular un delay 
  //   return[
  //     CategoryModel(nameCategory: "Soup", placeHolder: "assets/category/category_soup.webp"),
  //     CategoryModel(nameCategory: "Tradicional", placeHolder: "assets/category/category_traditional.webp"),
  //     CategoryModel(nameCategory: "Seafood", placeHolder: "assets/category/category_seafood.webp"),
  //     CategoryModel(nameCategory: "Desserts", placeHolder: "assets/category/category_desserts.webp"),
  //     CategoryModel(nameCategory: "Quick Dishes", placeHolder: "assets/category/category_quicksdishes.webp"),
  //     CategoryModel(nameCategory: "Typical Drinks", placeHolder: "assets/category/category_typicaldrinks.webp"),
  //   ];
  // }} 
  //  final String baseUrl = 'http://127.0.0.1:8000/api/v1/categories';
  final String baseUrl = 'http://localhost:8000/api/v1/categories';

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