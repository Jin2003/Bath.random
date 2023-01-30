import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bath.random();'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.dehaze_rounded),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 152, 233, 244),
      body: const Center(
        child: Text('グループ参加'),
      ),
    );
  }
}
