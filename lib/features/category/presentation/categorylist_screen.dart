import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:saborpty_app/features/category/data/models/category_model.dart';
import 'package:saborpty_app/features/category/domain/repository/category_repository_impl.dart';
import 'package:saborpty_app/shared/widgets/shimmer/shimmer_category_card.dart';
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
          return GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            children: List.generate(
              6,
              (index) => const ShimmerCategoryCard(),
            ),
          );
        }

        // Mostrar mensaje si ocurre un error
        if (snapshot.hasError) {
          return Center(child: Text('Ocurrió un error al cargar las categorías'));
        }

        final categories = snapshot.data ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                'Category',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              children: categories
                  .map(
                    (cat) => RecipeCategoryCard(
                      nameCategory: cat.name ?? 'No Name',
                      placeHolder: cat.imageUrl ??
                          'https://uning.es/wp-content/uploads/2016/08/ef3-placeholder-image.jpg',
                     onTap: () => context.push(
                      '/category-detail/${cat.name}?imageUrl=${Uri.encodeComponent(cat.imageUrl ?? '')}',
                      ),
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
