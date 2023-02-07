import 'package:bath_random/pages/components/custom_button.dart';
import 'package:bath_random/pages/components/custom_text.dart';
import 'package:bath_random/pages/main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WaitPage extends StatefulWidget {
  final String groupID;
  const WaitPage({
    super.key,
    required this.groupID,
  });

  @override
  State<WaitPage> createState() => _WaitPageState();
}

class _WaitPageState extends State<WaitPage> {
  final userCollection = FirebaseFirestore.instance.collection('user');
  int? userCounts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 150, 222, 231),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('group')
                    .doc(widget.groupID)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    userCounts = snapshot.data!['userCounts'];

                    // debug
                    if (kDebugMode) {
                      print('wait_page');
                      print('userCounts:$userCounts');
                      print('groupID:${widget.groupID}');
                    }

                    return _registerBuilder(context);
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
            const SizedBox(width: 100, height: 20),
          ],
        ),
      ),
    );
  }

  // groupに登録されたユーザー数を読み込んだ後のウィジェット
  Widget _registerBuilder(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: userCollection
          .where('groupID', isEqualTo: widget.groupID)
          .snapshots(),
      builder: ((context, snapshot) {
        List<Widget> children;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (!snapshot.hasData) {
          return const Text('データがありません');
        }
        // グループのドキュメント（データ）
        final docs = snapshot.data!.docs;

        /*
          全員の登録が完了したらボタンを押せるようになる
        */
        if (userCounts == docs.length) {
          // 登録された人数が、入力したuserCountsに達したとき
          children = <Widget>[
            Text(
              '登録完了しました',
              style: GoogleFonts.mPlusRounded1c(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 40),
            const CustomButton(
              title: "すすむ",
              width: 120,
              height: 45,
              nextPage: MainPage(),
            ),
          ];
        } else if (userCounts! > docs.length) {
          var remainMem = userCounts! - docs.length;
          children = <Widget>[
            Container(),
            const CustomText(text: 'のこり', fontSize: 30),
            CustomText(text: remainMem.toString(), fontSize: 60),
            const CustomText(text: '人', fontSize: 30),
            const SizedBox(height: 50),
            const Center(
              child: CustomText(text: '他の人の入力が終わるまで\nお待ちください', fontSize: 20),
            ),
            const SizedBox(height: 30),
          ];
        } else {
          // 入力したユーザの数より多い人数のデータが入力されたとき
          children = <Widget>[
            const CustomButton(
              title: "登録した人数が間違えています",
              width: 200,
              height: 45,
            ),
          ];
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        );
      }),
    );
  }
}
