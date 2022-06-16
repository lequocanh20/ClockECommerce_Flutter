import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/screens/favorite/components/body.dart';
import 'package:clockecommerce/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({ Key? key }) : super(key: key);
  static String routeName = "/favorite";
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
        title: Text("Yêu thích", style: TextStyle(color: Colors.black)),
        backgroundColor: kPrimaryColor,
      ),
      body: Body(),
      backgroundColor: Color(0xFFF5F6F9));
  }
}