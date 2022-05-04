import 'package:clockecommerce/screens/cart/cart_screen.dart';
import 'package:clockecommerce/screens/category/category_screen.dart';
import 'package:clockecommerce/screens/details/details_screen.dart';
import 'package:clockecommerce/screens/home/home_screen.dart';
import 'package:clockecommerce/screens/login_success/login_success_screen.dart';
import 'package:clockecommerce/screens/sign_in/sign_in_screen.dart';
import 'package:clockecommerce/screens/sign_up/sign_up_screen.dart';
import 'package:clockecommerce/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName:(context) => DetailsScreen(),
  CategoryScreen.routeName:(context)=> const CategoryScreen(),
  CartScreen.routeName: (context) => CartScreen()
};