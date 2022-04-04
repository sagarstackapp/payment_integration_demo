import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_integration_demo/common/app/app_methods.dart';
import 'package:payment_integration_demo/model/customer_model.dart';
import 'package:payment_integration_demo/rest_api/payment_sheet/rest_api.dart';

class PaymentSheetScreen extends StatefulWidget {
  final bool isCustomized;
  final String? paymentSheetType;

  const PaymentSheetScreen(
      {Key? key, this.isCustomized = false, @required this.paymentSheetType})
      : super(key: key);

  @override
  State<PaymentSheetScreen> createState() => PaymentSheetScreenState();
}

class PaymentSheetScreenState extends State<PaymentSheetScreen> {
  @override
  Widget build(BuildContext context) {
    logs('Current screen --> $runtimeType');
    return Scaffold(
      appBar: AppBar(title: Text(widget.paymentSheetType!)),
      body: ListView(
        primary: true,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          ElevatedButton(
            onPressed: () => paymentInitialize(),
            child: const Text(
              'Initialize payment',
              style: TextStyle(
                letterSpacing: 1,
                wordSpacing: 2,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> paymentInitialize() async {
    logs('message --> ${widget.isCustomized}');
    CustomerModel customerModel = await RestServices().createCustomer();
    logs('CustomerModel --> ${customerModel.toJson()}');
    Map<String, dynamic> paymentModel =
        await RestServices().createPaymentIntents();
    const billingDetails = BillingDetails(
      email: 'email@stripe.com',
      phone: '+48888000888',
      name: 'Stripe demo',
      address: Address(
        city: 'Houston',
        country: 'US',
        line1: '1459  Circle Drive',
        line2: '',
        state: 'Texas',
        postalCode: '77063',
      ),
    );
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        customFlow: widget.isCustomized,
        customerId: customerModel.id.toString(),
        paymentIntentClientSecret: paymentModel['client_secret'],
        merchantDisplayName: 'JustSaagar Shop',
        merchantCountryCode: 'IN',
        billingDetails: billingDetails,
        applePay: true,
        googlePay: true,
        style: ThemeMode.dark,
      ),
    );
    await Stripe.instance.presentPaymentSheet();
    if (widget.isCustomized) {
      await Stripe.instance.confirmPaymentSheetPayment();
    }
  }
}
