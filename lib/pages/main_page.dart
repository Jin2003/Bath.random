import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: Text(
            'Bath.random();',
            style: GoogleFonts.mPlusRounded1c(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.dehaze_rounded),
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 152, 233, 244),
      body: Card(
        color: Colors.white, // Card自体の色
        margin: const EdgeInsets.fromLTRB(40, 90, 40, 120),
        elevation: 10,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: const [
            ListTile(
              leading: Icon(Icons.people),
              title: Text('kei'),
              subtitle: Text('18:00-19:00'),
              trailing: Text('1hour'),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('kei'),
              subtitle: Text('18:00-19:00'),
              trailing: Text('1hour'),
            ),
          ],
        ),
      ),
    );
  }
}
