import 'package:flutter/material.dart';

class RideHistoryListTile extends StatelessWidget {
  final String user_name;
  final String sourceName;
  final String destinationName;
  final String phone_number;

  RideHistoryListTile({
    @required this.user_name,
    @required this.sourceName,
    @required this.destinationName,
    @required this.phone_number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
      ),
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          ListTile(
            dense: true,
            leading: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Text(
                'Name',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              user_name,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            dense: true,
            leading: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Text(
                'Source',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              sourceName,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            dense: true,
            leading: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Text(
                'Destination',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              destinationName,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            dense: true,
            leading: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Text(
                'Phone_number',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              phone_number,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
