import 'package:flutter/material.dart';
import 'package:payment_integration_demo/common/constant/color_constant.dart';

class CommonElevatedButton extends StatelessWidget {
  final double horizontalMargin;
  final double width;
  final VoidCallback? onPressed;
  final String? buttonName;
  final double fontSize;
  final Color textColor;
  final Color? buttonColor;

  const CommonElevatedButton({
    Key? key,
    this.horizontalMargin = 30,
    this.width = double.infinity,
    @required this.onPressed,
    @required this.buttonName,
    this.fontSize = 14,
    this.textColor = ColorConstant.white,
    this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          buttonName!,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: const ButtonStyle().copyWith(
          backgroundColor: MaterialStateProperty.all(buttonColor),
        ),
      ),
    );
  }
}
