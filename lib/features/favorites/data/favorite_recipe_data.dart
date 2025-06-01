
import 'package:saborpty_app/features/favorites/domain/favorite_recipe.dart';

final List<FavoriteRecipe> mockFavoriteRecipes = [
  FavoriteRecipe(
    title: 'Sancocho Panameño',
    category: 'Sopas',
    timeMinutes: 45,
    rating: 4.9,
    cooked: true,
    savedSince: 'Guardada hace 3 días',
  ),
  FavoriteRecipe(
    title: 'Arroz con Pollo',
    category: 'Tradicionales',
    timeMinutes: 45,
    rating: 4.8,
    cooked: false,
    savedSince: 'Guardada hace 7 días',
  ),
];
