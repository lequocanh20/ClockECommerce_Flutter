import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/screens/home/components/home_fragment.dart';
import 'package:clockecommerce/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> screen = [
      HomeDetail(),
      ProfileScreen()
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectIndex,
        onTap: (index) {
          setState(() {
            selectIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg"),
            activeIcon: SvgPicture.asset(
              "assets/icons/Shop Icon.svg",
            color: kPrimaryColor),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg"),
            activeIcon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: kPrimaryColor),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/Heart Icon.svg"),
            activeIcon: SvgPicture.asset("assets/icons/Heart Icon.svg",
            color: kPrimaryColor),
            label: 'Favorite',
          ),   
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/Chat bubble Icon.svg"),
            activeIcon: SvgPicture.asset("assets/icons/Chat bubble Icon.svg",
            color: kPrimaryColor),
            label: 'Chat',
          ),         
        ],
      ),
      body: screen[selectIndex],
    );
  }
}
