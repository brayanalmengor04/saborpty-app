import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:saborpty_app/shared/widgets/menu/menu_widgets.dart';

class OtherOptions extends StatefulWidget {
  const OtherOptions({super.key});

  @override
  State<OtherOptions> createState() => _OtherOptionsState();
}

class _OtherOptionsState extends State<OtherOptions> {
    var _selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MenuWidgets.appBar(context),
      body: Center(child: Text("Otra options"),),
      
      bottomNavigationBar: MenuWidgets.bottomNavigationBar(context: context, currentIndex: _selectedIndex, onTabChanged:
         (int index) {
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