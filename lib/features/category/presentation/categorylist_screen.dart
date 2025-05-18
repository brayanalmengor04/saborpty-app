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
        // Le addjuntamos una carga para ver el estado de la conexion
        if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
        final categories = snapshot.data ?? [];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10,bottom: 10),
              child: Row( 
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Category',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              children: 
              // Hay que manejar lo del tema de pantallas de la categoria
                  categories
                      .map(
                        (cat) => RecipeCategoryCard(
                          nameCategory: cat.nameCategory,
                          placeHolder: cat.placeHolder,
                        ),
                      )
                      .toList(),
            ),
          ],
        );
      },
    );
  }
}
