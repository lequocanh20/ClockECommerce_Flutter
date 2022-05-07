import 'package:clockecommerce/models/categories.dart';
import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class CategoryScreen extends StatelessWidget {
  static String routeName = "/categoryDetail";
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Categories;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(args.name, style: TextStyle(color: Colors.black)),
        backgroundColor: kPrimaryColor,
      ),
      body: Body(args.id),
      backgroundColor: Color(0xFFF5F6F9));     
  }
}