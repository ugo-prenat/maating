import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maating/pages/events_page.dart';
import 'package:maating/pages/map_page.dart';
import 'package:maating/pages/user_profil_page.dart';
import '../main.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.successMsg});

  final String? successMsg;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1;

  final List<Widget> _children = [
    EventsPage(),
    MapPage(),
    UserProfilPage(
      userId: sp.getString('User')!,
      goBack: false,
    )
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
            icon: Icon(CupertinoIcons.calendar),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
