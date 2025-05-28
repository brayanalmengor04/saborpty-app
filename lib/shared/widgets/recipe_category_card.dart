import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:saborpty_app/core/constants/app_styles.dart';

class RecipeCategoryCard extends StatefulWidget {
  final String nameCategory;
  final String placeHolder;
  final VoidCallback? onTap;

  const RecipeCategoryCard({
    super.key,
    required this.nameCategory,
    required this.placeHolder,
    this.onTap,
  });

  @override
  State<RecipeCategoryCard> createState() => _RecipeCategoryCardState();
}

class _RecipeCategoryCardState extends State<RecipeCategoryCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 150,
        height: 150,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          boxShadow: AppStyles.boxShadowCard,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            // Imagen de fondo con un placeholder plano y sin spinner
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: widget.placeHolder,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
               placeholder: (context, url) => Image.network(
                  'https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg', // Imagen remota como placeholder
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.error, color: Colors.redAccent),
                ),
              ),
            ),

            // Degradado sobre la imagen
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xAA000000),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            // Texto de categoría centrado
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  widget.nameCategory,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black45,
                        blurRadius: 4,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // Efecto visual de toque
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                splashColor: Colors.white24,
                onTap: widget.onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
