import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GroupJoinPage extends StatefulWidget {
  const GroupJoinPage({super.key});

  @override
  State<GroupJoinPage> createState() => _GroupJoinPageState();
}

class _GroupJoinPageState extends State<GroupJoinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 83, 221, 251),
      body: Center(
        child: Container(
          child: Text('グループ参加'),
        ),
      ),
    );
  }
}
