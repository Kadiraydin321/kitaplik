import 'package:flutter/material.dart';
import 'package:kitaplik/Pages/Login_Page.dart';
import 'package:kitaplik/Services/global_veriable.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kitaplık',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(colors[1]),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: LoginPage(),
    );
  }
}


