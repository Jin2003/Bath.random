import 'package:bath_random/pages/components/custom_button.dart';
import 'package:bath_random/pages/regi_account_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegiCompPage extends StatefulWidget {
  final String groupID;
  const RegiCompPage({super.key, required this.groupID});

  @override
  State<RegiCompPage> createState() => _RegiCompPageState();
}

class _RegiCompPageState extends State<RegiCompPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 152, 233, 244),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '共有相手の登録が完了しました',
              style: GoogleFonts.mPlusRounded1c(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(width: 100, height: 20),
            CustomButton(
                title: '次へ',
                width: 120,
                height: 45,
                nextPage: RegiAccountPage(
                  groupID: widget.groupID,
                ))
          ],
        ),
      ),
    );
  }
}
