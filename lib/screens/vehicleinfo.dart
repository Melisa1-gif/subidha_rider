import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:subidharider/screens/register.dart';

class VehicleInfoPage extends StatefulWidget {
  @override
  _VehicleInfoPageState createState() => _VehicleInfoPageState();
}

class _VehicleInfoPageState extends State<VehicleInfoPage> {
  @override
  final TextEditingController _vehiclenoController = TextEditingController();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  File _image;
  final picker = ImagePicker();
  Container buildTitle(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      alignment: Alignment.bottomCenter,
    );
  }

  Padding buildText(String text, double fontSize, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(color: theme.primaryColorDark, fontSize: fontSize),
      ),
    );
  }

  Padding buildInputField(
      {String labelText,
      String hintText,
      bool isObscured,
      ThemeData theme,
      IconData icon,
      Function validation,
      TextEditingController controller,
      bool isNumberOnly}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          icon: new Icon(icon ?? Icons.person),
          hintStyle: TextStyle(color: theme.primaryColorDark),
        ),
        obscureText: isObscured,
        validator: validation,
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  bool switchValue = false;
  final FirebaseAuth fbAuth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Vehicle Info'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 16.0),
          children: <Widget>[
            Align(
              child: SizedBox(
                width: 320.0,
                child: Card(
                  color: theme.primaryColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      buildTitle(theme),
                      SizedBox(
                        height: 18.0,
                      ),
                      Text(
                        'Vehicle Info',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(
                        height: 18.0,
                      ),

                      buildInputField(
                        labelText: 'Vehicle No.',
                        controller: _vehiclenoController,
                        icon: Icons.time_to_leave,
                        hintText: 'Enter Vehicle No.',
                        isObscured: false,
                        theme: theme,
                        validation: (value) {
                          if (value.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                        isNumberOnly: false,
                      ),

                      SizedBox(
                        height: 18.0,
                      ),
                      TextButton(
                        child: Text(_image == null
                            ? 'Upload image of license'
                            : 'Click to upload image of license'),
                        onPressed: () async {
                          final pickedFile = await picker.getImage(
                              source: ImageSource.gallery);
                          setState(() {
                            _image = File(pickedFile.path);
                          });
                        },
                      ),

                      _image == null
                          ? SizedBox.shrink()
                          : Container(
                              height: 200.0,
                              width: 200.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(_image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      Text(
                        'Choose ride:',
                        style: TextStyle(color: Colors.black),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.directions_bike,
                            color: Colors.blue,
                          ),
                          Switch(
                            value: switchValue,
                            inactiveThumbColor: Colors.blue,
                            inactiveTrackColor: Colors.blue.withAlpha(150),
                            activeColor: Colors.green,
                            onChanged: (value) {
                              setState(() {
                                switchValue = value;
                              });
                            },
                          ),
                          Icon(
                            Icons.time_to_leave,
                            color: Colors.green,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      //buildRegisterBtn(theme),
                      RawMaterialButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        onPressed: () async {
                          if (_image == null &&
                              !_formKey.currentState.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Fill all fields first'),
                            ));
                            return;
                          }
                          final _firebaseAuth = FirebaseAuth.instance;
                          Reference ref = firebaseStorage
                              .ref(_firebaseAuth.currentUser.uid)
                              .child("liscense/");
                          ref.putFile(_image).whenComplete(() async {
                            String imageUrl = await firebaseStorage
                                .ref(
                                    "${_firebaseAuth.currentUser.uid}/liscense")
                                .getDownloadURL();
                            var refa = await FirebaseFirestore.instance
                                .collection("user_info")
                                .where('user_id',
                                    isEqualTo: _firebaseAuth.currentUser.uid)
                                .get();
                            if (refa.docs.length > 0) {
                              FirebaseFirestore.instance
                                  .collection("user_info")
                                  .doc(_firebaseAuth.currentUser.uid)
                                  .update({
                                "vehicle_id": _vehiclenoController.text.trim(),
                                "imageUrl": imageUrl,
                                "ride":
                                    switchValue, //your data which will be added to the collection and collection will be created after this
                              }).then((_) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('Successful'),
                                ));
                                setState(() {
                                  _image = null;
                                  _vehiclenoController.text = "";
                                });
                              }).catchError((err) {
                                print(err.toString());
                              });
                            } else {
                              FirebaseFirestore.instance
                                  .collection("user_info")
                                  .doc(_firebaseAuth.currentUser.uid)
                                  .set({
                                "vehicle_id": _vehiclenoController.text.trim(),
                                "imageUrl": imageUrl,
                                "ride":
                                    switchValue, //your data which will be added to the collection and collection will be created after this
                              }).then((_) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('Successful'),
                                ));
                                setState(() {
                                  _image = null;
                                  _vehiclenoController.text = "";
                                });
                              }).catchError((err) {
                                print(err.toString());
                              });
                            }
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                              content: Text('Successful'),
                            ));
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
