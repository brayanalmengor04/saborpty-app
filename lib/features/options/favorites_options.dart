import 'package:flutter/material.dart';
import 'package:saborpty_app/features/favorites/data/favorite_recipe_data.dart';
import 'package:saborpty_app/shared/widgets/favorite/favorite_card.dart';
import 'package:saborpty_app/shared/widgets/menu/menu_widgets.dart';

class FavoritesOptions extends StatefulWidget {
  const FavoritesOptions({super.key});

  @override
  State<FavoritesOptions> createState() => _FavoritesOptionsState();
}

class _FavoritesOptionsState extends State<FavoritesOptions> {
  int _selectedIndex = 2;
  int _selectedFilter = 0;
  final List<String> filters = ['Todas', 'Favoritas', 'Cocinadas', 'Por cocinar'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        title: const Text(
          'Mis Recetas',
          style: TextStyle(
            color: Color(0xFFDC5F00),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Color(0xFFDC5F00)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Buscador
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar receta...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color(0xFFFFF3E6),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCounter(Icons.bookmark_outline, "Guardadas", "12"),
                _buildCounter(Icons.local_dining_outlined, "Cocinadas", "8"),
                _buildCounter(Icons.star_outline, "Promedio", "4.8"),
              ],
            ),
          ),

          const SizedBox(height: 12),

         // Filtros con chips en carrusel horizontal
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: SizedBox(
              height: 40,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(filters.length, (index) {
                    final isSelected = _selectedFilter == index;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(filters[index]),
                        selected: isSelected,
                        selectedColor: const Color(0xFFDC5F00),
                        backgroundColor: const Color(0xFFEFEFEF),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        onSelected: (_) {
                          setState(() {
                            _selectedFilter = index;
                          });
                        },
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Lista de Cards
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: mockFavoriteRecipes.length,
              itemBuilder: (context, index) {
                return FavoriteCard(recipe: mockFavoriteRecipes[index]);
              },
            ),
          ),
        ],
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
    );
  }

  Widget _buildCounter(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Color(0xFFDC5F00), size: 26),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
