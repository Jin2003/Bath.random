import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.title,
    required this.nextPage,
  }) : super(key: key);

  final String title;
  final Widget nextPage;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: Text(title),
      style: OutlinedButton.styleFrom(
        primary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: const BorderSide(color: Colors.black),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => nextPage,
          ),
        );
      },
    );
  }
}
