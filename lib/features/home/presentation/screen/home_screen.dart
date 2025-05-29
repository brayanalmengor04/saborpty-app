import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saborpty_app/core/constants/app_colors.dart';
import 'package:saborpty_app/core/constants/app_styles.dart';
import 'package:saborpty_app/features/category/presentation/categorylist_screen.dart';
import 'package:saborpty_app/features/recipes/presentation/recipelist_screen.dart';
import 'package:saborpty_app/features/suggestion/presentation/suggestion_screen.dart';
import 'package:saborpty_app/shared/widgets/menu/menu_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {  

  final user = FirebaseAuth.instance.currentUser;
  int _selectedIndex = 0; 
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: AppColors.background,
      appBar: MenuWidgets.appBar(context), 
      body: ListView(
        children: [
         // Category ---->  
          Column( 
            children: [   
                 // Search ---->
              Padding(
                padding: AppStyles.paddingCard,
                child: textFieldSearch(),
              ),  
               Padding(padding: AppStyles.paddingCard,child: SuggestionScreen(),
              ),  
              Padding(padding: AppStyles.paddingCard, child: CategorylistScreen(),
              ),  
               Padding(padding: AppStyles.paddingCard,  child: RecipelistScreen(),
              ), 
            ],
          )
        ],
      ) ,
      bottomNavigationBar:MenuWidgets.bottomNavigationBar(
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
  TextField textFieldSearch() {
    return TextField(
            decoration: InputDecoration(
              hintText: "¿What do you want to cook today?", 
              hintStyle: TextStyle(color: AppColors.accent),
              prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
              filled: true,
              fillColor: AppColors.borderRadius, // Color durazno claro similar a la imagen
              contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(color: AppColors.accent),
          );
  }
}
