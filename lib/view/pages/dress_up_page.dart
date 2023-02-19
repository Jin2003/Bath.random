import 'package:bath_random/logic/login_data_dao.dart';
import 'package:bath_random/view/constant.dart';
import 'package:bath_random/view/pages/components/custom_text.dart';
import 'package:bath_random/view/pages/main_page.dart';
import 'package:flutter/material.dart';

class DressUpPage extends StatefulWidget {
  String userID;
  DressUpPage({super.key, required this.userID});

  @override
  State<DressUpPage> createState() => _DressUpPageState();
}

class _DressUpPageState extends State<DressUpPage> {
  late LoginDataDao _loginDataDao;

  @override
  void initState() {
    _loginDataDao = LoginDataDao();
    super.initState();
  }

  // TODO: fetchMyUserData(userID)でアイコンデータを取得

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 30),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainPage(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.clear,
                    size: 40,
                  ),
                ),
              ],
            ),
            _currentIconWidget(context),
            const SizedBox(height: 40),
            const CustomText(text: 'コレクション', fontSize: 26),
            const SizedBox(height: 20),
            SizedBox(
              height: 420,
              child: _myIconsWidget(context),
            ),
          ],
        ),
      ),
    );
  }

  // 設定中のアイコンの表示
  Widget _currentIconWidget(BuildContext context) {
    // TODO: currentIconを表示
    return _oneImage(context, 0, Colors.white, 160);
  }

  // 自分の持っているアイコンだけのを表示
  Widget _myIconsWidget(BuildContext context) {
    return ListView(
      children: [
        Wrap(
          alignment: WrapAlignment.spaceAround,
          children: [
            // TODO: myIconsのみを表示（currentIcon以外）
            for (int i = 1; i < Constant.dressUp.length; i++)
              _oneImage(context, i, Constant.greyColor, 100),
          ],
        ),
      ],
    );
  }

  Widget _oneImage(
      BuildContext context, int index, Color backColor, double size) {
    var icon = Constant.dressUp[index];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () async {
          // TODO: 押されたindexの画像をcurrentIconに変更する
          // await _loginDataDao.setCurrentIcon(widget.userID, index);
        },
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: backColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            margin: const EdgeInsets.all(12),
            child: Image.asset(
              'assets/DressUp_images/$icon.png',
            ),
          ),
        ),
      ),
    );
  }
}
