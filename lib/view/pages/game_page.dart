import 'package:bath_random/logic/login_data_dao.dart';
import 'package:bath_random/logic/shared_preferences.dart';
import 'package:bath_random/model/user_data.dart';
import 'package:bath_random/view/constant.dart';
import 'package:bath_random/view/pages/components/custom_button.dart';
import 'package:bath_random/view/pages/components/custom_text.dart';
import 'package:bath_random/view/pages/main_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late LoginDataDao _loginDataDao;
  late SharedPreferencesLogic _sharedPreferencesLogic;
  int imageIndex = 0;
  bool isPressed = false;

  String? userID;
  UserData? myData;
  late int index;
  List<String> backCards = [
    'cards_hazure',
    'cards_hazure',
    'cards_hazure',
    'cards_atari',
    'cards_hazure',
    'cards_hazure',
  ];
  List<String> imageTitle = [
    'cards_dack',
    'cards_dack',
    'cards_dack',
    'cards_dack',
    'cards_dack',
    'cards_dack',
  ];

  // カードのあたりはずれのダイアログ
  void delayDialog(bool isSucceed) {
    if (!isSucceed) {
      Future.delayed(
        const Duration(milliseconds: 500),
        () {
          showDialog(
            context: context,
            builder: (context) {
              return const SimpleDialog(
                title: CustomText(text: 'はずれ', fontSize: 20),
              );
            },
          );
        },
      );
    } else {
      if (index == -1) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () {
            showDialog(
              context: context,
              builder: (context) {
                return const SimpleDialog(
                  title: CustomText(text: 'アイコンコンプリート！', fontSize: 20),
                );
              },
            );
          },
        );
      } else {
        Future.delayed(
          const Duration(milliseconds: 500),
          () {
            showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  title: const CustomText(text: 'アイコンをゲット', fontSize: 20),
                  children: [
                    Image.asset(
                      'assets/DressUp_images/${Constant.dressUp[index]}.png',
                      height: 200,
                    ),
                    const CustomButton(
                      title: 'メイン画面にもどる',
                      width: 200,
                      height: 45,
                      nextPage: MainPage(),
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
    _sharedPreferencesLogic = SharedPreferencesLogic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.lightBlueColor,
      body: FutureBuilder(
        future: _sharedPreferencesLogic.fetchID(),
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

          userID = snapshot.data!['userID'] as String;

          return FutureBuilder(
            future: _loginDataDao.fetchMyUserData(userID!),
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

              if (index != -1) {
                _loginDataDao.addIcon(userID!, index);
              }

              return Stack(
                children: [
                  //Image.asset('assets/parts/appbar.png'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomText(text: '好きなカードを選んでね！', fontSize: 16),
                          const SizedBox(height: 10),
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              for (int i = 0; i < 6; i++)
                                _cardWidget(context, i),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child:
                        Image.asset('assets/parts/bottom_navigation_bar.png'),
                  ),
                ],
              );
            },
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
                setState(() {
                  backCards.shuffle();

                  imageIndex = index;
                  imageTitle[index] = backCards[index];
                  isPressed = true;

                  // あたりがでたらshowDialog
                  if (imageTitle[index] == 'cards_atari') {
                    delayDialog(true);
                  } else {
                    delayDialog(false);
                  }
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
