import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

class RegiAccountPage extends StatefulWidget {
  final String groupID;
  const RegiAccountPage({super.key, required this.groupID});

  @override
  State<RegiAccountPage> createState() => _RegiAccountPageState();
}

class _RegiAccountPageState extends State<RegiAccountPage> {
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
