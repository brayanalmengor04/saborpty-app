import 'package:flutter/material.dart';
import 'package:saborpty_app/shared/widgets/custom/cards/category/featured_category_card.dart';
import 'package:saborpty_app/shared/widgets/custom/cards/category/grid_category_card.dart';
import 'package:saborpty_app/shared/widgets/menu/menu_widgets.dart';
import 'package:saborpty_app/features/category/domain/repository/category_repository_impl.dart';
import 'package:saborpty_app/features/category/data/models/category_model.dart';
import 'package:saborpty_app/shared/widgets/title/section_title.dart';

class CategoryOptions extends StatefulWidget {
  const CategoryOptions({super.key});

  @override
  State<CategoryOptions> createState() => _CategoryOptionsState();
}

class _CategoryOptionsState extends State<CategoryOptions> {
  int _selectedIndex = 1;
  final _repo = CategoryRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MenuWidgets.appBar(context),
      body: FutureBuilder<List<CategoryModel>>(
        future: _repo.getAllCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Ocurrió un error al cargar las categorías'));
          }
          final categories = snapshot.data ?? [];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔍 Buscador
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar categorías...',
                      border: InputBorder.none,
                      icon: Icon(Icons.search, color: Colors.deepOrange),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

               const SectionTitle('Destacadas'),
                const SizedBox(height: 10),
                Column(
                  children: categories.take(2).map((cat) {
                    return FeaturedCategoryCard(category: cat);
                  }).toList(),
                ),
                const SizedBox(height: 25),
                // 📋 Todas las Categorías
                const SectionTitle('Todas las Categorías'),
                const SizedBox(height: 10),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.2,
                  children: categories.map((cat) {
                    return GridCategoryCard(category: cat);
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: MenuWidgets.bottomNavigationBar(
        context: context,
        currentIndex: _selectedIndex,
        onTabChanged: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      floatingActionButton: MenuWidgets.floatingButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
