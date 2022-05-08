import 'package:clockecommerce/screens/favorite/components/body.dart';
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
    return Body();
  }
}