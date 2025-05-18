// Repository api 
import 'package:saborpty_app/features/category/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getAllCategories();
}