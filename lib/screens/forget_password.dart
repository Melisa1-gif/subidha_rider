import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:subidharider/custom/Notification.dart';
import 'package:subidharider/screens/login.dart';
import 'package:subidharider/screens/welcome.dart';


class ForgotpasswordPage extends StatefulWidget {
  @override
  _ForgotpasswordPageState createState() => new _ForgotpasswordPageState();
}
class _ForgotpasswordPageState extends State<ForgotpasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;

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
        IconData icon,
        String hintText,
        bool isObscured,
        ThemeData theme,
        Function validation,
        TextEditingController controller,
        bool isNumberOnly}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          icon: new Icon(icon ?? Icons.person),
        ),
        keyboardType: isNumberOnly ? TextInputType.number : TextInputType.text,
        inputFormatters: isNumberOnly
            ? [

        ]
            : [],
        validator: validation,
      ),
    );
  }

  SizedBox buildRegisterBtn(ThemeData theme) {
    return SizedBox(
      width: 250.0,
      child: RaisedButton(
        onPressed: () async{
          if (_formKey.currentState.validate()) {
            String email = _emailController.text.trim();
            print(_emailController.text);
            try {
              await _auth.sendPasswordResetEmail(email: email);
              if(email != null){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
                CustomNotification(
                  title: 'Password Reset',
                  message: 'Please check yor email',
                  color: Colors.green,
                ).show(context);
              }
              _emailController.text = '';
            } catch (e) {
              if (e.code == 'network-request-failed') {
                CustomNotification(
                  title: 'Network Error',
                  message:
                  'No Network Connection. Check your connection and try again.',
                  color: Theme.of(context).errorColor,
                ).show(context);
              } else if(e.code == 'user-not-found'){
                CustomNotification(
                  title: 'Error',
                  message: '$email is not Registered.',
                  color: Theme.of(context).errorColor,
                ).show(context);
              }else if (e.code == 'user-disabled') {
                CustomNotification(
                  title: 'Error',
                  message: 'Your Account is disabled.',
                  color: Theme.of(context).errorColor,
                ).show(context);
              }else {
                CustomNotification(
                  title: 'Sign In Error',
                  message: e.code.toString() + 'An error occurred!',
                  color: Theme.of(context).errorColor,
                ).show(context);
              }
            }
          }
        },
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        color: theme.buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Text('Verify'),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  final _emailRegularExpression = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: new AppBar(title: new Text('Forgot Password?')),
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
                      buildInputField(
                        labelText: 'Email Address',
                        controller: _emailController,
                        icon: Icons.email,
                        hintText: 'Enter email',
                        isObscured: false,
                        theme: theme,
                        validation: (value) {
                          if (value.isEmpty) {
                            return 'Field is required';
                          } else if (!_emailRegularExpression.hasMatch(value)) {
                            print('email');
                            return 'Enter valid email';
                          }
                          return null;
                        },
                        isNumberOnly: false,
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      buildRegisterBtn(theme),
                      SizedBox(
                        height: 18.0,
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

