import 'dart:convert';

import 'package:clockecommerce/components/default_button.dart';
import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/models/utilities.dart';
import 'package:clockecommerce/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CheckoutCard extends StatefulWidget {
  double sum = 0.0;
  CheckoutCard({
    Key? key,
    required this.sum
  }) : super(key: key);

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  Map<String, dynamic>? paymentIntentData;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                Text("Nhập mã khuyến mãi"),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: Utilities.formatCurrency(widget.sum),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Thanh toán",
                    press: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("Xác nhận đặt hàng"),
                        content: const Text("Bạn sẽ xác nhận đặt hàng chứ ?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Hủy'),
                            child: Text('Hủy'),
                          ),
                          TextButton(
                            onPressed: () async {
                              await makePayment();
                              // Fluttertoast.showToast(
                              //   msg: "Bạn đã đặt hàng thành công",
                              //   toastLength: Toast.LENGTH_SHORT,
                              //   gravity: ToastGravity.TOP,
                              //   timeInSecForIosWeb: 1,
                              //   backgroundColor: Colors.green,
                              //   textColor: Colors.white,
                              //   fontSize: 16.0
                              // );
                              // Navigator.pushNamed(context, HomeScreen.routeName);                              
                            },
                            child: Text('Xác nhận'),
                          ),
                        ],
                      )
                  ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    try {

      paymentIntentData =
      await createPaymentIntent('20', 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      final billingDetails = BillingDetails(
        name: 'Flutter Stripe',
        email: 'email@stripe.com',
        phone: '+840774642207',
        address: Address(
          city: 'TPHCM',
          country: 'VI',
          line1: 'Lien Ap 2-6',
          line2: '',
          state: 'Binh Chanh',
          postalCode: '700000',
        ),
      );
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              customerId: paymentIntentData!['customer'],
              customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
              applePay: true,
              googlePay: true,
              testEnv: true,
              style: ThemeMode.dark,
              billingDetails: billingDetails,
              merchantCountryCode: 'US',
              merchantDisplayName: 'ANNIE')).then((value){
      });


      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {

    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
            clientSecret: paymentIntentData!['client_secret'],
            confirmPayment: true,
          )).then((newValue){


        print('payment intent'+paymentIntentData!['id'].toString());
        print('payment intent'+paymentIntentData!['client_secret'].toString());
        print('payment intent'+paymentIntentData!['amount'].toString());
        print('payment intent'+paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;

      }).onError((error, stackTrace){
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });


    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount('20'),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer sk_test_51K2C1tGvDddAkKFYNEn9tIptqJZoxZhGWk8yBNUWae9uLksd6bkHHyEWKrHAhi2DvmLDSPe0wyxAGmk0gSCRlXu800VEXM0Ii6',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100 ;
    return a.toString();
  }
}
