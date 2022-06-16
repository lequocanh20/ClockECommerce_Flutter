import 'package:clockecommerce/components/socal_card.dart';
import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:flutter/material.dart';

import 'sign_up_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight! * 0.04), // 4%
                Text("Đăng ký tài khoản", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),),
                SizedBox(height: SizeConfig.screenHeight! * 0.04),
                SignUpForm(),
                SizedBox(height: SizeConfig.screenHeight! * 0.04),                              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
