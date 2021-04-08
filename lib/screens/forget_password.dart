import 'package:flutter/material.dart';
import 'package:subidharider/screens/welcome.dart';


class ForgotpasswordPage extends StatefulWidget {
  @override
  _ForgotpasswordPageState createState() => new _ForgotpasswordPageState();
}
class _ForgotpasswordPageState extends State<ForgotpasswordPage> {
  final TextEditingController _emailController = TextEditingController();

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
        onPressed: () {
          if (_formKey.currentState.validate()) {
            print(_emailController.text);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WelcomePage()),
            );
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

