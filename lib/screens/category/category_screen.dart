import 'package:clockecommerce/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class CategoryScreen extends StatelessWidget {
  static String routeName = "/categoryDetail";
  const CategoryScreen({Key? key}) : super(key: key);

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
        title: const Text("Category Details"),
      ),
      body: Body(ModalRoute.of(context)!.settings.arguments as int));
  }
}