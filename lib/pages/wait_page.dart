import 'package:bath_random/pages/components/custom_button.dart';
import 'package:bath_random/pages/main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WaitPage extends StatefulWidget {
  final String groupID;
  const WaitPage({super.key, required this.groupID});

  @override
  State<WaitPage> createState() => _WaitPageState();
}

class _WaitPageState extends State<WaitPage> {
  final userCollection = FirebaseFirestore.instance.collection('user');
  int? userCounts;

  // groupIDからグループの登録人数(予定)を取り出す処理
  // Future<void> fetchCounts() async {
  //   final groupDoc = await FirebaseFirestore.instance
  //       .collection('group')
  //       .doc(widget.groupID)
  //       .get();
  //   userCounts = await groupDoc.data()!['userCounts'];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 152, 233, 244),
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
                    print('userCounts:' + userCounts.toString());
                    return _registerBuilder(context);
                  } else {
                    return const Text('読み込み中');
                  }
                }),
            Text(
              '他の人の入力が終わるまでお待ちください',
              style: GoogleFonts.mPlusRounded1c(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(width: 100, height: 20),
            Text('groupID:${widget.groupID}')
          ],
        ),
      ),
    );
  }

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

        final docs = snapshot.data!.docs;

        /*
          全員の登録が完了したらボタンを押せるようになる
        */
        if (userCounts == docs.length) {
          // 登録された人数が、入力したuserCountsに達したとき
          children = <Widget>[
            const CustomButton(
              title: "すすむ",
              width: 120,
              height: 45,
              nextPage: MainPage(),
            ),
          ];
        } else if (userCounts! > docs.length) {
          children = <Widget>[
            const CustomButton(
              title: "人数分の登録完了まで\nしばらくお待ちください",
              width: 280,
              height: 70,
            )
          ];
        } else {
          // 入力したユーザの数より多い人数のデータが入力されたとき
          children = <Widget>[
            const CustomButton(
              title: "登録した人数が間違えています",
              width: 120,
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
