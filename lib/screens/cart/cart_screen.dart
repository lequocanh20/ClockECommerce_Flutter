import 'package:clockecommerce/models/items.dart';
import 'package:flutter/material.dart';
import 'package:clockecommerce/models/carts.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Items> cartDetails = Cart().getCart();
  @override
  Widget build(BuildContext context) {
    return Body();
  }
}
