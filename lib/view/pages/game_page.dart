import 'dart:html';
import 'dart:math';

import 'package:bath_random/view/constant.dart';
import 'package:bath_random/view/pages/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.lightBlueColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          title: Text(
            'Bath.random();',
            style: GoogleFonts.mPlusRounded1c(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/cards/cards_dack.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      onTap: () {
                        // 押下時の処理
                      },
                    ),
                  ),
                ),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/cards/cards_dack.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      onTap: () {
                        // 押下時の処理
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(),
            Row(),
          ],
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/cards/cards_dack.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8.0),
              onTap: () {
                // 押下時の処理
              },
            ),
          ),
        ),
      ),
    );
  }
}



// //listの配列を引数にとって配列データを渡す→ランダム生成されたListを取得する関数
//   List _shuffle(List items) {
//     var random = new Random();
//     for (var i = items.length - 1; i > 0; i--) {
//       var n = random.nextInt(i + 1);
//       var temp = items[i];
//       items[i] = items[n];
//       items[n] = temp;
//     }
//     return items;
//   }

//   void _updateCurrentNumber(BuildContext context, CounterModel provider) {
//     if (provider.currentNumber >= 25) {
//       Navigator.push(
//         context,
//         new MaterialPageRoute<Null>(
//           settings: RouteSettings(name: Constants.clearRoute),
//           builder: (BuildContext context) => BackPage(),
//         ),
//       );
//     }
//     provider.updateCurrentNumber();
//   }

//   @override
//   Widget build(BuildContext context) {
//     //1〜６までのlist作成
//     final list = List<int>.generate(6, (i) => i + 1);
//     //ランダム関数の呼び出し
//     final randomList = _shuffle(list);

//     return Container();
//   }

// class BackPage {
//   Widget build(BuildContext context) {
//     //list作成
//     final list = List<int>.generate(6, (i) => i + 1);
//     return Container();
//   }
// }

// class Constants {
//   static var clearRoute;
// }

// class CounterModel {
//   get currentNumber => null;

//   void updateCurrentNumber() {}
// }


