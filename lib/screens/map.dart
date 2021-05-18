import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {

  //Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController mapController;
  bool switchValue = false;
  static final CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(27.69329, 85.32227),
    zoom: 10.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
          ),
          Padding(
              padding: EdgeInsets.all(40.0),
              child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Icon(
                //Icons.event_available,
               // color: Colors.blue,
              //),

              new Text(
                'Available',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 10,
                ),
              ),
              Switch(
                value: switchValue,
                inactiveThumbColor: Colors.blueGrey,
                inactiveTrackColor: Colors.red,
                activeColor: Colors.black,
                onChanged: (value) {
                  setState(() {
                    switchValue = value;
                  });
                },
              ),
              new Text(
                'Not Available',
                style: TextStyle(
                color: Colors.black,
                  fontSize: 10,
                ),
              )
              //Icon(
               // Icons.time_to_leave,
                //color: Colors.red,
              //),
            ],
          )
          ),
        ],
      ),
    );
  }
}
