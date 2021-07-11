import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:subidharider/screens/passwordchange.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  TextEditingController nameController = TextEditingController();

  FirebaseAuth fbAuth = FirebaseAuth.instance;
  final picker = ImagePicker();
  File newImage;

  @override
  void initState() {
    nameController.text = fbAuth.currentUser.displayName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth fbAuth = FirebaseAuth.instance;
    var user = fbAuth.currentUser;
    var image = NetworkImage(user.photoURL);
    return new Scaffold(
        body: new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              AppBar(
                title: Text('Edit Profile'),
              ),
              Column(
                children: <Widget>[
                  new Container(
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                  image: AssetImage('assets/2.png'),
                                ),
                              ],
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(25.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Personal Information',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      _status ? _getEditIcon() : new Container(),
                                    ],
                                  )
                                ],
                              )),
                          Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 40.0,
                              backgroundImage:
                              newImage == null ? image : FileImage(newImage),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: !_status
                                ? TextButton(
                              child: Text(
                                'Click to change image',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                              onPressed: () async {
                                final pickedFile = await picker.getImage(
                                    source: ImageSource.gallery);
                                setState(() {
                                  newImage = File(pickedFile.path);
                                });
                              },
                            )
                                : SizedBox.shrink(),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Name',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Flexible(
                                    child: TextFormField(
                                      controller: nameController,
                                      enabled: !_status,
                                      autofocus: !_status,
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Email ID',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.only(left: 25.0, right: 25.0),
                            child: TextFormField(
                              enabled: false,
                              initialValue: user.email,
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: 25.0, right: 25.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: !_status
                                  ? TextButton(
                                child: Text(
                                  'Click to change password',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PasswordchangePage()));
                                },
                              )
                                  : SizedBox.shrink(),
                            ),
                          ),
                          !_status ? _getActionButtons() : new Container(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Save"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () async {
                      FirebaseAuth fbAuth = FirebaseAuth.instance;
                      if (newImage != null) {
                        FirebaseStorage _storage = FirebaseStorage.instance;
                        var reference = _storage
                            .ref()
                            .child("images/" + fbAuth.currentUser.uid + ".jpg");
                        var uploadTask = await reference.putFile(newImage);
                        fbAuth.currentUser.updateProfile(
                          displayName: nameController.value.text,
                          photoURL: await uploadTask.ref.getDownloadURL(),
                        );
                      } else {
                        if (nameController.value.text !=
                            fbAuth.currentUser.displayName) {
                          fbAuth.currentUser.updateProfile(
                            displayName: nameController.value.text,
                          );
                        }
                      }

                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("Cancel"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}
