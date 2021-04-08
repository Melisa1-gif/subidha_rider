import 'package:flutter/material.dart';
import 'package:subidharider/screens/login.dart';

class MainScreen extends StatefulWidget {
  static const String idScreen = "mainscreen";
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return  Scaffold(
        body: LoginPage()
    );
  }
}

