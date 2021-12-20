import 'package:flutter/material.dart';
import 'package:miniprojet/modules/shop_app/login/shop_login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: ShopLoginScreen(),
    );
  }
}
