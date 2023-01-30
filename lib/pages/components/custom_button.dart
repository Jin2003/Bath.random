import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.title,
    required this.nextPage,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final Widget nextPage;
  final Function? onPressed;

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
        fixedSize: const Size(120, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: const BorderSide(),
      ),
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => nextPage,
          ),
        );
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
