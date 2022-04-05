import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:payment_integration_demo/common/app/app_methods.dart';
import 'package:payment_integration_demo/model/customer_model.dart';

class RestServices {
  String baseUrl = 'https://api.stripe.com/v1';
  Map<String, String> headers = {
    'Authorization': 'Bearer $stripeSecretKey',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  Future<CustomerModel> createCustomer(
      {@required String? name, @required String? email}) async {
    String url = '$baseUrl/customers';
    logs('Url --> $url');
    Map<String, String> body = {
      'name': name!,
      'email': email!,
      'description': 'A new customer'
    };
    logs('Body --> $body');
    Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      return customerModelFromJson(response.body);
    } else {
      throw 'Failed to register as a customer.';
    }
  }

  Future<Map<String, dynamic>> createPaymentIntents() async {
    final String url = '$baseUrl/payment_intents';
    logs('Url --> $url');
    Map<String, String> body = {
      'amount': '2000',
      'currency': 'inr',
      'payment_method_types[]': 'card',
      'description': 'A new customer',
    };

    Response response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      logs('Response --> ${response.body}');
      return json.decode(response.body);
    } else {
      logs(json.decode(response.body));
      throw 'Failed to create PaymentIntents.';
    }
  }
}
