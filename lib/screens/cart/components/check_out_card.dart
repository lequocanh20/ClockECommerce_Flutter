import 'dart:convert';
import 'dart:ffi';

import 'package:clockecommerce/components/default_button.dart';
import 'package:clockecommerce/models/carts.dart';
import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/models/utilities.dart';
import 'package:clockecommerce/screens/confirm_address_order/components/body.dart';
import 'package:clockecommerce/screens/confirm_address_order/confirm_address_screen.dart';
import 'package:clockecommerce/screens/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class CheckoutCard extends StatefulWidget {
  double sum = 0.0;
  List<Cart> cartDetails = [];
  CheckoutCard({
    Key? key,
    required this.sum,
    required this.cartDetails
  }) : super(key: key);

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
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
                    text: "Tổng thanh toán:\n",
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
                  //   press: () => showDialog<String>(
                  //     context: context,
                  //     builder: (BuildContext context) => AlertDialog(
                  //       title: const Text("Xác nhận đặt hàng"),
                  //       content: const Text("Bạn sẽ xác nhận đặt hàng chứ ?"),
                  //       actions: <Widget>[
                  //         TextButton(
                  //           onPressed: () => Navigator.pop(context, 'Hủy'),
                  //           child: Text('Hủy'),
                  //         ),
                  //         TextButton(
                  //           onPressed: () async {
                  //             await makePayment(widget.sum);       
                  //           },
                  //           child: Text('Xác nhận'),
                  //         ),
                  //       ],
                  //     )
                  //   ),
                  // ),
                    press: () => {
                      Navigator.pushNamed(context, ConfirmAddress.routeName, arguments: InformCartArguments(cartDetails: widget.cartDetails, sum: widget.sum))
                    },
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
