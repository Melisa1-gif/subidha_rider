import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:subidharider/custom/source_destination_view.dart';

class UserSelectionList extends StatelessWidget {
  final CollectionReference bookingCollection =
      FirebaseFirestore.instance.collection('booking');

  @override
  Widget build(BuildContext context) {
    return Container(
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
              return new ListView(
                children:
                    List.generate(bookingSnapshot.data.docs.length, (index) {
                  var dataWithDetails = bookingSnapshot.data.docs[index];
                  return SourceDestinationView(
                    user_name: dataWithDetails['user_name'],
                    sourceName: dataWithDetails['sourceName'],
                    destinationName: dataWithDetails['destinationName'],
                  );
                }),
              );
            }
          }
        },
      ),
    );
  }
}
