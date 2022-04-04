import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:payment_integration_demo/common/constant/color_constant.dart';

void logs(String message) {
  if (kDebugMode) {
    print(message);
  }
}

showMessage(BuildContext context, String message,
    {Color textColor = ColorConstant.themeScaffold,
    Color? backgroundColor,
    bool isError = true}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor:
          isError ? ColorConstant.red.withOpacity(0.6) : backgroundColor,
      content: Text(
        message,
        style: TextStyle(
          fontFamily: 'Poppins',
          color: textColor,
          fontWeight: FontWeight.w400,
          wordSpacing: 1,
          fontSize: 14,
        ),
      ),
    ),
  );
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
