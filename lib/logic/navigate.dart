import 'package:bath_random/logic/login_data_dao.dart';
import 'package:bath_random/logic/shared_preferences.dart';
import 'package:bath_random/view/pages/dress_up_page.dart';
import 'package:bath_random/view/constant.dart';
import 'package:bath_random/view/pages/start_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../view/pages/game_page.dart';
import '../view/pages/main_page.dart';

class Navigate extends StatefulWidget {
  const Navigate({super.key});

  @override
  State<Navigate> createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  late SharedPreferencesLogic _sharedPreferencesLogic;
  late LoginDataDao _loginDataDao;
  String groupID = '';
  String userID = '';
  List<StatefulWidget> _selectPage = [];
  // 自分が見ているページ
  var _selectedIndex = 1;

  @override
  void initState() {
    _sharedPreferencesLogic = SharedPreferencesLogic();
    _loginDataDao = LoginDataDao();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.width * 0.27),
        child: AppBar(
          automaticallyImplyLeading: false,

          title: Text(
            'Bath.random();',
            style: GoogleFonts.mPlusRounded1c(
              fontWeight: FontWeight.bold,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/parts/appbar.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter),
            ),
          ),
          elevation: 0,
          backgroundColor: Constant.lightBlueColor,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.dehaze_rounded),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return _bottomSheetWidget(context);
                  },
                );
              },
            ),
          ],

          // centerTitle: true,
          // automaticallyImplyLeading: false,
          // backgroundColor: Colors.white,
          // elevation: 0,
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder<Map<String, String?>>(
              future: _sharedPreferencesLogic.fetchID(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                var id = snapshot.data!;
                groupID = id['groupID']!;
                userID = id['userID']!;

                if (kDebugMode) {
                  print('get groupID: $groupID');
                  print('get userID: $userID');
                }
                _selectPage = [
                  GamePage(groupID: groupID, userID: userID),
                  MainPage(groupID: groupID, userID: userID),
                  DressUpPage(groupID: groupID, userID: userID),
                ];
                return _selectPage[_selectedIndex];
              }),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedIndex: _selectedIndex,
        animationDuration: const Duration(seconds: 1),
        elevation: 0,
        height: 70,
        backgroundColor: Colors.white,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const <Widget>[
          NavigationDestination(
              icon: Icon(Icons.sports_esports), label: 'game'),
          NavigationDestination(icon: Icon(Icons.home), label: 'home'),
          NavigationDestination(
              icon: Icon(Icons.format_list_bulleted), label: 'other'),
        ],
      ),
    );
  }

  // ハンバーガーメニューの中
  Widget _bottomSheetWidget(BuildContext context) {
    return Container(
        height: 400,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.settings, size: 36),
                title: const Text('設定'),
                onTap: () => null,
              ),
              ListTile(
                leading: const Icon(Icons.manage_accounts, size: 36),
                title: const Text('デモ用メニュー'),
                onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => _demoWidget(context),
                ),
              ),
            ],
          ),
        ));
  }

  // デモ用メニュー
  Widget _demoWidget(BuildContext context) {
    return Container(
        height: 400,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
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
                leading: const Icon(Icons.switch_account, size: 36),
                title: const Text('デモ用メニューに移動する'),
                onTap: () {
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
                  leading: const Icon(Icons.face, size: 36),
                  title: const Text('新しくグループを作成する'),
                  onTap: () {
                    _sharedPreferencesLogic.deleteID();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StartPage(),
                      ),
                    );
                  }),
            ],
          ),
        ));
  }
}
