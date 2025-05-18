import 'package:flutter/material.dart';
import 'package:saborpty_app/features/category/data/datasources/category_data_source.dart';
import 'package:saborpty_app/features/category/domain/entities/category.dart';
import 'package:saborpty_app/features/category/domain/repository/category_repository_impl.dart';
import 'package:saborpty_app/shared/widgets/recipe_category_card.dart';

class CategorylistScreen extends StatefulWidget {
  const CategorylistScreen({super.key});

  @override
  State<CategorylistScreen> createState() => _CategorylistScreenState();
}

class _CategorylistScreenState extends State<CategorylistScreen> { 
  late Future<List<Category>> _categories; 

  @override
  void initState() {
    super.initState();
      final repository = CategoryRepositoryImpl(CategoryDataSource());
       _categories = repository.getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
     return FutureBuilder<List<Category>>(
      future: _categories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final categories = snapshot.data ?? [];
        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          children: categories
              .map((cat) => RecipeCategoryCard(
                    nameCategory: cat.nameCategory,
                    placeHolder: cat.placeHolder,
                  ))
              .toList(),
        );
      },
    );
  
  }
}