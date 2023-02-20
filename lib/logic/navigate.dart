import 'package:bath_random/view/pages/main_list_page.dart';
import 'package:flutter/material.dart';
import '../view/pages/game_page.dart';
import '../view/pages/main_page.dart';

class Navigate extends StatefulWidget {
  const Navigate({super.key});

  @override
  State<Navigate> createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  // 自分が見ているページ
  var _selectedIndex = 1;

  static const _selectPage = [
    GamePage(),
    MainPage(),
    MainListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedIndex: _selectedIndex,
        animationDuration: const Duration(seconds: 1),
        elevation: 0,
        height: 70,
        backgroundColor: Colors.white,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const <Widget>[
          NavigationDestination(
              icon: Icon(Icons.sports_esports), label: 'game'),
          NavigationDestination(icon: Icon(Icons.home), label: 'home'),
          NavigationDestination(
              icon: Icon(Icons.format_list_bulleted), label: 'list'),
        ],
      ),
      body: _selectPage[_selectedIndex],
    );
  }
}
