import 'dart:async';

import 'package:bath_random/model/user.dart';
import 'package:bath_random/pages/components/custom_text.dart';
import 'package:bath_random/pages/start_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final db = FirebaseFirestore.instance;
  String userID = "";
  String groupID = "";
  bool isNullOrder = false; // orderが代入されているかどうか
  bool isSetOrder = false; // orderがシャッフルされているかどうか
  DateTime? groupStartTime;

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
    final userCollection = await db.collection('user').doc(userID).get();
    final data = userCollection.data();
    isNullOrder = (data!['order'] == null);
  }

  // 全員の順番をシャッフルする関数
  Future shuffleOrder() async {
    // 同じグループのユーザーのデータを配列に格納
    List users = [];
    final userCollection =
        await db.collection('user').where('groupID', isEqualTo: groupID).get();
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
      final doc = db.collection('user').doc(user);
      await doc.update({
        'order': index++,
      });
    }

    // 順番シャッフルを一旦無効化する
    db.collection('group').doc(groupID).update({
      'isSetOrder': true,
    });
  }

  // お風呂のタイマーをスタートする関数
  Future startBath() async {
    // groupStartTime = DateTime.now(); // お風呂のスタートボタンを押した時間

    // スタート時間をグループコレクションに記録
    await db
        .collection('group')
        .doc(groupID)
        .update({'groupStartTime': DateTime.now()});
  }

  Future enableStart() async {
    await db.collection('group').doc(groupID).update({
      'isSetOrder': false,
    });
  }

  /*
    ---------- ウィジェット部分 ----------
   */
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

      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 150, 222, 231),
              ),
              child: Text(
                'デモ用メニュー',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
                leading: const Icon(Icons.toggle_on_outlined),
                title: const Text('スタートボタンを有効にする'),
                onTap: () {
                  Future(() async {
                    await enableStart();
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StartPage(),
                    ),
                  );
                }),
            ListTile(
              leading: const Icon(Icons.switch_account),
              title: const Text('デモ用のデータに移動する'),
              onTap: () {
                groupID = 'grO7qrXoht7jZYjEQH0a';
                userID = 'K7V2qcKZgAPPr6xZZxFs';
                Future(
                  () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setString('groupID', groupID);
                    prefs.setString('userID', userID);
                  },
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StartPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.face,
              ),
              title: const Text('新しくグループを作成する'),
              onTap: () {
                Future(
                  () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.clear();
                  },
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StartPage(),
                  ),
                );
              },
            ),
          ],
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
              child: CircularProgressIndicator(),
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
                    return _checkBuilder(
                        context,
                        db
                            .collection('user')
                            .where('groupID', isEqualTo: groupID)
                            .snapshots(),
                        isNullOrder);
                  } else {
                    // nullじゃなかったら整列
                    return _checkBuilder(
                        context,
                        db
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
  Widget _checkBuilder(BuildContext context, Stream stream, bool isNullOrder) {
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

        return StreamBuilder(
            stream: db.collection('group').doc(groupID).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                // isSetOrderがとってこれた時
                isSetOrder = snapshot.data!.data()!['isSetOrder'];

                return _listBuilder(context, docs, isSetOrder);
              }
            });
      }),
    );
  }

  // リスト表示部分のウィジェット
  Widget _listBuilder(BuildContext context, dynamic docs, bool isSetOrder) {
    dynamic myStartTime;
    dynamic myEndTime;
    dynamic nextStartTime;

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

            if (isSetOrder) {
              return StreamBuilder(
                  stream: db.collection('group').doc(groupID).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      Timestamp startTime =
                          snapshot.data!.data()!['groupStartTime'];
                      groupStartTime = startTime.toDate();

                      if (index == 0) {
                        myStartTime = groupStartTime;
                      } else {
                        myStartTime = nextStartTime;
                      }
                      myEndTime =
                          myStartTime!.add(Duration(minutes: users.bathTime));
                      nextStartTime =
                          myEndTime.add(const Duration(minutes: 10));

                      return SizedBox(
                        height: 100,
                        child: Card(
                          color: Colors.white, // Card自体の色
                          margin: const EdgeInsets.fromLTRB(40, 20, 40, 10),
                          elevation: 10,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.face,
                              size: 26,
                            ),
                            title: Text(
                              users.userName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 17),
                            ),
                            subtitle: !isSetOrder
                                ? null
                                : Text(
                                    DateFormat('HH:mm - ').format(myStartTime) +
                                        DateFormat('HH:mm').format(myEndTime)),
                            trailing: Text("${users.bathTime}min"),
                          ),
                        ),
                      );
                    }
                  });
            } else {
              return SizedBox(
                height: 100,
                child: Card(
                  color: Colors.white, // Card自体の色
                  margin: const EdgeInsets.fromLTRB(40, 20, 40, 10),
                  elevation: 10,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: ListTile(
                      leading: const Icon(
                        Icons.face,
                        size: 26,
                      ),
                      title: Text(
                        users.userName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 17),
                      ),
                      trailing: Text("${users.bathTime} min"),
                    ),
                  ),
                ),
              );
            }
          },
        ),
        // ボタン部分
        Padding(
          padding: const EdgeInsets.all(60.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.grey.shade700,
                backgroundColor: const Color.fromARGB(255, 255, 249, 249),
                fixedSize: const Size(130, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: const BorderSide(color: Colors.white),
                elevation: 3,
              ),
              onPressed: isSetOrder
                  ? null
                  : () async {
                      await shuffleOrder();
                      await startBath();
                    },
              child: const Text('スタート',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
