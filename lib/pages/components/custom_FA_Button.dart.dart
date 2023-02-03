import 'package:flutter/material.dart';

class CustomFAButton extends StatelessWidget {
  final String buttonTitle;
  final Widget? iconImage;
  final Widget? nextPage;
  final Function? onPressed;

  const CustomFAButton({
    super.key,
    required this.buttonTitle,
    this.iconImage,
    this.nextPage,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text(buttonTitle),
      icon: iconImage,
      onPressed: () {
        if (onPressed != null) {
          onPressed;
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage!),
        );
      },
    );
  }
}
