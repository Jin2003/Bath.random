import 'package:bath_random/pages/components/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final Widget? nextPage;
  final Function? onPressed;
  final bool isDisabled = false;

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
      style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: const Color.fromARGB(255, 255, 249, 249),
          fixedSize: Size(width, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(color: Colors.grey.shade200),
          elevation: 6),
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
      child: CustomText(text: title, fontSize: 17),
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
