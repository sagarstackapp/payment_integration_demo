import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_integration_demo/common/app/app_methods.dart';
import 'package:payment_integration_demo/common/constant/color_constant.dart';
import 'package:payment_integration_demo/common/widget/common_elevated_button.dart';
import 'package:payment_integration_demo/common/widget/text_form_fields.dart';
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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController line1Controller = TextEditingController();
  final TextEditingController line2Controller = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();

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
          const SizedBox(height: 20),
          const Text(
            'Shipping details',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorConstant.darkBlue,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: const Color(0XFFDDDDDD)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                nameTextFormField(nameController, 'Name'),
                const SizedBox(height: 20),
                emailTextFormField(emailController, 'Email address'),
                const SizedBox(height: 20),
                numberTextFormField(phoneNoController, 'Phone number',
                    numLimit: 10),
                const SizedBox(height: 20),
                nameTextFormField(line1Controller, 'Line1',
                    prefixIcon: Icons.home),
                const SizedBox(height: 20),
                nameTextFormField(line2Controller, 'Line2',
                    prefixIcon: Icons.home),
                const SizedBox(height: 20),
                numberTextFormField(postalCodeController, 'Postal code',
                    numLimit: 6, prefixIcon: Icons.local_post_office),
                const SizedBox(height: 20),
                nameTextFormField(cityController, 'City',
                    prefixIcon: Icons.location_city),
                const SizedBox(height: 20),
                nameTextFormField(stateController, 'State',
                    prefixIcon: Icons.apartment),
                const SizedBox(height: 20),
                nameTextFormField(countryController, 'Country',
                    prefixIcon: Icons.flag),
                const SizedBox(height: 20),
                CommonElevatedButton(
                  buttonName: 'Initialize payment',
                  horizontalMargin: 0,
                  onPressed: () => paymentInitialize(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> paymentInitialize() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneNoController.text.isEmpty ||
        cityController.text.isEmpty ||
        countryController.text.isEmpty ||
        line1Controller.text.isEmpty ||
        line2Controller.text.isEmpty ||
        stateController.text.isEmpty ||
        postalCodeController.text.isEmpty) {
      showMessage(context, 'Enter all values');
    } else {
      CustomerModel customerModel = await RestServices().createCustomer(
          name: nameController.text, email: emailController.text);
      logs('CustomerModel --> ${customerModel.toJson()}');
      Map<String, dynamic> paymentModel =
          await RestServices().createPaymentIntents();
      final BillingDetails billingDetails = BillingDetails(
        email: emailController.text,
        phone: '+91${phoneNoController.text}',
        name: nameController.text,
        address: Address(
          city: cityController.text,
          country: countryController.text,
          line1: line1Controller.text,
          line2: line2Controller.text,
          state: stateController.text,
          postalCode: postalCodeController.text,
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
}
