import 'package:bath_random/view/constant.dart';
import 'package:bath_random/view/pages/group_select_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../logic/navigate.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  String? groupID;

  // groupIDがあるかチェック
  Future fetchID() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      groupID = prefs.getString('groupID');
    } catch (error) {
      return Future.error(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    // IDが保存されているかチェックƒ
    return FutureBuilder(
      future: fetchID(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _logoWidget(context, '通信中', null);
        }

        // IDデータがあったら
        if (!snapshot.hasData) {
          if (groupID == null) {
            // 登録がなかった場合
            return _logoWidget(context, 'グループ登録へ', const GroupSelectPage());
          } else {
            // 登録があった場合
            return _logoWidget(context, 'メインページへ', const Navigate());
          }
        }
        return _logoWidget(context, 'no data', null);
      },
    );
  }

  // ロゴを表示するウィジェット
  Widget _logoWidget(
      BuildContext context, String buttonTitle, Widget? nextPage) {
    return Scaffold(
      backgroundColor: Constant.lightBlueColor,

      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/start_page.png",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),

      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Align(
      //         alignment: const Alignment(0, 0.8),
      //         child: Text(
      //           "Bath.random();",
      //           style: GoogleFonts.orbitron(
      //             textStyle: const TextStyle(
      //               fontSize: 35,
      //               //fontWeight: FontWeight.bold,
      //               color: Colors.white,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),

      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton:
      //     CustomFAButton(buttonTitle: buttonTitle, nextPage: nextPage),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nextPage!),
            );
          },
          label: Text(buttonTitle)),
    );
  }
}
