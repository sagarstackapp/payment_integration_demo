import 'package:flutter/material.dart';
import 'package:payment_integration_demo/common/app/app_methods.dart';
import 'package:payment_integration_demo/common/constant/color_constant.dart';
import 'package:payment_integration_demo/common/constant/string_constant.dart';
import 'package:payment_integration_demo/screens/payment_types/stripe_payment/payment_sheet/payment_sheet_screen.dart';

class StripePaymentScreen extends StatefulWidget {
  final String? paymentType;

  const StripePaymentScreen({Key? key, @required this.paymentType})
      : super(key: key);

  @override
  State<StripePaymentScreen> createState() => StripePaymentScreenState();
}

class StripePaymentScreenState extends State<StripePaymentScreen> {
  bool isWaterExpand = false;

  @override
  Widget build(BuildContext context) {
    logs('Current screen --> $runtimeType');
    return Scaffold(
      appBar: AppBar(title: Text(widget.paymentType!)),
      body: ListView(
        primary: true,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          ExpansionTile(
            title: Text(
              StringConstant.paymentSheet.toCapitalized(),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
                fontSize: 16,
              ),
            ),
            textColor:
                isWaterExpand ? ColorConstant.darkBlue : ColorConstant.black,
            iconColor:
                isWaterExpand ? ColorConstant.darkBlue : ColorConstant.black,
            trailing: Icon(
              isWaterExpand ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            ),
            onExpansionChanged: (bool expanded) {
              setState(() => isWaterExpand = expanded);
            },
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: paymentSheetType.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentSheetScreen(
                        isCustomized: index == 0 ? false : true,
                        paymentSheetType: paymentSheetType[index],
                      ),
                    ),
                  ),
                  title: Text(
                    paymentSheetType[index],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: ColorConstant.darkBlue,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
