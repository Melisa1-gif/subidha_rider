import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:subidharider/custom/source_destination_view.dart';
import 'package:subidharider/providers/current_ride.dart';
import 'package:provider/provider.dart';

class UserSelectionList extends StatefulWidget {
  final bool isSelected;

  UserSelectionList({
    @required this.isSelected,
  });

  @override
  _UserSelectionListState createState() => _UserSelectionListState();
}

class _UserSelectionListState extends State<UserSelectionList> {
  final Query bookingCollectionBike = FirebaseFirestore.instance
      .collection('booking')
      .where('isCompleted', isEqualTo: false)
      .where('ride', isEqualTo: false);

  final Query bookingCollectionCar = FirebaseFirestore.instance
      .collection('booking')
      .where('isCompleted', isEqualTo: false)
      .where('ride', isEqualTo: true);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Bike',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                icon: Icon(Icons.two_wheeler, color: Colors.black,),
              ),
              Tab(
                child: Text(
                  'Car',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                icon: Icon(Icons.directions_car, color: Colors.black,),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Container(
                  child: FutureBuilder(
                    future: bookingCollectionBike.get(),
                    builder: (context, bookingSnapshot) {
                      if (bookingSnapshot.connectionState !=
                          ConnectionState.done) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        if (bookingSnapshot.hasError) {
                          return Center(
                            child: Text('An error occured'),
                          );
                        } else {
                          if (bookingSnapshot.data.docs.length <= 0) {
                            return Column(
                              children: [
                                MaterialButton(
                                  child: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.refresh,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        'Refresh',
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    setState(() {

                                    });
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    'No customer available now who wants bike',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          return new ListView(
                            padding: EdgeInsets.zero,
                            children: <Widget>[
                              MaterialButton(
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.refresh,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      'Refresh',
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  setState(() {

                                  });
                                },
                              )
                            ] + List.generate(
                                bookingSnapshot.data.docs.length, (index) {
                              var dataWithDetails =
                                  bookingSnapshot.data.docs[index];
                              print(dataWithDetails.toString());
                              return SourceDestinationView(
                                user_name: dataWithDetails['user_name'],
                                sourceName: dataWithDetails['sourceName'],
                                distance: dataWithDetails['distance'],
                                destinationName:
                                    dataWithDetails['destinationName'],
                                phone_number: dataWithDetails['phone_number'],
                                onAccept: () {
                                  context.read<CurrentRide>().setIsSelected(
                                      true, dataWithDetails.reference.id);
                                },
                              );
                            }),
                          );
                        }
                      }
                    },
                  ),
                ),
                Container(
                  child: FutureBuilder(
                    future: bookingCollectionCar.get(),
                    builder: (context, bookingSnapshot) {
                      if (bookingSnapshot.connectionState !=
                          ConnectionState.done) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        if (bookingSnapshot.hasError) {
                          return Center(
                            child: Text('An error occured'),
                          );
                        } else {
                          if (bookingSnapshot.data.docs.length <= 0) {
                            return Column(
                              children: [
                                MaterialButton(
                                  child: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.refresh,
                                        color: Colors.blue,
                                      ),
                                      Text(
                                        'Refresh',
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    setState(() {

                                    });
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    'No customer available now who wants car',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          return new ListView(
                            padding: EdgeInsets.zero,
                            children: <Widget>[
                              MaterialButton(
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.refresh,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      'Refresh',
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  setState(() {

                                  });
                                },
                              )
                            ] + List.generate(
                                bookingSnapshot.data.docs.length, (index) {
                              var dataWithDetails =
                                  bookingSnapshot.data.docs[index];
                              return SourceDestinationView(
                                ride: true,
                                user_name: dataWithDetails['user_name'],
                                sourceName: dataWithDetails['sourceName'],
                                distance: dataWithDetails['distance'],
                                destinationName:
                                    dataWithDetails['destinationName'],
                                phone_number: dataWithDetails['phone_number'],
                                onAccept: () {
                                  context.read<CurrentRide>().setIsSelected(
                                      true, dataWithDetails.reference.id);
                                },
                              );
                            }),
                          );
                        }
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}
