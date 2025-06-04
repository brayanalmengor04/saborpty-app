import 'package:flutter/material.dart';
import 'package:saborpty_app/shared/widgets/menu/menu_widgets.dart';

class CategoryOptions extends StatefulWidget {
  const CategoryOptions({super.key});

  @override
  State<CategoryOptions> createState() => _CategoryOptionsState();
}

class _CategoryOptionsState extends State<CategoryOptions> { 
   int _selectedIndex = 1; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: MenuWidgets.appBar(context), 
     body: Center(
      child: Text("Category Menu"),
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
         floatingActionButton: MenuWidgets.floatingButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}