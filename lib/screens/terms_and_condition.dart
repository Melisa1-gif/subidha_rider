import 'package:flutter/material.dart';

class TermsandconditionPage extends StatefulWidget {
  @override
  _TermsandconditionPageState createState() =>
      new _TermsandconditionPageState();
}

class _TermsandconditionPageState extends State<TermsandconditionPage> {
//  bool _checkbox = false;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final theme = Theme.of(context);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Terms and condition'),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 10.0),
        child: Container(
          color: theme.primaryColor,
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 16.0),
          child: new Column(
            //  alignment: Alignment.topCenter,
              children: <Widget>[
                new Text(
                  "Terms and Condition",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.0),
                new Text(
                  "Please review our terms of use and privacy policy carefully before downloading.",
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 10.0),
                new Text(
                  "By downloading, installing, and/or using the Subhida application, you agree that you have read, understood and accepted and agreed to these Terms of Use.The words “Drivers” and “Partners” here are used interchangeably meaning people who use the application to give rides. The word “Client” here means people who use the application to find rides.",
                ),
                SizedBox(
                  height: 7.0,
                ),
                // Text(
                // "I agree all the conditions",
                //style: Theme
                //  .of(context)
                //.textTheme
                //.caption,
                //textAlign: TextAlign.left,
                //),
//                CheckboxListTile(
//                    title: Text("I agree all the conditions"),
//                    value: _checkbox,
//                    onChanged: (bool newValue) {
//                      setState(
//                        () {
//                          _checkbox = newValue;
//                        },
//                      );
//                    }),
//                Row(
//                  children: [
//                    RaisedButton(
//                      child: Text(
//                        'Submit',
//                        style: TextStyle(
//                          color: Colors.black,
//                        ),
//                      ),
//                      onPressed: () {
//                        _checkbox
//                            ? Navigator.of(context).pushReplacement(
//                                MaterialPageRoute(
//                                    builder: (context) => RegisterPage()))
//                            : null;
//                      },
//                    ),
//                  ],
//                )
              ]),
        ),
      ),
    );
  }
}
