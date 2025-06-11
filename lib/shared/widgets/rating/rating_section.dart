import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
class RatingSection extends StatefulWidget {
  final double initialRating;
  final int recipeId;
  final String firebaseUid;
  final Function(double) onConfirmedRating;

  const RatingSection({
    super.key,
    required this.initialRating,
    required this.recipeId,
    required this.firebaseUid,
    required this.onConfirmedRating,
  });

  @override
  State<RatingSection> createState() => _RatingSectionState();
}

class _RatingSectionState extends State<RatingSection> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StarRating(
            size: 32.0,
            rating: _currentRating,
            color: Colors.amber,
            borderColor: Colors.grey.shade400,
            starCount: 5,
            onRatingChanged: (rating) async {
              final bool shouldRate = await _showConfirmationDialog(context);
              if (shouldRate) {
                setState(() {
                  _currentRating = rating;
                });
                widget.onConfirmedRating(rating);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Gracias por calificar ⭐️"),
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.greenAccent,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text("¿Deseas calificar esta receta?"),
            content: const Text("Tu calificación ayudará a otros usuarios."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text("Cancelar"),
              ),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(ctx, true),
                icon: const Icon(Icons.check),
                label: const Text("Aceptar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}
