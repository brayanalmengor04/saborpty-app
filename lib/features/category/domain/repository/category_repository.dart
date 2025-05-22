// Repository api 
import 'package:saborpty_app/features/category/data/models/category_model.dart';

abstract class CategoryRepository {
  Future<List<CategoryModel>> getAllCategories();
}