import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  //List userProfilesList = [];
  final userInfo = FirebaseFirestore.instance.collection('booking');

//  Future getUsersInfo() async {
//    List itemsList =[];
//    try {
//      await userInfo.get().then((querySnapshot) {
//        querySnapshot.docs.forEach((element) {
//          itemsList.add(element.data);
//
//        });
//      });
//      return itemsList;
//    } catch (e) {
//      print(e.toString());
//      return null;
//    }
//  }

  List userProfileList = [];

  @override
  void initState() {
    getInfo();
//    fetchDatabaseList();
    super.initState();
  }

//  fetchDatabaseList() async{
//    dynamic resultant = await getUsersInfo();
//
//    if(resultant == null) {
//      print('Unavle to retrieve');
//    }
//    else{
//      setState(() {
//        userProfileList = resultant;
//      });
//    }
//
//  }

  getInfo() {
    userInfo.get().then((QuerySnapshot snapshot){
      snapshot.docs.forEach((DocumentSnapshot doc) {
        print(doc.data);
      });
    });
  }

  //fetchDatabaseList() async {
  //dynamic resultant = await ().bookride();
  //if (resultant==null){
  //print('Unable to retrieve');
  //}else{
  //setState(() {
  //userProfilesList = resultant;
  //});
  //}
  //}
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
              )),
          Positioned(
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
                child: ListView.builder(
                  itemCount: userProfileList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(userProfileList[index].data['user_name']),
                        subtitle: Text(userProfileList[index].data['phone_number']),
                        leading: CircleAvatar(
                          child: Image(
                            image: AssetImage('assets/2.png'),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }
}
