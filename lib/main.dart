import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_integration_demo/common/app/app_methods.dart';
import 'package:payment_integration_demo/common/constant/color_constant.dart';
import 'package:payment_integration_demo/common/constant/string_constant.dart';
import 'package:payment_integration_demo/screens/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logs('Current screen --> $runtimeType');
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: StringConstant.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorConstant.themeScaffold,
        fontFamily: 'Poppins',
        dividerColor: ColorConstant.transparent,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(ColorConstant.darkBlue),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 26, vertical: 10)),
            elevation: MaterialStateProperty.all(0),
          ),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: ColorConstant.darkBlue,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            color: ColorConstant.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
