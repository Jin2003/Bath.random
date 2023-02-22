import 'dart:async';

import 'package:bath_random/logic/login_data_dao.dart';
import 'package:bath_random/model/group_data.dart';
import 'package:bath_random/model/user_data.dart';
import 'package:bath_random/view/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  final String groupID;
  final String userID;
  const MainPage({super.key, required this.groupID, required this.userID});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late LoginDataDao _loginDataDao;
  String groupID = '';
  String userID = '';
  DateTime? groupStartTime;
  List<UserData>? userDataList;

  // 全員の順番をシャッフルする処理
  Future shuffleOrder() async {
    userDataList!.shuffle();

    _loginDataDao.shuffleData(userDataList!);
    _loginDataDao.disabledStart(groupID);
  }

  @override
  void initState() {
    _loginDataDao = LoginDataDao();
    groupID = widget.groupID;
    userID = widget.userID;
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

      // IDの取得処理完了後、リスト表示に移行
      body: StreamBuilder(
        stream: _loginDataDao.streamGroupData(groupID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          GroupData groupData = snapshot.data!;
          if (kDebugMode) {
            print('groupData: $groupData');
          }

          return _listWidget(context, groupData);
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
        if (kDebugMode) {
          print(userDataList);
        }

        String btnImage =
            groupData.isSetOrder ? 'sleeping_dack' : 'shuffle_button';

        return Stack(
          children: [
            // Image.asset('assets/parts/appbar.png'),
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/parts/bottom_navigation_bar.png'),
            ),

            //リスト部分
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

                  // 自分のはいる時間をfirestoreに登録
                  _loginDataDao.setMyStartTime(
                      userDataList![index].userID, startTime);
                  passTime = endTime;
                  bathTimeWidget = Text(
                    DateFormat('HH:mm - ').format(startTime) +
                        DateFormat('HH:mm').format(endTime),
                    style: GoogleFonts.mPlusRounded1c(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Constant.lightGreyColor),
                  );
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
                      leading: Image.asset(
                          'assets/DressUp_images/d_white/$currentIcon.png'),
                      title: Text(
                        userDataList![index].userName,
                        style: GoogleFonts.mPlusRounded1c(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Constant.lightGreyColor),
                      ),
                      trailing: Text(
                        "${userDataList![index].bathTime}min",
                        style: GoogleFonts.mPlusRounded1c(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Constant.lightGreyColor),
                      ),
                      subtitle: bathTimeWidget,
                    ),
                  ),
                );
              },
            ),
            // ボタン部分
            Align(
              alignment: const Alignment(-0.9, 1.0),
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
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/parts/$btnImage.png',
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
