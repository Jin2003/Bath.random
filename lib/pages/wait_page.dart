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
  void fetchCounts() async {
    final groupDoc = await FirebaseFirestore.instance
        .collection('group')
        .doc(widget.groupID)
        .get();
    userCounts = groupDoc.data()!['userCounts'];
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 152, 233, 244),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '他の人の入力が終わるまでお待ちください',
                style: GoogleFonts.mPlusRounded1c(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(width: 100, height: 20),
              StreamBuilder<QuerySnapshot>(
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
                    // TODO: 登録したユーザの数が多すぎるとき
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
              ),
              Text("userCounts:$userCounts"),
              Text('groupID:${widget.groupID}')
            ],
          ),
        ));
  }
}
