import 'package:flutter/material.dart';

class RideHistoryPage extends StatefulWidget {
  @override
  _RideHistoryPageState createState() => new _RideHistoryPageState();
}
class _RideHistoryPageState extends State <RideHistoryPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('View ride history'),
      ),
    );
  }
}