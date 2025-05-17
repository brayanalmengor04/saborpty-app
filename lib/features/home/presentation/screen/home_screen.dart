import 'package:flutter/material.dart';
import 'package:saborpty_app/core/constants/app_colors.dart';

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
      body: Center( 
        child: Text("Hello World ALL Okey\nIndex seleccionado: $_selectedIndex"),
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }
  
// Limpiar un poco el codigo  -> Previsto pasarlo si deseo conservar en otras ventanas 
  AppBar appBar() {
    return AppBar(title: const Text('Sabor Panameño',style: TextStyle(color: AppColors.textSecondary,fontWeight: FontWeight.bold  ,fontSize: 30),
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
      unselectedItemColor: AppColors.textSecondary,
      selectedItemColor: AppColors.textSecondary,
      onTap: _onItemTapped,
    );
  }
}
