
import 'package:flutter/material.dart';
import 'package:github_trending/app/utils/constants.dart';

class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final String? title;
  final double height;
  final double borderRadius;
  final Color color;

 const AppButton(
      {Key? key,
      required this.onPressed,
      this.title,
      this.height = 42,
      this.borderRadius = 4,
      this.color = primaryColor})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      disabledColor: lightGreyColor,
      minWidth: MediaQuery.of(context).size.width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      color: color,
      onPressed: onPressed,
      child: Text(
        title ?? "Next",
        style: normalWhiteStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
