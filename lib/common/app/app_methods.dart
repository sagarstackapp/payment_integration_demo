import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:payment_integration_demo/common/constant/color_constant.dart';

List<String> paymentMethods = ['Stripe payment'];
List<String> paymentSheetType = [
  'Direct initialize payment',
  'Custom initialize payment'
];

// ---------------------------- Stripe keys ---------------------------- //
const String stripePublishableKey =
    'pk_test_51J5pgUSCwJ2aVJIWd3B5gzbqgZ7c2UXzen9dos81TGM2dhTvoKE36Kms6T47nG1BNVEaXM9x00XBul0PuH5toIpA00S06Dm3VO';
const String stripeSecretKey =
    'sk_test_51J5pgUSCwJ2aVJIWkyQJAinhlhYTIyt8mn7zeRd1wUfyvYr380O05QKkfIOGOfz1HzLU28nSTP7uEOy35awB5XVM002YDWD6Cf';

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
