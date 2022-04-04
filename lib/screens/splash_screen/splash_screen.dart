import 'package:flutter/material.dart';
import 'package:payment_integration_demo/common/app/app_methods.dart';
import 'package:payment_integration_demo/common/constant/color_constant.dart';
import 'package:payment_integration_demo/common/constant/string_constant.dart';
import 'package:payment_integration_demo/screens/payment_types/stripe_payment/stripe_payment_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  int val = 0;

  @override
  Widget build(BuildContext context) {
    logs('Current screen --> $runtimeType');
    return Scaffold(
      appBar: AppBar(title: const Text(StringConstant.appTitle)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (val >= 0) const Spacer(),
          const Text(
            StringConstant.paymentTypes,
            style: TextStyle(
              color: ColorConstant.darkBlue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 30),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: paymentMethods.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    val = index;
                  });
                },
                child: Row(
                  children: [
                    Radio(
                      value: index,
                      groupValue: val,
                      activeColor: ColorConstant.darkBlue,
                      onChanged: (value) {
                        setState(() {
                          val = int.parse(value.toString());
                        });
                      },
                    ),
                    Text(
                      paymentMethods[index],
                      style: TextStyle(
                        color: val == index
                            ? ColorConstant.darkBlue
                            : ColorConstant.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (val >= 0)
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StripePaymentScreen(
                          paymentType: paymentMethods[val])),
                  (route) => false,
                );
              },
              child: const Text(StringConstant.go),
            ),
          if (val >= 0) const Spacer(),
        ],
      ),
    );
  }
}
