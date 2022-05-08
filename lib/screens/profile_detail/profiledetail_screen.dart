import 'package:clockecommerce/components/custom_bottom_nav_bar.dart';
import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/enums.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class ProfileDetailScreen extends StatelessWidget {
  static String routeName = "/profile_detail";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin cá nhân", style: TextStyle(color: Colors.black)),
        backgroundColor: kPrimaryColor,
      ),
      body: Body(),
    );
  }
}