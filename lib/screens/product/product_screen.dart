import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/screens/home/home_screen.dart';
import 'package:clockecommerce/screens/product/components/body.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  static String routeName = "/productList";
  const ProductScreen({ Key? key }) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text("Danh sách sản phẩm", style: TextStyle(color: Colors.black)),
        backgroundColor: kPrimaryColor,
      ),
      body: Body(),
      backgroundColor: Color(0xFFF5F6F9)
    );
  }
}