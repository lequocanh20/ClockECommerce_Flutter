import 'package:clockecommerce/components/no_account_text.dart';
import 'package:clockecommerce/components/socal_card.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:flutter/material.dart';
import 'sign_form.dart';

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
                SizedBox(height: SizeConfig.screenHeight! * 0.04),
                Image.asset('assets/images/logo.png', height: getProportionateScreenWidth(200), width: getProportionateScreenWidth(200),),
                SizedBox(height: SizeConfig.screenHeight! * 0.04),
                SignForm(),
                SizedBox(height: SizeConfig.screenHeight! * 0.08),
                SizedBox(height: getProportionateScreenHeight(20)),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
