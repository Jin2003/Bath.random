import 'package:bath_random/pages/components/custom_button.dart';
import 'package:bath_random/pages/group_create_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QrDisplayPage extends StatefulWidget {
  final String userCounts;

  const QrDisplayPage({super.key, required this.userCounts});

  @override
  State<QrDisplayPage> createState() => _QrDisplayPageState();
}

class _QrDisplayPageState extends State<QrDisplayPage> {
  static late String groupID; // 新規作成するグループのID
  final groupCollection = FirebaseFirestore.instance.collection('group');
  final userCollection = FirebaseFirestore.instance.collection('user');

  // groupを作成してfirestoreに登録する処理
  Future<void> createGroup() async {
    groupID = groupCollection.doc().id;
    groupCollection.doc(groupID).set({
      'groupID': groupID,
      'userCounts': int.parse(widget.userCounts),
      'isOrderDecided': false,
    });
  }

  @override
  Widget build(BuildContext context) {
    createGroup();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 152, 233, 244),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // ここにQR!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
              width: 250,
              height: 250,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "ここにQR\n" + groupID,
                style: GoogleFonts.mPlusRounded1c(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
            const SizedBox(
              width: 100,
              height: 20,
            ),
            Text(
              "(共有相手)\n1.Bath.random();をダウンロード\n\n"
              "2.上のQRコードをスマホのカメラまたは\n　QRコードアプリでスキャン\n\n"
              "3.アカウントを作成",
              style: GoogleFonts.mPlusRounded1c(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              width: 100,
              height: 20,
            ),
            Container(
              width: 210,
              height: 70,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: userCollection
                    .where('groupID', isEqualTo: groupID)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (!snapshot.hasData) {
                    return const Text('データがありません');
                  }

                  final docs = snapshot.data!.docs;

                  // debug
                  if (kDebugMode) {
                    for (int i = 0; i < docs.length; i++) {
                      var doc = docs[i];
                      print("debug:[groupID]" +
                          doc['groupID'] +
                          " [userName]" +
                          doc['userName']);
                    }
                  }
                  /*
                  TODO: groupIDが一致するuserの数が、userCountsに達したら'すすむ'ボタン
                  グレーアウト -> 押せるようになる + resistation_complete_page(groupID)
                  */
                  var userCounts = int.parse(widget.userCounts);
                  if (userCounts - 1 == docs.length) {
                    return const Text('すすむ');
                  }

                  return Text("人数分の登録完了まで\nしばらくお待ちください",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mPlusRounded1c(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ));
                },
              ),
            ),
            const SizedBox(
              width: 100,
              height: 20,
            ),
            CustomButton(
              title: 'もどる',
              nextPage: GroupCreatePage(deleteGroupId: groupID),
            )
          ],
        ),
      ),
    );
  }
}
