import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/screens/home/components/categories.dart';
import 'package:clockecommerce/screens/home/components/discount_banner.dart';
import 'package:clockecommerce/screens/home/components/home_header.dart';
import 'package:clockecommerce/screens/home/components/popular_product.dart';
import 'package:clockecommerce/screens/home/components/special_offers.dart';
import 'package:flutter/material.dart';

class HomeDetail extends StatelessWidget {
  const HomeDetail ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            DiscountBanner(),
            Category(),
            SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30)),
            PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}

