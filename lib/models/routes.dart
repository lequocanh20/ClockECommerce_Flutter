import 'package:clockecommerce/screens/cart/cart_screen.dart';
import 'package:clockecommerce/screens/category/category_screen.dart';
import 'package:clockecommerce/screens/confirm_address_order/confirm_address_screen.dart';
import 'package:clockecommerce/screens/details/details_screen.dart';
import 'package:clockecommerce/screens/favorite/favorite_screen.dart';
import 'package:clockecommerce/screens/forgot_password/forgot_password_screen.dart';
import 'package:clockecommerce/screens/home/home_screen.dart';
import 'package:clockecommerce/screens/order_history/order_history_screen.dart';
import 'package:clockecommerce/screens/product/product_screen.dart';
import 'package:clockecommerce/screens/profile/profile_screen.dart';
import 'package:clockecommerce/screens/profile_detail/ProfileDetail_Screen.dart';
import 'package:clockecommerce/screens/promotion/promotion_screen.dart';
import 'package:clockecommerce/screens/search/search_screen.dart';
import 'package:clockecommerce/screens/sign_in/sign_in_screen.dart';
import 'package:clockecommerce/screens/sign_up/sign_up_screen.dart';
import 'package:clockecommerce/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName:(context) => DetailsScreen(),
  CategoryScreen.routeName:(context) => const CategoryScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  ProductScreen.routeName: (context) => ProductScreen(),
  FavoriteScreen.routeName: (context) => FavoriteScreen(),
  SearchScreen.routeName: (context) => SearchScreen(),
  ProfileDetailScreen.routeName: (context) => ProfileDetailScreen(),
  OrderHistoryScreen.routeName: (context) => OrderHistoryScreen(),
  ConfirmAddress.routeName: (context) => ConfirmAddress(),
  PromotionScreen.routeName: (context) => PromotionScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen()
};