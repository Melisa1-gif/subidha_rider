import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => new _HelpState();
}
class _HelpState extends State <Help> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('About Page'),
      ),
    );
  }
}