import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/screens/cart/cart_screen.dart';
import 'package:clockecommerce/screens/profile_detail/profiledetail_screen.dart';
import 'package:flutter/material.dart';

import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconBtnWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            press: () => {
              Navigator.pushNamed(context, CartScreen.routeName)
            },
          ),
          IconBtnWithCounter(
            svgSrc: "assets/icons/User Icon.svg",
            press: () => {
              Navigator.pushNamed(context, ProfileDetailScreen.routeName)
            },
          ),
        ],
      ),
    );
  }
}
