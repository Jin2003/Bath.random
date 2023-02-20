import 'package:bath_random/view/constant.dart';
import 'package:bath_random/view/pages/components/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int imageIndex = 0;
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
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
      ),
    );
  }

  Widget _cardWidget(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          setState(() {
            backCards.shuffle();

            imageIndex = index;
            imageTitle[index] = backCards[index];
          });
        },
        child: SizedBox(
          height: 145,
          width: 145,
          child: Container(
              margin: const EdgeInsets.all(5),
              child: Image.asset('assets/cards/${imageTitle[index]}.png')),
        ),
      ),
    );
  }
}
