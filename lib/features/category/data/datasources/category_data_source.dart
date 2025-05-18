
import 'package:saborpty_app/features/category/data/models/category_model.dart';

class CategoryDataSource {
  Future<List<CategoryModel>> fetchCategories () async {
    // Aqui puedo hacer la logica de api para obtener los datos usare datos estaticos por ahora 
     
     // Simular un delay 
    return[
      CategoryModel(nameCategory: "Soup", placeHolder: "assets/category/category_soup.webp"),
      CategoryModel(nameCategory: "Tradicional", placeHolder: "assets/category/category_traditional.webp"),
      CategoryModel(nameCategory: "Seafood", placeHolder: "assets/category/category_seafood.webp"),
      CategoryModel(nameCategory: "Desserts", placeHolder: "assets/category/category_desserts.webp"),
      CategoryModel(nameCategory: "Quick Dishes", placeHolder: "assets/category/category_quicksdishes.webp"),
      CategoryModel(nameCategory: "Typical Drinks", placeHolder: "assets/category/category_typicaldrinks.webp"),
    ];
  }
}