import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordchangePage extends StatefulWidget{
  @override
  _PasswordchangePageState createState() =>new _PasswordchangePageState();
}
class _PasswordchangePageState extends State<PasswordchangePage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  GlobalKey formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      backgroundColor: Theme.of(context).primaryColor,
        body: Form(
          key: formKey,
          child: new ListView(
            padding: EdgeInsets.all(20.0),
            children: [
              TextFormField(
                controller: oldPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Old Password',
                ),
                validator: (value) {
                  if(value == null || value.length <= 0) {
                    return 'Compulsory Field';
                  }
                  return null;
                },
                style: TextStyle(color: Colors.white60),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'New Password',
                ),
                style: TextStyle(color: Colors.white60),
                validator: (value) {
                  if(value == null || value.length <= 0) {
                    return 'Compulsory Field';
                  }
                  return null;
                },
              ),
              MaterialButton(
                child: Text('Change Password'),
                onPressed: () async {
                  String currentPassword = oldPasswordController.text.trim();
                  String newPassword = passwordController.text.trim();
                  final user =  FirebaseAuth.instance.currentUser;
                  final cred = EmailAuthProvider.credential(
                      email: user.email, password: currentPassword);

                  user.reauthenticateWithCredential(cred).then((value) {
                    user.updatePassword(newPassword).then((value) {
                      oldPasswordController.text = '';
                      passwordController.text = '';
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Successfully changed password.'),
                      ));
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Error occurred try again later.'),
                      ));
                    });
                  }).catchError((err) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Error occurred try again later.'),
                    ));
                  });
                },
              ),
            ],
          ),
        ),
    );
  }



}
