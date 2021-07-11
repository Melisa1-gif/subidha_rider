import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:subidharider/custom/Notification.dart';
import 'package:subidharider/screens/forget_password.dart';
import 'package:subidharider/screens/register.dart';
import 'package:subidharider/screens/welcome.dart';

class LoginPage extends StatefulWidget {
  static const String idScreen = "login";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Container buildTitle(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      alignment: Alignment.bottomCenter,
    );
  }
  Padding buildText(String text, double fontSize ,ThemeData theme ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text , style: TextStyle(color: theme.primaryColorDark, fontSize: fontSize),),
    );
  }
  Padding buildInputField(
      {String labelText,
        String hintText,
        String helperText,
        bool isObscured,
        ThemeData theme,
        IconData icon,
        Function validation,
        TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText:labelText,
          hintText: hintText,
          helperText: helperText,
          icon: new Icon(icon ?? Icons.person),
          hintStyle: TextStyle(color: theme.primaryColorDark),
        ),
        obscureText: isObscured,
        validator: validation,
      ),
    );
  }
  SizedBox buildLogInBtn(ThemeData theme) {
    return SizedBox(
      width: 250.0,
      child: RaisedButton(
        onPressed: (){
          signin();
        },
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        color: theme.buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Text('Log In'),
      ),
    );
  }
  SizedBox buildRegisterBtn(ThemeData theme) {
    return SizedBox(
      width: 250.0,
      child: RaisedButton(
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context)=> RegisterPage()),
          );
        },
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        color: theme.buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Text('Register'),
      ),
    );
  }
  SizedBox buildForgotpasswordBtn(ThemeData theme) {
    return SizedBox(
      width: 250.0,
      child: RaisedButton(
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context)=> ForgotpasswordPage()),
          );
        },
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        color: theme.buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Text('Forgot Password?'),
      ),
    );
  }
  final _formKey = GlobalKey<FormState>();
  final _emailRegularExpression = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final FirebaseAuth fbAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return  Scaffold(
      appBar: new AppBar(title: new Text('Rider Login')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16.0, 15.0, 16.0, 16.0),
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
                      Text(
                        'Hello Riders,',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(height: 10.0,),
                      Text(
                        'Welcome to SUBHIDA!',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'SIGN IN YOUR ACCOUNT',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      //buildText('Sign up with your email address',12.0,  theme ),
                      buildInputField(
                        labelText: 'Email Address',
                        controller: _emailController,
                        icon: Icons.email,
                        hintText: 'Enter email',
                        helperText: 'eg. email@email.com',
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
                      ),
                      buildInputField(
                        labelText: 'Password',
                        controller: _passwordController,
                        icon: Icons.vpn_key,
                        hintText: 'Enter password',
                        helperText: '8 or more characters',
                        isObscured: true,
                        theme: theme,
                        validation: (value) {
                          if (value.isEmpty) {
                            return 'Field is required';
                          }
                          else if (value.length < 8) {
                            return '8 or More character';
                          }
                          return null;
                        },
                      ),
                      // buildInputField('Password', '', true, theme),
                      SizedBox(height: 18.0,),
                      buildLogInBtn(theme),
                      //buildText('By signing up you agree with our Terms and Conditions.', 8.0, theme ),
                      //buildText('or', 12.0, theme),
                      RawMaterialButton(
                        child: Text('Forget Password', style: TextStyle(color: Theme.of(context).accentColor,),),
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotpasswordPage()));
                        },
                      ),
                      SizedBox(height: 20.0,),
                      Text(
                        'No Account?',
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.center,
                      ),
                      //buildRegisterBtn(theme),
                      RawMaterialButton(
                        child: Text('Register', style: TextStyle(color: Theme.of(context).accentColor,),),
                        onPressed: (){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RegisterPage()));
                        },
                      ),
                      SizedBox(height: 15.0,),
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
  signin() async {
    if (_formKey.currentState.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text;
      try {
        UserCredential user = await fbAuth.signInWithEmailAndPassword(email: email, password: password);
        if(user != null){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => WelcomePage()));
        }
        _emailController.text = '';
        _passwordController.text = '';
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
            title: 'Sign In Error',
            message: '$email is not Registered.',
            color: Theme.of(context).errorColor,
          ).show(context);
        }else if (e.code == 'user-disabled') {
          CustomNotification(
            title: 'Sign In Error',
            message: 'Your Account is disabled.',
            color: Theme.of(context).errorColor,
          ).show(context);
        }else if(e.code == 'wrong-password'){
          CustomNotification(
            title: 'Sign In Error',
            message: 'Incorrect Password.',
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
  }
}