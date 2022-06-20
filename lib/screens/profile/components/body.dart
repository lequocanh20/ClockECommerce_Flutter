import 'package:clockecommerce/screens/order_history/order_history_screen.dart';

import 'package:clockecommerce/services/shared_service.dart';
import 'package:flutter/material.dart';

import 'profile_menu.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfileMenu(
            text: "Lịch sử mua hàng",
            icon: "assets/icons/Bell.svg",
            press: () => {
              Navigator.pushNamed(context, OrderHistoryScreen.routeName)
            },
          ),
          ProfileMenu(
            text: "Đăng xuất",
            icon: "assets/icons/Log out.svg",
            press: () {
              SharedService.logout(context);
            },
          ),
        ],
      ),
    );
  }
}
