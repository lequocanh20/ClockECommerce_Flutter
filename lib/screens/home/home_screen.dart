import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/screens/home/components/body.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Body();
  }
}
