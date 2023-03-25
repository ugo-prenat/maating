import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maating/pages/login_page.dart';
import 'package:maating/pages/map_page.dart';
import 'package:maating/pages/register_page2.dart';
import 'package:maating/pages/user_profil_page.dart';
import '../main.dart';
import '../services/requestManager.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.successMsg});

  final String? successMsg;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1;

  final List<Widget> _children = [
    LoginPage(),
    MapPage(),
    UserProfilPage(userId: sp.getString('User')!)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
