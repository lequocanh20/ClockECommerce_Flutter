import 'package:clockecommerce/screens/category/components/category_detail.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  String cateId;
  Body(this.cateId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CategoryDetail(cateId));
  }
  
}