import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:subidharider/screens/ride_history_list.dart';

class RideHistoryPage extends StatefulWidget {
  @override
  _RideHistoryPageState createState() => new _RideHistoryPageState();
}

class _RideHistoryPageState extends State<RideHistoryPage> {
  final FirebaseAuth fbAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Query bookingCollection = FirebaseFirestore.instance
        .collection('booking')
        .where('rider_id', isEqualTo: fbAuth.currentUser.uid)
        .where('isCompleted', isEqualTo: true);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('View ride history'),
      ),
      body: Container(
        child: FutureBuilder(
          future: bookingCollection.get(),
          builder: (context, bookingSnapshot) {
            if (bookingSnapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (bookingSnapshot.hasError) {
                return Center(
                  child: Text('An error occured'),
                );
              } else {
                if (bookingSnapshot.data.docs.length == 0) {
                  return Center(
                    child: Text('No Ride History'),
                  );
                }
                return new ListView(
                  children:
                      List.generate(bookingSnapshot.data.docs.length, (index) {
                    var dataWithDetails = bookingSnapshot.data.docs[index];
                    return RideHistoryListTile(
                      user_name: dataWithDetails['user_name'],
                      sourceName: dataWithDetails['sourceName'],
                      destinationName: dataWithDetails['destinationName'],
                      phone_number: dataWithDetails['phone_number'],
                    );
                  }),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
