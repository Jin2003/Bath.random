import 'package:bath_random/logic/shared_preferences_logic.dart';
import 'package:bath_random/view/constant.dart';
import 'package:bath_random/view/pages/components/custom_button.dart';
import 'package:bath_random/view/pages/group_create_page.dart';
import 'package:bath_random/view/pages/qr_read_page.dart';
import 'package:flutter/material.dart';

import 'start_page.dart';

class GroupSelectPage extends StatelessWidget {
  const GroupSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.lightBlueColor,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                // groupを作る側が押すボタン
                CustomButton(
                  title: "グループを作る",
                  width: 210,
                  height: 60,
                  nextPage: GroupCreatePage(),
                ),
                SizedBox(height: 50),
                // user側が押すボタン
                CustomButton(
                  width: 210,
                  height: 60,
                  title: "グループに参加する",
                  nextPage: QrReadPage(),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            height: 80,
                            child: ListTile(
                                leading: const Icon(Icons.toggle_on_outlined),
                                title: const Text('デモ用データに移動'),
                                onTap: () {
                                  SharedPreferencesLogic sl =
                                      SharedPreferencesLogic();
                                  sl.moveDemo();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const StartPage(),
                                    ),
                                  );
                                }),
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.settings, color: Constant.lightGreyColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
