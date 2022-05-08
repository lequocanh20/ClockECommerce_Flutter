import 'package:clockecommerce/screens/category/components/category_detail.dart';
import 'package:clockecommerce/screens/product/components/product_list.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ProductList()
    );
  }
  
}