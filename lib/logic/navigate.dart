import 'package:bath_random/logic/shared_preferences.dart';
import 'package:bath_random/view/pages/dress_up_page.dart';
import 'package:bath_random/view/pages/main_list_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../view/pages/game_page.dart';
import '../view/pages/main_page.dart';

class Navigate extends StatefulWidget {
  const Navigate({super.key});

  @override
  State<Navigate> createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  late SharedPreferencesLogic _sharedPreferencesLogic;
  String groupID = '';
  String userID = '';
  List<StatefulWidget> _selectPage = [];
  // 自分が見ているページ
  var _selectedIndex = 1;

  @override
  void initState() {
    _sharedPreferencesLogic = SharedPreferencesLogic();

    super.initState();
    print('init completed');
  }

  @override
  Widget build(BuildContext context) {
    print('widget created');
    return Scaffold(
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
              icon: Icon(Icons.format_list_bulleted), label: 'otther'),
        ],
      ),
      body: FutureBuilder<Map<String, String?>>(
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
              GamePage(),
              MainPage(groupID: groupID, userID: userID),
              DressUpPage(groupID: groupID, userID: userID),
            ];
            return _selectPage[_selectedIndex];
          }),
    );
  }
}
