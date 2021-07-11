import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:subidharider/custom/Notification.dart';

class ContactsupportPage extends StatefulWidget {
  @override
  _ContactsupportPageState createState() => new _ContactsupportPageState();
}
class _ContactsupportPageState extends State<ContactsupportPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController;
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _nameController = TextEditingController();
    _messageController = TextEditingController();

  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneNumberController.dispose();
    _nameController.dispose();
    _messageController.dispose();
    super.dispose();
  }

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

  Padding buildInputField({String labelText,
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
        keyboardType: isNumberOnly ? TextInputType.number : TextInputType.text,
        inputFormatters: isNumberOnly
            ? [
          WhitelistingTextInputFormatter.digitsOnly,
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
          submit();
        },
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        color: theme.buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Text('Send Message'),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  final _emailRegularExpression = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final RegExp phoneNumberRegExp =
  new RegExp(r"^(984|985|986|974|975|980|981|982|961|988|972|963)\d{7}$");
  bool switchValue = false;
  final FirebaseAuth fbAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('CONTACT US'),
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
                        'Send your Message',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1,
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      Text(
                        ' Address: Kathmandu, Nepal',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText2,
                      ),
                      Text(
                        ' Call: 9869665883',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText2,
                      ),
                      Text(
                        ' Email: subhida@gmail.com',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText2,
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      buildInputField(
                        labelText: 'Your Name',
                        controller: _nameController,
                        icon: Icons.account_circle,
                        hintText: 'Enter your name',
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
                      buildInputField(
                        labelText: 'Email Address',
                        controller: _emailController,
                        icon: Icons.email,
                        hintText: 'Enter your email address',
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
                        height: 10.0,
                      ),

                      buildInputField(
                        labelText: 'Mobile Number',
                        controller: _phoneNumberController,
                        icon: Icons.phone,
                        hintText: 'Enter phone number',
                        isObscured: false,
                        theme: theme,
                        validation: (value) {
                          if (value.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                        isNumberOnly: true,
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      buildInputField(
                        labelText: 'Message',
                        controller: _messageController,
                        icon: Icons.message,
                        hintText: 'Enter your message',
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
                      Text(
                        'Let us know what we can do ',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText2,
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      buildRegisterBtn(theme),
                      SizedBox(
                        height: 18.0,
                      ),
                      //buildRegisterBtn(theme),
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

  submit() async{
    try {
      FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
      firebaseFireStore.collection('Support').add({
        'Name': _nameController.value.text,
        'Email': _emailController.value.text,
        'Message': _messageController.value.text,
        'Phone': _phoneNumberController.value.text,
      }).then((value) {
        _nameController.text = "";
        _emailController.text = "";
        _messageController.text = "";
        _phoneNumberController.text = "";
      });
      CustomNotification(
        title: 'Successful',
        color: Colors.green,
        message:
        'Successfully Submitted',
      ).show(context);
    } catch (e) {
      print(e.toString());
    }

  }
}