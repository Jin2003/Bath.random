import 'dart:developer';

import 'package:bath_random/view/constant.dart';
import 'package:bath_random/view/pages/components/custom_button.dart';
import 'package:bath_random/view/pages/components/custom_text.dart';
import 'package:bath_random/view/pages/group_create_page.dart';
import 'package:bath_random/view/pages/regi_account_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrDisplayPage extends StatefulWidget {
  final String userCounts; // ユーザーの登録人数

  const QrDisplayPage({super.key, required this.userCounts});

  @override
  State<QrDisplayPage> createState() => _QrDisplayPageState();
}

class _QrDisplayPageState extends State<QrDisplayPage> {
  // 新規作成するグループのID
  late String groupID;
  // Firestoreのコレクションを定義
  final groupCollection = FirebaseFirestore.instance.collection('group');
  final userCollection = FirebaseFirestore.instance.collection('user');

  // groupを作成してfirestoreに登録する処理
  Future<void> createGroup() async {
    groupID = groupCollection.doc().id;
    groupCollection.doc(groupID).set({
      'groupID': groupID,
      'userCounts': int.parse(widget.userCounts),
      'isSetOrder': false,
    });
  }

  @override
  Widget build(BuildContext context) {
    // groupを作成
    createGroup();

    return Scaffold(
      backgroundColor: Constant.lightBlueColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 250,
                height: 250,
                child: Container(
                  width: 250,
                  height: 250,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: QrImage(
                    data: groupID,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 100,
              height: 20,
            ),
            const CustomText(
              text: "　(共有相手)\n1.Bath.random();をダウンロード\n"
                  "2.上のQRコードをスマホのカメラまたは\n　QRコードアプリでスキャン\n"
                  "3.アカウントを作成",
              fontSize: 16,
            ),
            const SizedBox(
              width: 100,
              height: 35,
            ),
            // ユーザーが登録した人数を検知してウィジェットを表示
            StreamBuilder<QuerySnapshot>(
              stream: userCollection
                  .where('groupID', isEqualTo: groupID)
                  .snapshots(),
              builder: (context, snapshot) {
                List<Widget> children;

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (!snapshot.hasData) {
                  return const Text('データがありません');
                }

                final docs = snapshot.data!.docs;
                var userCounts = int.parse(widget.userCounts);

                // debug
                if (kDebugMode) {
                  log('groupID: $groupID');
                  log('userCounts: ${widget.userCounts}');
                }

                // 登録したユーザの数がuserCounts(入力した値)に達したら'すすむ'
                if (userCounts - 1 == docs.length) {
                  children = <Widget>[
                    CustomButton(
                      title: "すすむ",
                      width: 120,
                      height: 45,
                      nextPage: RegiAccountPage(
                        groupID: groupID,
                      ),
                    ),
                  ];
                } else if (userCounts - 1 > docs.length) {
                  var members = userCounts - docs.length - 1;
                  // 登録したユーザの数が足りないとき
                  children = <Widget>[
                    const CustomText(
                        text: '人数分の登録完了まで\nしばらくお待ちください', fontSize: 16),
                    const SizedBox(height: 20),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const CustomText(text: 'あと', fontSize: 20),
                      const SizedBox(width: 10),
                      CustomText(text: members.toString(), fontSize: 38),
                      const SizedBox(width: 10),
                      const CustomText(text: '人', fontSize: 20),
                    ])
                  ];
                } else {
                  // 登録したユーザの数が多すぎるとき
                  children = <Widget>[
                    const CustomButton(
                      title: "登録した人数が間違えています\n入力にもどる",
                      width: 120,
                      height: 45,
                      nextPage: GroupCreatePage(),
                    ),
                  ];
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                );
              },
            ),
            const SizedBox(
              width: 100,
              height: 20,
            ),
            CustomButton(
              title: 'もどる',
              width: 120,
              height: 45,
              nextPage: GroupCreatePage(deleteGroupId: groupID),
            ),
          ],
        ),
      ),
    );
  }
}
