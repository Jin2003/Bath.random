import 'package:bath_random/model/user.dart';
import 'package:bath_random/pages/components/custom_FA_Button.dart.dart';
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
  String userID = "読み込み中";
  String groupID = "読み込み中";

  // final userCollection = FirebaseFirestore.instance.collection('user');

  // IDをローカルから取得
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
              onPressed: () {},
              icon: const Icon(Icons.dehaze_rounded),
            ),
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 152, 233, 244),

      // IDの取得処理完了後、リスト表示に移行するウィジェット
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

          //
          if (!snapshot.hasData) {
            return const Center(
              child: Text('nodata'),
            );
          } else {
            return _listBuilder(context);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomFAButton(
            iconImage: const Icon(Icons.bathtub),
            buttonTitle: 'スタート',
            onPressed: () {
              // TODO: お風呂スタート処理
            },
          ),
          const SizedBox(width: 20),
          CustomFAButton(
            iconImage: const Icon(Icons.cached),
            buttonTitle: 'シャッフル',
            onPressed: () {
              // TODO: 順番シャッフル処理
            },
          ),
        ],
      ),
    );
  }

  // グループの状態をデータに応じて更新
  Widget _listBuilder(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('user')
          .where('groupID', isEqualTo: groupID)
          .snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (!snapshot.hasData) {
          return const Center(child: Text('データがありません'));
        }
        final docs = snapshot.data!.docs;

        return ListView.builder(
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
                subtitle: const Text('18:00-19:00'),
                trailing: Text("${users.bathTime}min"),
              ),
            );
          },
        );
      }),
    );
  }
}
