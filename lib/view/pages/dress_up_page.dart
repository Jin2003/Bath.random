import 'package:bath_random/logic/login_data_dao.dart';
import 'package:bath_random/model/user_data.dart';
import 'package:bath_random/view/constant.dart';
import 'package:bath_random/view/pages/components/custom_button.dart';
import 'package:bath_random/view/pages/components/custom_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DressUpPage extends StatefulWidget {
  final String groupID;
  final String userID;
  const DressUpPage({super.key, required this.groupID, required this.userID});

  @override
  State<DressUpPage> createState() => _DressUpPageState();
}

class _DressUpPageState extends State<DressUpPage> {
  late LoginDataDao _loginDataDao;
  UserData? myUserData;
  Future<UserData>? _fetchUserData;

  @override
  void initState() {
    _loginDataDao = LoginDataDao();
    _fetchUserData = _loginDataDao.fetchMyUserData(widget.userID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.lightBlueColor,
      body: FutureBuilder(
        future: _fetchUserData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('NO DATA'));
          }

          myUserData = snapshot.data!;
          if (kDebugMode) {
            print('myUserData: $myUserData');
          }

          return Stack(
            children: [
              Align(
                alignment: const Alignment(0.0, -0.9),
                child: Container(
                  width: 350,
                  height: 500,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _currentIconWidget(context),
                      const SizedBox(height: 8),
                      const CustomText(text: 'コレクション', fontSize: 18),
                      LimitedBox(
                        maxHeight: 300,
                        child: _myIconsWidget(context),
                      ),
                      //const SizedBox(height: 20),
                    ],
                  ),
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

//
  // 設定中のアイコンの表示
  Widget _currentIconWidget(BuildContext context) {
    return _dackImage(context, myUserData!.currentIcon, 120);
  }

  // 自分の持っているアイコンだけのを表示
  Widget _myIconsWidget(BuildContext context) {
    List<int> myIcons = myUserData!.myIcons;
    List<int> notMyIcons = [];
    for (int i = 0; i < Constant.dressUp.length; i++) {
      if (!myIcons.contains(i)) {
        notMyIcons.add(i);
      }
      notMyIcons.remove(myUserData!.currentIcon);
    }

    // if (myIcons.length == 1) {
    //   return Column(
    //     children: const [
    //       SizedBox(height: 55),
    //       CustomText(
    //         text: 'きせかえをもっていません',
    //         fontSize: 24,
    //       ),
    //     ],
    //   );
    // }

    return ListView(
      children: [
        Center(
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: [
              // myIconsのみを表示（currentIcon以外）
              for (int i = 0; i < myIcons.length; i++)
                if (myIcons[i] != myUserData!.currentIcon)
                  _dackImage(context, myIcons[i], 85),
              for (int i = 0; i < notMyIcons.length; i++)
                _secretImage(context, notMyIcons[i], 85),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dackImage(BuildContext context, int index, double size) {
    var icon = Constant.dressUp[index];
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          _checkDialog(index);
        },
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            'assets/DressUp_images/d_white/$icon.png',
          ),
        ),
      ),
    );
  }

  Widget _secretImage(BuildContext context, int index, double size) {
    var icon = Constant.dressUp[index];
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            'assets/DressUp_images/d_secret/$icon.png',
          ),
        ),
      ),
    );
  }

  void _checkDialog(int index) {
    // 「このアイコンにしますか？」のダイアログ
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Align(
              alignment: Alignment.center,
              child: CustomText(text: 'このアイコンにしますか？', fontSize: 20),
            ),
            Image.asset(
              'assets/DressUp_images/d_white/${Constant.dressUp[index]}.png',
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  CustomButton(
                    title: 'はい',
                    width: 170,
                    height: 45,
                    onPressed: () async {
                      await _loginDataDao.setCurrentIcon(widget.userID, index);
                      setState(() {
                        _fetchUserData =
                            _loginDataDao.fetchMyUserData(widget.userID);
                      });
                      if (!mounted) return;
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    title: 'いいえ',
                    width: 170,
                    height: 45,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
