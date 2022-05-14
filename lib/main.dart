import 'dart:io';
import 'package:clockecommerce/models/routes.dart';
import 'package:clockecommerce/models/theme.dart';
import 'package:clockecommerce/screens/home/home_screen.dart';
import 'package:clockecommerce/screens/splash/splash_screen.dart';
import 'package:clockecommerce/services/shared_service.dart';
import 'package:flutter/material.dart';

Widget _defaultHome = SplashScreen();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool _result = await SharedService.isLoggedIn();
  if (_result) {
    _defaultHome = HomeScreen();
  }
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      home: _defaultHome,
      routes: routes,
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
