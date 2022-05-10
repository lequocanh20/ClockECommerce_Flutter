import 'package:clockecommerce/components/default_button.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight! * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight! * 0.4, //40%
        ),
        SizedBox(height: SizeConfig.screenHeight! * 0.08),
        Text(
          "Đăng nhập thành công",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth! * 0.6,
          child: DefaultButton(
            text: "Về trang chủ",
            press: () {
              Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}
