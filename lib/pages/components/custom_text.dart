import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  const CustomText({
    super.key,
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.mPlusRounded1c(
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        color: Colors.grey.shade700,
      ),
    );
  }
}
