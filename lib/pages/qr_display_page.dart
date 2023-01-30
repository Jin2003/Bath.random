import 'package:bath_random/pages/components/custom_button.dart';
import 'package:bath_random/pages/group_create_page.dart';
import 'package:bath_random/pages/regi_comp_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:bath_random/pages/regi_comp_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QrDisplayPage extends StatefulWidget {
  final String userCounts; // ユーザーの登録人数

  const QrDisplayPage({super.key, required this.userCounts});

  @override
  State<QrDisplayPage> createState() => _QrDisplayPageState();
}

class _QrDisplayPageState extends State<QrDisplayPage> {
  static late String groupID; // 新規作成するグループのID
  final groupCollection = FirebaseFirestore.instance.collection('group');
  final userCollection = FirebaseFirestore.instance.collection('user');
  bool isAllResistered = false; // 全員登録したかどうか

  // groupを作成してfirestoreに登録する処理
  Future<void> createGroup() async {
    groupID = groupCollection.doc().id;
    groupCollection.doc(groupID).set({
      'groupID': groupID,
      'userCounts': int.parse(widget.userCounts),
      'isOrderFixed': false,
    });
  }

  @override
  Widget build(BuildContext context) {
    createGroup(); // groupを作成

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 152, 233, 244),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 250,
                height: 250,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegiCompPage(
                            groupID: groupID,
                          ),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    elevation: 0,
                  ),
                  child: const Text('ここにQR'),
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
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color.fromARGB(255, 255, 249, 249),
                fixedSize: const Size(210, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: const BorderSide(),
              ),
              onPressed: !isAllResistered
                  ? null
                  : () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegiCompPage(
                              groupID: groupID,
                            ),
                          ));
                    },
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
                  groupIDが一致するuserの数が、userCountsに達したら'すすむ'ボタン
                  グレーアウト -> 押せるようになる + resistation_complete_page(groupID)
                  */
                  var userCounts = int.parse(widget.userCounts);
                  if (userCounts - 1 == docs.length) {
                    isAllResistered = true;
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
