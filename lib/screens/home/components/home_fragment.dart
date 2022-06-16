import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/screens/home/components/categories.dart';
import 'package:clockecommerce/screens/home/components/advertisement_banner.dart';
import 'package:clockecommerce/screens/home/components/home_header.dart';
import 'package:clockecommerce/screens/home/components/latest_product.dart';
import 'package:clockecommerce/screens/home/components/special_offers.dart';
import 'package:flutter/material.dart';

class HomeDetail extends StatefulWidget {
  const HomeDetail ({ Key? key }) : super(key: key);

  @override
  State<HomeDetail> createState() => _HomeDetailState();
}

class _HomeDetailState extends State<HomeDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(10)),
            const HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            const DiscountBanner(),
            const Category(),
            const SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30)),
            const LatestProducts(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}

