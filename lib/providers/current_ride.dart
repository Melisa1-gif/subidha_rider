import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:subidharider/api.dart';

class CurrentRide extends ChangeNotifier {
  bool isSelected = false;
  bool hasMeet = false;
  String documentId = '';
  DocumentSnapshot riderDetailDocument;
  Set<Polyline> polyline = {};

  setPolyline(Polyline poly) {
    polyline.add(poly);
    notifyListeners();
  }

  clearPolyline() {
    polyline.clear();
    notifyListeners();
  }

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
      if (bookingDetail.docs.length > 0) {
        setIsSelected(true, bookingDetail.docs[0].reference.id);
      }
    }.call();
  }

  setIsSelected(bool value, id) async {
    try {
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
      notifyListeners();
      documentId = id;
    } catch (e) {
      print(e.toString());
    }
  }

  setHasMeet(bool value, id) async {
    FirebaseAuth fbAuth = FirebaseAuth.instance;
    final DocumentReference bookingDetail =
        FirebaseFirestore.instance.collection('booking').doc(id);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(bookingDetail, {
        'hasMeet': true,
        'rider_id': fbAuth.currentUser.uid,
      });
    });
    DocumentSnapshot document = await bookingDetail.get();
    riderDetailDocument = document;
    hasMeet = value;
    documentId = id;
    notifyListeners();
  }

  cancleSelection(id) async {
    FirebaseAuth fbAuth = FirebaseAuth.instance;
    final DocumentReference bookingDetail =
        FirebaseFirestore.instance.collection('booking').doc(id);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(bookingDetail, {
        'hasMeet': false,
        'isRiderFound': false,
        'isCompleted': false,
      });
    });
    DocumentSnapshot document = await bookingDetail.get();
    riderDetailDocument = document;
    isSelected = false;
    hasMeet = false;
    documentId = id;
    notifyListeners();
  }

  setCompleted(id) async {
    FirebaseAuth fbAuth = FirebaseAuth.instance;
    final DocumentReference bookingDetail =
        FirebaseFirestore.instance.collection('booking').doc(id);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(bookingDetail, {
        'hasMeet': true,
        'isRiderFound': true,
        'isCompleted': true,
      });
    });
    DocumentSnapshot document = await bookingDetail.get();
    riderDetailDocument = document;
    isSelected = false;
    hasMeet = false;
    documentId = id;
    notifyListeners();
  }
}
