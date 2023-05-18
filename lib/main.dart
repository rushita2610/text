import 'package:flutter/material.dart';
import 'ColorConstant/ColorConstant.dart';
import 'Screens/SpashScreen/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reapp Ghana',
      theme: ThemeData(
        primarySwatch: kPrimaryColor,
      ),
      home: const SplashScreen(),
    );
  }
}

