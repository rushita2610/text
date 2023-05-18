import 'package:flutter/material.dart';

import '../BottomNavigationBarScreen/BottomNavigationScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  Future<Null> getSharedPrefs() async {
    print("enter");

    Future.delayed(const Duration(seconds: 5), () async {
      print("enter navigation");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavigationScreen(0),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: colorButtonGradientOne,
      body: SingleChildScrollView(
        child: Container(
          //color: Colors.green,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            "assets/images/splash.gif",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
