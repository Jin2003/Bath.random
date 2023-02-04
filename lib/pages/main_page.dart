import 'dart:developer';

import 'package:bath_random/model/user.dart';
import 'package:bath_random/pages/components/custom_button.dart';
import 'package:bath_random/pages/components/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String userID = "";
  String groupID = "";
  bool isNullOrder = false;

  final userCollection = FirebaseFirestore.instance.collection('user');

  // IDをローカルから取得する関数
  Future<String> fetchID() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      userID = prefs.getString('userID')!;
      groupID = prefs.getString('groupID')!;

      // debug
      if (kDebugMode) {
        print("userID: $userID");
        print("groupID: $groupID");
      }
      return "成功";
    } catch (error) {
      return Future.error(error);
    }
  }

  // orderがnullかどうかを確認する関数
  Future checkOrder() async {
    final userCollection =
        await FirebaseFirestore.instance.collection('user').doc(userID).get();
    final data = userCollection.data();
    isNullOrder = (data!['order'] == null);
  }

  // 全員の順番をシャッフルする関数
  Future<void> shuffleOrder() async {
    // 同じグループのユーザーのデータを配列に格納
    List users = [];
    final userCollection = await FirebaseFirestore.instance
        .collection('user')
        .where('groupID', isEqualTo: groupID)
        .get();
    final docs = userCollection.docs;
    for (var doc in docs) {
      var fetchUserID = doc.id;
      users.add(fetchUserID);
    }

    // ユーザーIDの配列をシャッフルする
    users.shuffle();

    // ユーザーのorder(順番)にusersの配列番号を入れる
    int index = 0;
    for (var user in users) {
      final doc = FirebaseFirestore.instance.collection('user').doc(user);
      await doc.update({
        'order': index++,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: Text(
            'Bath.random();',
            style: GoogleFonts.mPlusRounded1c(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                // ハンバーガーメニュー押した時
              },
              icon: const Icon(Icons.dehaze_rounded),
            ),
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 152, 233, 244),

      // IDの取得処理完了後、リスト表示に移行
      body: FutureBuilder(
        future: fetchID(),
        builder: (context, snapshot) {
          // 通信中
          if (snapshot.connectionState != ConnectionState.done) {
            return const CircularProgressIndicator();
          }
          // エラー発生時
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          // データ取得失敗
          if (!snapshot.hasData) {
            return const Center(
              child: Text('NO DATA'),
            );
          } else {
            // ID取得処理成功
            return FutureBuilder(
              future: checkOrder(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData) {
                  // orderがnullだったら整列しない
                  if (isNullOrder) {
                    return _listBuilder(
                        context,
                        FirebaseFirestore.instance
                            .collection('user')
                            .where('groupID', isEqualTo: groupID)
                            .snapshots(),
                        isNullOrder);
                  } else {
                    // nullじゃなかったら整列
                    return _listBuilder(
                        context,
                        FirebaseFirestore.instance
                            .collection('user')
                            .where('groupID', isEqualTo: groupID)
                            .orderBy('order')
                            .snapshots(),
                        isNullOrder);
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              },
            );
          }
        },
      ),
    );
  }

  // グループの状態のリストをデータに応じて更新
  Widget _listBuilder(BuildContext context, Stream stream, bool isNullOrder) {
    return StreamBuilder(
      stream: stream,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (!snapshot.hasData) {
          return const Center(
              child: CustomText(text: 'データが見つかりません', fontSize: 16));
        }
        dynamic docs = snapshot.data!.docs;

        return Stack(
          children: [
            // リスト部分
            ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = docs[index].data();
                final User users = User(
                  userName: data['userName'],
                  bathTime: data['bathTime'],
                );

                return Card(
                  color: Colors.white, // Card自体の色
                  margin: const EdgeInsets.fromLTRB(40, 20, 40, 10),
                  elevation: 10,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.people),
                    title: Text(users.userName),
                    // TODO: 風呂に入る時間 表示部分
                    subtitle: const Text('18:00-19:00'),
                    trailing: Text("${users.bathTime}min"),
                  ),
                );
              },
            ),
            // ボタン部分
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  height: 45,
                  width: 160,
                  title: 'シャッフル',
                  onPressed: () {
                    shuffleOrder();
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
