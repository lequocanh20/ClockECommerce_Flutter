import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Bạn chưa có tài khoản?",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
            child: Text(
              "Đăng ký",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(16),
                  color: kPrimaryColor),
            ),
          ),
        )        
      ],
    );
  }
}