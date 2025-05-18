import 'package:flutter/material.dart';
import 'package:saborpty_app/core/constants/app_colors.dart';
import 'package:saborpty_app/core/constants/app_styles.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
   @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10 , right: 10),
        child:  
        Column(
          children: [ 
            Padding(
              padding: const EdgeInsets.only(left: 3, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Today we suggest you",style: TextStyle(
                    fontSize: 25 ,
                    fontWeight: FontWeight.w600
                  ),)
                ],
              ),
            ),
            Container(
              height: 260,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.primary,
                boxShadow: AppStyles.boxShadowCard,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [ 
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    child: Stack(
                      children: [ 
                        // Imagen de la api de los mas visitados ... 
                        Image.asset("assets/category/category_soup.webp", width: double.infinity,height: 150,
                          fit: BoxFit.cover,
                        ),
                        // Conjunto de textos adentro de la imagen
                        Positioned(left: 12,bottom: 12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Sancocho Panameño",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "La sopa tradicional que cura todo mal",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
            
                  // Texto descriptivo
                  Padding(
                    padding: const EdgeInsets.all(12), 
            
                    // Description de sugerencia (recipe)
                    child: Text(
                      "Sancocho is a signature Panamanian dish, perfect for any occasion. A comforting soup with authentic flavors.",
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.borderRadius,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.schedule, size: 14, color: AppColors.textSecondary),
                              SizedBox(width: 4), 
                              // Time recipe preparacion
                              Text("45 min", style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        Row(
                          children: const [
                            Icon(Icons.star, color: AppColors.startColor, size: 14),
                            SizedBox(width: 4),
                            // Mas votados .....
                            Text("4.9", style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        Spacer(),
                        TextButton(
                          // Ver la receta  del sugerido api ()
                          onPressed: () {print("Okey");},
                          child: Text(
                            "See Recipe",
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}