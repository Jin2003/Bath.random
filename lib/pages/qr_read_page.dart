import 'package:bath_random/pages/components/custom_button.dart';
import 'package:bath_random/pages/group_select_page.dart';
import 'package:bath_random/pages/regi_account_page.dart';
import 'package:flutter/material.dart';

class QrReadPage extends StatefulWidget {
  const QrReadPage({super.key});

  @override
  State<QrReadPage> createState() => _QrReadPageState();
}

class _QrReadPageState extends State<QrReadPage> {
  get child => null;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 152, 233, 244),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // TODO
            const CustomButton(
                title: 'カメラ起動',
                nextPage: RegiAccountPage(
                  groupID: "test",
                )),
            const SizedBox(
              width: 100,
              height: 20,
            ),
            const CustomButton(title: 'もどる', nextPage: GroupSelectPage()),
          ],
        ),
      ),
    );
  }
}
