import 'package:flutter/material.dart';

class QrReadPage extends StatefulWidget {
  const QrReadPage({super.key});

  @override
  State<QrReadPage> createState() => _QrReadPageState();
}

class _QrReadPageState extends State<QrReadPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 152, 233, 244),
      body: const Center(
        child: Text('グループ参加'),
      ),
    );
  }
}
