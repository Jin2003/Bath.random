import 'dart:async';

import 'package:bath_random/logic/login_data_dao.dart';
import 'package:bath_random/logic/shared_preferences.dart';
import 'package:bath_random/model/group_data.dart';
import 'package:bath_random/model/user_data.dart';
import 'package:bath_random/view/constant.dart';
import 'package:bath_random/view/pages/dress_up_page.dart';
import 'package:bath_random/view/pages/start_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'game_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late LoginDataDao _loginDataDao;
  late SharedPreferencesLogic _sharedPreferencesLogic;
  String userID = "";
  String groupID = "";
  DateTime? groupStartTime;
  List<UserData>? userDataList;

  // 全員の順番をシャッフルする処理
  Future shuffleOrder() async {
    print('いまからシャッフル: $userDataList');

    userDataList!.shuffle();

    _loginDataDao.shuffleData(userDataList!);
    _loginDataDao.disabledStart(groupID);
  }

  @override
  void initState() {
    _loginDataDao = LoginDataDao();
    _sharedPreferencesLogic = SharedPreferencesLogic();
    super.initState();
  }

  /*
    ---------- ウィジェット部分 ----------
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Constant.lightBlueColor,
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
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),

      // IDの取得処理完了後、リスト表示に移行
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
          } else {
            // ID取得処理成功
            Map<String, String?> id = snapshot.data!;
            groupID = id['groupID']!;
            userID = id['userID']!;
            print('groupID get: $groupID');
            print('userID get: $userID');

            // GroupDataを取ってくる -> 整列、時間表示の有無
            return StreamBuilder(
              stream: _loginDataDao.streamGroupData(groupID),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                GroupData groupData = snapshot.data!;
                print('groupData: $groupData');

                return _listWidget(context, groupData);
              },
            );
          }
        },
      ),
    );
  }

  // リスト表示部分のウィジェット
  Widget _listWidget(BuildContext context, GroupData groupData) {
    // List<UserData> userDataList;
    dynamic passTime;

    return StreamBuilder(
      stream: _loginDataDao.streamUserData(groupID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return const Text('error: NO DATA');
        }

        userDataList = snapshot.data!;
        userDataList!.sort(
          (a, b) => a.order.compareTo(b.order),
        );
        print(userDataList);

        return Stack(
          children: [
            // リスト部分
            ListView.builder(
              itemCount: userDataList!.length,
              itemBuilder: (context, index) {
                Widget? bathTimeWidget;
                // アイコンの設定
                String currentIcon =
                    Constant.dressUp[userDataList![index].currentIcon];

                if (groupData.isSetOrder) {
                  if (index == 0) {
                    passTime = groupData.groupStartTime!.toDate();
                  }
                  var startTime = passTime
                      .add(const Duration(minutes: Constant.intervalTime));
                  var endTime = startTime
                      .add(Duration(minutes: userDataList![index].bathTime));
                  // TODO: 自分のはいる時間をfirestoreに登録
                  _loginDataDao.setMyStartTime(
                      userDataList![index].userID, startTime);
                  passTime = endTime;

                  bathTimeWidget = Text(
                      DateFormat('HH:mm - ').format(startTime) +
                          DateFormat('HH:mm').format(endTime));
                }

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
                      // leading: const Icon(
                      //   Icons.face,
                      //   size: 26,
                      // ),
                      leading:
                          Image.asset('assets/DressUp_images/$currentIcon.png'),
                      title: Text(
                        userDataList![index].userName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 17),
                      ),
                      trailing: Text("${userDataList![index].bathTime}min"),
                      subtitle: bathTimeWidget,
                    ),
                  ),
                );
              },
            ),
            // ボタン部分
            // Padding(
            //   padding: const EdgeInsets.all(60.0),
            //   child: Align(
            //     alignment: Alignment(-0.9, 0.9),
            //     child: OutlinedButton(
            //       style: OutlinedButton.styleFrom(
            //         foregroundColor: Constant.lightGreyColor,
            //         backgroundColor: const Color.fromARGB(255, 255, 249, 249),
            //         fixedSize: const Size(130, 45),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         side: const BorderSide(color: Colors.white),
            //         elevation: 3,
            //       ),
            //       onPressed: groupData.isSetOrder
            //           ? null
            //           : () async {
            //               await shuffleOrder();
            //               await _loginDataDao.startBath(groupID);
            //             },
            //       child: const Text('スタート',
            //           style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 16,
            //           )),
            //     ),
            //   ),
            // ),

            Align(
              alignment: const Alignment(-0.9, 0.9),
              child: InkWell(
                onTap: (groupData.isSetOrder
                    ? null
                    : () async {
                        await shuffleOrder();
                        await _loginDataDao.startBath(groupID);
                      }),
                child: Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/parts/shuffle_button.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
