import 'package:saborpty_app/features/category/data/datasources/category_data_source.dart';
import 'package:saborpty_app/features/category/domain/entities/category.dart';

import 'package:saborpty_app/features/category/domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository { 

  final CategoryDataSource dataSource;  

  // Inicializo los datoObtenidos JSON
  CategoryRepositoryImpl(this.dataSource);

  @override
  Future<List<Category>> getAllCategories() async {
    // TODO: implement getAllCategories
    return (await dataSource.fetchCategories())
    .map((model) => model.toEntity())
    .toList();
  }

}