import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/screens/confirm_address_order/components/body.dart';
import 'package:flutter/material.dart';

class ConfirmAddress extends StatefulWidget {
  const ConfirmAddress({ Key? key }) : super(key: key);
  static String routeName = '/confirmAddress';
  @override
  State<ConfirmAddress> createState() => _ConfirmAddressScreenState();
}

class _ConfirmAddressScreenState extends State<ConfirmAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Xác nhận thông tin giao hàng", style: TextStyle(color: Colors.black)),
        backgroundColor: kPrimaryColor,
      ),
      body: Body(),
    );
  }
}