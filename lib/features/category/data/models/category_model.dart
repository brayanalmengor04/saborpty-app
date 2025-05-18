// Api Json  
import 'package:saborpty_app/features/category/domain/entities/category.dart';

class CategoryModel extends Category {
   CategoryModel({required String nameCategory, required String placeHolder})
      : super(nameCategory: nameCategory, placeHolder: placeHolder); 

  
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      nameCategory: json['nameCategory'],
      placeHolder: json['placeHolder'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'nameCategory': nameCategory,
      'placeHolder': placeHolder,
    };    
  } 
  // Hacemos una conversion aqui . 
   Category toEntity() => Category(
        nameCategory: nameCategory,
        placeHolder: placeHolder,
      );
}