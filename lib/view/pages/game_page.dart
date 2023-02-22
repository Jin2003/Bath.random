import 'package:bath_random/logic/login_data_dao.dart';
import 'package:bath_random/logic/navigate.dart';
import 'package:bath_random/model/user_data.dart';
import 'package:bath_random/view/constant.dart';
import 'package:bath_random/view/pages/components/custom_button.dart';
import 'package:bath_random/view/pages/components/custom_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  final String groupID;
  final String userID;
  const GamePage({super.key, required this.groupID, required this.userID});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late LoginDataDao _loginDataDao;
  String userID = '';
  String groupID = '';
  int imageIndex = 0;
  bool isPressed = false;
  UserData? myData;
  late int index;

  List<String> backCards = [
    'cards_atari',
    'cards_hazure',
    'cards_hazure',
    'cards_hazure',
    'cards_hazure',
    'cards_hazure',
  ];
  List<String> imageTitle = List.filled(6, 'cards_dack');

  // カードのあたりはずれのダイアログ
  void delayDialog(bool isSucceed) {
    if (!isSucceed) {
      // はずれ
      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                //title: CustomText(text: 'はずれ', fontSize: 20),
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: CustomText(text: 'はずれ', fontSize: 20),
                  ),
                  Image.asset(
                    'assets/cards/hazure_dack.png',
                    height: 200,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              );
            },
          );
        },
      );
    } else {
      // あたり
      if (index == -1) {
        // アイコンすべて所持
        Future.delayed(
          const Duration(milliseconds: 500),
          () {
            showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  //title: CustomText(text: 'アイコンコンプリート！', fontSize: 20),
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: CustomText(text: 'アイコンコンプリート！', fontSize: 20),
                    ),
                    Image.asset(
                      'assets/cards/compleate_dack.png',
                      height: 200,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                );
              },
            );
          },
        );
      } else {
        // アイコンゲット
        _loginDataDao.addIcon(userID, index);

        Future.delayed(
          const Duration(milliseconds: 500),
          () {
            showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: CustomText(text: 'きせかえゲット！', fontSize: 20),
                    ),
                    Image.asset(
                      'assets/DressUp_images/d_white/${Constant.dressUp[index]}.png',
                      height: 200,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                );
              },
            );
          },
        );
      }
    }
  }

  @override
  void initState() {
    _loginDataDao = LoginDataDao();
    groupID = widget.groupID;
    userID = widget.userID;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.lightBlueColor,
      body: FutureBuilder(
        future: _loginDataDao.fetchMyUserData(userID),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          myData = snapshot.data!;
          if (kDebugMode) {
            print('myData : $myData');
          }
          index = _loginDataDao.randomIndex(myData!.myIcons);

          if (isPressed) {
            // 結果をダイアログで出力
            delayDialog(imageTitle[imageIndex] == 'cards_atari');
          }

          return Stack(
            children: [
              //Image.asset('assets/parts/appbar.png'),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    icon: Icon(Icons.refresh, color: Constant.greyColor),
                    onPressed: () {
                      setState(() {
                        imageTitle = List.filled(6, 'cards_dack');
                        isPressed = false;
                      });
                    },
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, -1.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    const CustomText(text: '好きなカードを選んでね！', fontSize: 16),
                    const SizedBox(height: 10),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        for (int i = 0; i < 6; i++) _cardWidget(context, i),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Image.asset('assets/parts/bottom_navigation_bar.png'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _cardWidget(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: InkWell(
        onTap: isPressed
            ? null
            : () {
                backCards.shuffle();

                imageIndex = index;
                imageTitle[index] = backCards[index];

                setState(() {
                  isPressed = true;
                });
              },
        child: SizedBox(
          height: 145,
          width: 145,
          child: Container(
              margin: const EdgeInsets.all(8),
              child: Image.asset('assets/cards/${imageTitle[index]}.png')),
        ),
      ),
    );
  }
}
