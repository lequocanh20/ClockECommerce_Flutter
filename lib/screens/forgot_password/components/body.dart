import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/screens/forgot_password/components/forgot_password_form.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
                Text("Khôi phục mật khẩu", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),),
                SizedBox(height: SizeConfig.screenHeight! * 0.04),
                ForgotPasswordForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}