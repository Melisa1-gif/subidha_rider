import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:subidharider/screens/register.dart';

class VehicleInfoPage extends StatefulWidget {
  @override
  _VehicleInfoPageState createState() => _VehicleInfoPageState();
}
class _VehicleInfoPageState extends State <VehicleInfoPage> {

  final TextEditingController _vehiclenoController = TextEditingController();
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
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16.0, kToolbarHeight, 16.0, 16.0),
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
                          child: Text(_image == null ? 'Upload image of license' : 'Click to upload image of license'),
                          onPressed: () async {
                            final pickedFile = await picker.getImage(source: ImageSource.gallery);
                            setState(() {
                              _image = File(pickedFile.path);
                            });
                          },
                        ),
                        _image == null ? SizedBox.shrink() : CircleAvatar(
                          radius: 80.0,
                          backgroundImage: FileImage(_image),
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
                          child: Text('Submit', style: TextStyle(color: Theme.of(context).accentColor,),),
                          onPressed: (){
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ), (route) => false);                        },
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
