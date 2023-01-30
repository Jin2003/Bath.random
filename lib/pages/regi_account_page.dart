import 'package:bath_random/pages/components/custom_button.dart';
import 'package:bath_random/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegiAccountPage extends StatefulWidget {
  final String groupID;
  const RegiAccountPage({super.key, required this.groupID});

  @override
  State<RegiAccountPage> createState() => _RegiAccountPageState();
}

String nameText = '';

class _RegiAccountPageState extends State<RegiAccountPage> {
  get child => null;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 152, 233, 244),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //入力欄
              Text('あなたのニックネーム',
                  style: GoogleFonts.mPlusRounded1c(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  )),
              const SizedBox(
                width: 100,
                height: 10,
              ),
              TextField(
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      width: 3,
                      color: Colors.white,
                    )),
                    labelText: 'your nickname'),
                onChanged: (name) {
                  nameText = name;
                },
              ),
              const SizedBox(
                width: 100,
                height: 25,
              ),
              Text(
                '入浴時間',
                style: GoogleFonts.mPlusRounded1c(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                width: 100,
                height: 10,
              ),
              TextField(
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      width: 3,
                      color: Colors.white,
                    )),
                    labelText: 'bath time'),
                onChanged: (name) {
                  nameText = name;
                },
              ),
              const SizedBox(
                width: 100,
                height: 40,
              ),
              const CustomButton(title: '次へ', nextPage: MainPage())
            ],
          ),
        ),
      ),
    );
  }
}
