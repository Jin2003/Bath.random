import 'dart:math' as math;

import 'package:bath_random/logic/login_data_dao.dart';
import 'package:bath_random/logic/shared_preferences.dart';
import 'package:bath_random/view/pages/dress_up_page.dart';
import 'package:bath_random/view/pages/game_page.dart';
import 'package:bath_random/view/pages/start_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../model/user_data.dart';
import '../constant.dart';

class MainListPage extends StatefulWidget {
  const MainListPage({super.key});

  @override
  State<MainListPage> createState() => _MainListPageState();
}

class _MainListPageState extends State<MainListPage> {
  late LoginDataDao _loginDataDao;
  late SharedPreferencesLogic _sharedPreferencesLogic;
  late String groupID;
  late String userID;
  UserData? myData;

  @override
  void initState() {
    _loginDataDao = LoginDataDao();
    _sharedPreferencesLogic = SharedPreferencesLogic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _sharedPreferencesLogic.fetchID(),
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
          }

          // ID取得処理成功
          Map<String, String?> id = snapshot.data!;
          groupID = id['groupID']!;
          userID = id['userID']!;

          return _listWidget(context);
        },
      ),
    );
  }

  Widget _listWidget(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.settings, size: 36),
              title: const Text('設定'),
              // ignore: avoid_returning_null_for_void
              onTap: () => null,
            ),
            ListTile(
              leading: Image.asset(
                'assets/DressUp_images/normal_dack.png',
                height: 36,
              ),
              title: const Text('きせかえ'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DressUpPage(userID: userID),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.manage_accounts, size: 36),
              title: const Text('デモ用メニュー'),
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) => _demoWidget(context),
              ),
            ),
            ListTile(
                leading: const Icon(Icons.sports_esports, size: 36),
                title: const Text('ゲーム'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GamePage(),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  Widget _demoWidget(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
                leading: const Icon(Icons.toggle_on_outlined),
                title: const Text('スタートボタンを有効にする'),
                onTap: () {
                  Future(() async {
                    await _loginDataDao.enableStart(groupID);
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
                // デモデータ移動
                _sharedPreferencesLogic.moveDemo();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StartPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.face),
              title: const Text('新しくグループを作成する'),
              onTap: () {
                _sharedPreferencesLogic.deleteID();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StartPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_to_photos),
              title: const Text('アイコン画像を追加する'),
              onTap: () async {
                UserData myData = await _loginDataDao.fetchMyUserData(userID);
                List<int> myIcons = myData.myIcons;
                List<int> notMyIcons = [];
                for (int i = 0; i < Constant.dressUp.length; i++) {
                  // もしmyIconsにiがなかったらnotmyiconsに追加
                  if (!myIcons.contains(i)) {
                    notMyIcons.add(i);
                  }
                }
                print('not my icons: $notMyIcons');
                var random = math.Random();
                int index = notMyIcons[random.nextInt(notMyIcons.length - 1)];

                _loginDataDao.addIcon(userID, index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
