import 'package:clockecommerce/models/products.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/screens/home/components/categories.dart';
import 'package:clockecommerce/screens/home/components/advertisement_banner.dart';
import 'package:clockecommerce/screens/home/components/home_header.dart';
import 'package:clockecommerce/screens/home/components/latest_product.dart';
import 'package:clockecommerce/screens/home/components/special_offers.dart';
import 'package:clockecommerce/services/api_service.dart';
import 'package:flutter/material.dart';

class HomeDetail extends StatefulWidget {
  const HomeDetail ({ Key? key }) : super(key: key);

  @override
  State<HomeDetail> createState() => _HomeDetailState();
}

class _HomeDetailState extends State<HomeDetail> {
  late Future<List<Products>?> future;  

  @override
  void initState() {
    super.initState();
    future = APIService.getFeaturedProduct();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(10)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            DiscountBanner(),
            Category(),
            SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30)),
            LatestProducts(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}

