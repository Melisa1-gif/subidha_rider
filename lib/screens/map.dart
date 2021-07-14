import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:subidharider/api.dart';
import 'package:subidharider/providers/current_ride.dart';
import 'package:subidharider/screens/user_selection_list.dart';
import 'package:provider/provider.dart';

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
    zoom: 16.0,
  );

  //List userProfilesList = [];
  final userInfo = FirebaseFirestore.instance.collection('booking');

  bool isSelected;
  List userProfileList = [];
  DocumentSnapshot riderDetailDocument;
  Set<Marker> _markers = {};
  Set<Polyline> _polyline;
  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  @override
  void initState() {
    getInfo();
//    fetchDatabaseList();
    super.initState();
  }

  getInfo() {
    userInfo.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        print(doc.data);
      });
    });
  }

  Position currentPosition;
  PolylinePoints polylinePoints = PolylinePoints();

  bool hasMeet;
  void setupPositionLocator() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;

    LatLng pos = LatLng(position.latitude, position.longitude);
    CameraPosition cp = new CameraPosition(target: pos, zoom: 16);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
  }

  @override
  Widget build(BuildContext context) {
    isSelected = context.watch<CurrentRide>().isSelected;
    hasMeet = context.watch<CurrentRide>().hasMeet;
    riderDetailDocument = context.watch<CurrentRide>().riderDetailDocument;
    _polyline = context.watch<CurrentRide>().polyline;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: isSelected
          ? FloatingActionButton(
              child: Icon(Icons.location_searching),
              onPressed: () async {
                print('loading polyline');
                if (_polyline.isNotEmpty) return;
                List<LatLng> polylineCoordinates = [];
                PolylinePoints polylinePoints = PolylinePoints();
                PolylineResult polylineResult =
                    await polylinePoints.getRouteBetweenCoordinates(
                  kDirectionApi,
                  PointLatLng(
                      double.parse(riderDetailDocument['destinationLat']),
                      double.parse(riderDetailDocument['destinationLng'])),
                  PointLatLng(double.parse(riderDetailDocument['sourceLat']),
                      double.parse(riderDetailDocument['sourceLng'])),
                );
                for(PointLatLng point in polylineResult.points) {
                  polylineCoordinates
                      .add(LatLng(point.latitude, point.longitude));
                }
                Polyline polyline = Polyline(
                  polylineId: PolylineId("polyline"),
                  color: Color.fromARGB(255, 40, 122, 198),
                  points: polylineCoordinates,
                );
                LatLng newLocation = LatLng(double.parse(riderDetailDocument['sourceLat']), double.parse(riderDetailDocument['sourceLng']));
                CameraPosition cpp = new CameraPosition(target: newLocation, zoom: 16);
                mapController.animateCamera(CameraUpdate.newCameraPosition(cpp));
                context.read<CurrentRide>().setPolyline(polyline);
              },
            )
          : null,
      body: Stack(
        children: [
          GoogleMap(
            polylines: _polyline,
            initialCameraPosition: initialCameraPosition,
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              mapController = controller;
              setState(() {
                setupPositionLocator();
              });
            },
          ),
          Padding(
              padding: EdgeInsets.all(40.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                ],
              )),
          isSelected
              ? Positioned(
                  right: 0,
                  bottom: 0,
                  left: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.0),
                          topRight: Radius.circular(18.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10.0,
                          spreadRadius: 0.5,
                          offset: Offset(0.7, 0.7),
                        ),
                      ],
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: ListView(
                        children: [
                          Text(
                            'Name',
                            style:
                                Theme.of(context).textTheme.overline.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          Text(riderDetailDocument['user_name'],
                              style: TextStyle(color: Colors.black)),
                          Text(
                            'Source',
                            style:
                                Theme.of(context).textTheme.overline.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          Text(riderDetailDocument['sourceName'],
                              style: TextStyle(color: Colors.black)),
                          Text(
                            'Destination',
                            style:
                                Theme.of(context).textTheme.overline.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          Text(riderDetailDocument['destinationName'],
                              style: TextStyle(color: Colors.black)),
                          Text(
                            'Phone Number',
                            style:
                                Theme.of(context).textTheme.overline.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          Text(riderDetailDocument['phone_number'],
                              style: TextStyle(color: Colors.black)),
                          Wrap(
                            children: [
                              riderDetailDocument['hasMeet']
                                  ? SizedBox.shrink()
                                  : MaterialButton(
                                      color: Theme.of(context).primaryColor,
                                      child: Text('Picked up'),
                                      onPressed: () {
                                        context.read<CurrentRide>().setHasMeet(
                                            true,
                                            riderDetailDocument.reference.id);
                                      },
                                    ),
                              riderDetailDocument['hasMeet']
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        MaterialButton(
                                          color: Theme.of(context).primaryColor,
                                          child: Text('Dropped'),
                                          onPressed: () async {
                                            await context
                                                .read<CurrentRide>()
                                                .setCompleted(
                                                    riderDetailDocument
                                                        .reference.id);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              backgroundColor: Colors.green,
                                              content:
                                                  Text('Successfully dropped'),
                                            ));
                                          },
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                              SizedBox(
                                width: 20.0,
                              ),
                              MaterialButton(
                                color: Theme.of(context).errorColor,
                                child: Text('Cancel'),
                                onPressed: () {
                                  context.read<CurrentRide>().clearPolyline();
                                  context.read<CurrentRide>().cancleSelection(
                                      riderDetailDocument.reference.id);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Positioned(
                  right: 0,
                  bottom: 0,
                  left: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.0),
                          topRight: Radius.circular(18.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10.0,
                          spreadRadius: 0.5,
                          offset: Offset(0.7, 0.7),
                        )
                      ],
                    ),
                    child: UserSelectionList(
                      isSelected: isSelected,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

}
