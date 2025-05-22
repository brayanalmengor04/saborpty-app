import 'package:saborpty_app/features/category/data/datasources/category_data_source.dart';
import 'package:saborpty_app/features/category/data/models/category_model.dart';
import 'package:saborpty_app/features/category/domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository{
  final CategoryDataSource dataSource = CategoryDataSource();


  // Implemento todo para obtener todas las categorias
  @override
  Future<List<CategoryModel>> getAllCategories()=> dataSource.getCategories();
 
}