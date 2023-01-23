import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 83, 221, 251),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bath.random();',
              style: GoogleFonts.montserratAlternates(
                textStyle: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
