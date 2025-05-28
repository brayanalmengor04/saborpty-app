import 'package:flutter/material.dart';
import 'package:saborpty_app/shared/widgets/menu/menu_widgets.dart';

class FavoritesOptions extends StatefulWidget {
  const FavoritesOptions({super.key});

  @override
  State<FavoritesOptions> createState() => _FavoritesOptionsState();
}

class _FavoritesOptionsState extends State<FavoritesOptions> {
 int _selectedIndex = 2; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: MenuWidgets.appBar(context), 
     body: Center(
      child: Text("Favorite Menu"),
     ), 
     bottomNavigationBar: MenuWidgets.bottomNavigationBar(
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
}