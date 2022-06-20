import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3, milliseconds: 30), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container( 
        height: double.infinity, 
        width: double.infinity, 
        child: Image.asset("assets/images/gif_splashscreen.gif", 
          gaplessPlayback: true, 
          fit: BoxFit.fill
        )
      )
    );
  }
}
