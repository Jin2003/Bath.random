import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bath.random',
              style: TextStyle(
                fontSize: 40,
                //fontFamily: ,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
