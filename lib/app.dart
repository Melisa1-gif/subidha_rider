import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:subidharider/providers/current_ride.dart';
import 'package:subidharider/screens/mainscreen.dart';
import 'package:subidharider/screens/welcome.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => CurrentRide(),
    child: new MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: new ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Color(0xFFE87160),
            primaryColor: Color(0xFF2E3E52),
            buttonColor: Color(0xFF6ADCC8),
            primaryColorDark: Color(0xFF7C8BA6),
          ),
          home: FutureBuilder(
              future: Firebase.initializeApp(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    appBar: AppBar(
                      actions: [
                        IconButton(
                          icon: Icon(Icons.refresh),
                          onPressed: () {
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    body: Center(
                      child: Text(snapshot.error.toString()),
                    ),
                  );
                } else if (snapshot.connectionState != ConnectionState.done) {
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  FirebaseAuth fbAuth = FirebaseAuth.instance;
                  return StreamBuilder(
                    stream: fbAuth.authStateChanges(),
                    builder: (context, user) {
                      if (user.hasError) {
                        return Scaffold(
                          appBar: AppBar(
                            actions: [
                              IconButton(
                                icon: Icon(Icons.refresh),
                                onPressed: () {
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                          body: Center(
                            child: Text(user.error.toString()),
                          ),
                        );
                      } else if (user.connectionState ==
                          ConnectionState.waiting) {
                        return Scaffold(
                          body: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        if (user.data == null) {
                          return MainScreen();
                        } else {
                          return WelcomePage();
                        }
                      }
                    },
                  );
                }
              }),
        ),
  );
}
