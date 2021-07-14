import 'package:flutter/material.dart';

class SourceDestinationView extends StatelessWidget {
  final String user_name;
  final String sourceName;
  final String destinationName;
  final String phone_number;
  final double distance;
  final Function onAccept;
  final bool ride;

  SourceDestinationView({
    @required this.user_name,
    @required this.sourceName,
    @required this.destinationName,
    @required this.phone_number,
    @required this.distance,
    @required this.onAccept,
    this.ride = false,
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
                'Distance',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              distance.toStringAsFixed(2) + 'KM',
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
                'Price',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              'Rs.' + estimateFair(ride, distance).toStringAsFixed(0),
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
                'Phone number',
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

          MaterialButton(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                Text(
                  'Accept',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            onPressed: () {
              onAccept.call();
            },
          ),
        ],
      ),
    );
  }
  double estimateFair (bool ride, double _placeDistance) {
    double baseFare;
    double multiplier;
    if(ride) {
      baseFare = 100;
      multiplier = 40;
    }
    else {
      baseFare = 50;
      multiplier = 20;
    }
    double distanceFare = _placeDistance * multiplier;
    return baseFare + distanceFare;
  }
}
