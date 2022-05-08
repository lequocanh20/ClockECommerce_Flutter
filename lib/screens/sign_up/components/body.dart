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
                Text("Đăng ký tài khoản", style: headingStyle),
                Text(
                  "Nhập thông tin cá nhân của bạn hoặc \ntiếp tục với các trang mạng xã hội khác",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight! * 0.04),
                SignUpForm(),
                SizedBox(height: SizeConfig.screenHeight! * 0.04),                
                Text(
                  'Để tiếp tục bạn cần đồng ý \nvới các điều khoản của chúng tôi',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
