import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
final List<PageViewModel> introductionPages = [
  PageViewModel(
    title: "Bienvenido a",
    bodyWidget: Column(
      children: [
        const SizedBox(height: 16),
        Text(
          "SaborPTY",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: Colors.deepOrangeAccent,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Descubre el sabor auténtico de Panamá con recetas tradicionales de cada rincón del país.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, height: 1.5, color: Colors.grey.shade700),
        ),
      ],
    ),
    image: Image.network(
      'https://res.cloudinary.com/dv5ruetn7/image/upload/v1747621022/cld-sample-3.jpg',
      height: 220,
    ),
    decoration: const PageDecoration(
      imageFlex: 3,
      bodyFlex: 2,
      titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),
      contentMargin: EdgeInsets.symmetric(horizontal: 24),
    ),
  ),
  PageViewModel(
    title: "Historias en cada receta",
    bodyWidget: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        "Del arroz con pollo al sancocho: revive tradiciones familiares en cada bocado.",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, height: 1.5, color: Colors.grey.shade700),
      ),
    ),
    image: Image.network(
      'https://res.cloudinary.com/dv5ruetn7/image/upload/v1747621022/cld-sample-5.jpg',
      height: 220,
    ),
    decoration: const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
    ),
  ),
  PageViewModel(
    title: "Tu cocina, tu sazón",
    bodyWidget: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        "Crea, guarda y cocina tus recetas favoritas. ¡Haz del sabor panameño parte de ti!",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, height: 1.5, color: Colors.grey.shade700),
      ),
    ),
    image: Image.network(
      'https://res.cloudinary.com/dv5ruetn7/image/upload/v1747621021/cld-sample.jpg',
      height: 220,
    ),
    decoration: const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
    ),
  ),
];
