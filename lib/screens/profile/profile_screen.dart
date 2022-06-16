import 'package:clockecommerce/models/constants.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tiện ích", style: TextStyle(color: Colors.black)),
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
      ),
      body: Body(),
    );
  }
}
