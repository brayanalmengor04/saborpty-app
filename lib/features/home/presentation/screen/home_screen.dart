import 'package:flutter/material.dart';
import 'package:saborpty_app/core/constants/app_colors.dart';
import 'package:saborpty_app/features/category/presentation/categorylist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: AppColors.background,
      appBar: appBar(), 
      body: ListView(
        children: [
         // Category ---->  
          Column( 
            children: [  
                 // Search ---->
              Padding(
                padding: const EdgeInsets.only(top: 25 , right: 10, left: 10 , bottom: 10),
                child: textFieldSearch(),
              ), 

              Text("Category"),
              Padding(
                padding: const EdgeInsets.only(top: 25 , right: 10, left: 10 , bottom: 10), 
                // Recibir todos los datos desde una data o api creada ( podemos usar datos estaticos por ahora)
                child: CategorylistScreen(),
              ), 
            ],
          )
        ],
      ) ,
      bottomNavigationBar: bottomNavigationBar(),
    );
  }
  TextField textFieldSearch() {
    return TextField(
            decoration: InputDecoration(
              hintText: "¿What do you want to cook today?", 
              hintStyle: TextStyle(color: AppColors.accent),
              prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
              filled: true,
              fillColor: Color(0xFFFFF1E6), // Color durazno claro similar a la imagen
              contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide.none,
              ),
            ),
            style: TextStyle(color: AppColors.accent),
          );
  }
// Limpiar un poco el codigo  -> Previsto pasarlo si deseo conservar en otras ventanas 
  AppBar appBar() {
    return AppBar(title: const Text('Sabor Panameño',style: TextStyle(color: AppColors.textSecondary,fontWeight: FontWeight.bold  ,fontSize: 26),
    ),
    elevation: 1,
    shadowColor: AppColors.accent, 
    actions: [
      IconButton(onPressed: (){
        print("All Okey");
      }, icon: Icon(Icons.face_retouching_natural),
      color: AppColors.textSecondary, 
      ) 
    ],
    );
  }
  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(          
      backgroundColor: AppColors.primary,  
      type:  BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[ 
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Category',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Saved',
        ), 
        BottomNavigationBarItem(
          icon: Icon(Icons.face_retouching_natural_outlined),
          label: 'Perfil',
        ),
      ],
      currentIndex: _selectedIndex,  
      unselectedItemColor: AppColors.accent,
      selectedItemColor: AppColors.textSecondary,
      onTap: _onItemTapped,
    );
  }
}
