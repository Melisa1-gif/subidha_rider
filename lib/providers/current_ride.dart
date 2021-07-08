import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CurrentRide extends ChangeNotifier {
  bool isSelected = false;
  String documentId = '';
  DocumentSnapshot riderDetailDocument;

  CurrentRide() {
    FirebaseAuth fbAuth = FirebaseAuth.instance;
    () async {
      var bookingDetail = await FirebaseFirestore.instance
          .collection('booking')
          .where('isRiderFound', isEqualTo: true)
          .where(
            'rider_id',
            isEqualTo: fbAuth.currentUser.uid,
          )
          .get();
      if(bookingDetail.docs.length > 0) {
        setIsSelected(true, bookingDetail.docs[0].reference.id);
      }
    }.call();
  }

  setIsSelected(bool value, id) async {
    FirebaseAuth fbAuth = FirebaseAuth.instance;
    final DocumentReference bookingDetail =
        FirebaseFirestore.instance.collection('booking').doc(id);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(bookingDetail, {
        'isRiderFound': true,
        'rider_id': fbAuth.currentUser.uid,
      });
    });
    DocumentSnapshot document = await bookingDetail.get();
    riderDetailDocument = document;
    isSelected = value;
    documentId = id;
    notifyListeners();
  }
}
