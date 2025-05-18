import 'package:flutter/material.dart';
import 'app_colors.dart'; // Asegúrate de tener AppColors definido

class AppStyles {
  static List<BoxShadow> boxShadowCard = [
    BoxShadow(
      color: AppColors.shawdowCard, 
      blurRadius: 10,
      offset: Offset(0, 4),
    ),
  ]; 

   static EdgeInsets paddingCard = EdgeInsets.only(
    top: 25,
    right: 10,
    left: 10,
    bottom: 10,
  );
}
