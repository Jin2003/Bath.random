import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final Widget? nextPage;
  final Function? onPressed;

  const CustomButton({
    Key? key,
    required this.title,
    required this.width,
    required this.height,
    this.nextPage,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      // ignore: sort_child_properties_last
      child: Text(
        title,
        style: GoogleFonts.mPlusRounded1c(
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: const Color.fromARGB(255, 255, 249, 249),
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: const BorderSide(),
      ),
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        }

        if (nextPage != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => nextPage!,
            ),
          );
        }
      },
    );

    // OutlinedButton(
    //   child: Text(title),
    //   style: OutlinedButton.styleFrom(
    //     primary: Colors.white,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(10),
    //     ),
    //     side: const BorderSide(color: Colors.black),
    //   ),
    //   onPressed: () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => nextPage,
    //       ),
    //     );
    //   },
    // );
  }
}
