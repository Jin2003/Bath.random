import 'package:bath_random/view/constant.dart';
import 'package:bath_random/view/pages/main_list_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../view/pages/game_page.dart';
import '../view/pages/main_page.dart';

class Navigate extends StatefulWidget {
  const Navigate({super.key});

  @override
  State<Navigate> createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  // 自分が見ているページ
  int _selectedIndex = 1;

  static const _selectPage = [
    GamePage(),
    MainPage(),
    MainListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110.0),
        child: AppBar(
          title: Text(
            'Bath.random();',
            style: GoogleFonts.mPlusRounded1c(
              fontWeight: FontWeight.bold,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/parts/appbar.png'),
                  fit: BoxFit.cover),
            ),
          ),
          elevation: 0,
          backgroundColor: Constant.lightBlueColor,

          // centerTitle: true,
          // automaticallyImplyLeading: false,
          // backgroundColor: Colors.white,
          // elevation: 0,
        ),
      ),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/parts/bottom_navigation_bar.png'),
          ),
          _selectPage[_selectedIndex],
        ],
      ),
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
              icon: Icon(Icons.format_list_bulleted), label: 'otther'),
        ],
      ),
    );
  }
}
