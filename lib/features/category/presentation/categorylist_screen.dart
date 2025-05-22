import 'package:flutter/material.dart';
import 'package:saborpty_app/features/category/data/models/category_model.dart';
import 'package:saborpty_app/features/category/domain/repository/category_repository_impl.dart';
import 'package:saborpty_app/shared/widgets/recipe_category_card.dart';

class CategorylistScreen extends StatefulWidget {
  const CategorylistScreen({super.key});

  @override
  State<CategorylistScreen> createState() => _CategorylistScreenState();
}

class _CategorylistScreenState extends State<CategorylistScreen> { 

  final _repo = CategoryRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel>>(
      future: _repo.getAllCategories(),
      builder: (context, snapshot) {  
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Loading
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

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
                          nameCategory: cat.name ?? 'File Not Fount',
                          placeHolder: cat.imageUrl ?? 'https://uning.es/wp-content/uploads/2016/08/ef3-placeholder-image.jpg',
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
