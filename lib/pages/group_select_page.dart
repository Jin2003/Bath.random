import 'package:bath_random/pages/components/custom_button.dart';
import 'package:bath_random/pages/group_create_page.dart';
import 'package:bath_random/pages/qr_read_page.dart';
import 'package:flutter/material.dart';

class GroupSelectPage extends StatelessWidget {
  const GroupSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 152, 233, 244),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            // groupを作る側が押すボタン
            CustomButton(
              title: "グループを作る",
              width: 120,
              height: 45,
              nextPage: GroupCreatePage(),
            ),
            SizedBox(height: 50),
            // user側が押すボタン
            CustomButton(
              width: 120,
              height: 45,
              title: "グループに参加する",
              nextPage: QrReadPage(),
            ),
          ],
        ),
      ),
    );
  }
}
