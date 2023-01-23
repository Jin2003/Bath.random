import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GroupCreatePage extends StatefulWidget {
  @override
  State<GroupCreatePage> createState() => _GroupCreatePageState();
}

class _GroupCreatePageState extends State<GroupCreatePage> {
  var selectedValue = "4";

  final lists = <String>["2", "3", "4", "5", "6"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 83, 221, 251),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('家族の人数'),
              DropdownButton<String>(
                value: selectedValue,
                items: lists
                    .map((String list) =>
                        DropdownMenuItem(value: list, child: Text(list)))
                    .toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedValue = value!;
                  });
                },
              ),
              OutlinedButton(
                child: const Text('登録'),
                style: OutlinedButton.styleFrom(
                  primary: Colors.black,
                  shape: const StadiumBorder(),
                  side: const BorderSide(color: Colors.green),
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => GroupJoinPage(),
                  //   ),
                  // );
                },
              ),
              OutlinedButton(
                child: const Text('もどる'),
                style: OutlinedButton.styleFrom(
                  primary: Colors.black,
                  shape: const StadiumBorder(),
                  side: const BorderSide(color: Colors.green),
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => GroupJoinPage(),
                  //   ),
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
