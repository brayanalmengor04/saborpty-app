import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:saborpty_app/features/achievement/presentation/achievement_list.dart';
import 'package:saborpty_app/features/activity/presentation/recent_activity_list.dart';
import 'package:saborpty_app/features/configuration/presentation/configuration_list.dart';
import 'package:saborpty_app/features/profile/presentation/profile_summary.dart';
import 'package:saborpty_app/shared/widgets/menu/menu_widgets.dart';


class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  int _selectedIndex = 3; 
  @override
  void initState() {
    super.initState();
    _refreshUser();
  } 
  void _refreshUser() async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.reload(); 
    setState(() {}); 
  }
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: MenuWidgets.appBar(context),
      body: user != null
          ? SingleChildScrollView( 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileSummary(user: user),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text("Logros Recientes", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: AchievementList(),
                  ),  
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: RecentActivityList(),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text("Configuración", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  const ConfigurationList(),

                ],
              ),
            )
          : const Center(child: Text('Usuario no autenticado')),
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
