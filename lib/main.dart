// @dart=2.9

import 'package:flutter/material.dart';
import 'package:devstore_project/routes/welcome.dart';
import 'package:devstore_project/routes/login.dart';
import 'package:devstore_project/routes/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(
    //home: Welcome(),
    //initialRoute: '/login',
  ));
}

class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            print('Cannot connect to firebase: '+snapshot.error.toString());
            return MaterialApp(
                routes: {
                  '/': (context) => Welcome(),
                  '/login': (context) => LoginPage(),
                  '/signup': (context) => SignUpPage(),
                }
            );
          }
          if(snapshot.connectionState == ConnectionState.done) {
            print('Firebase connected');
          }

          return MaterialApp(
              routes: {
                '/': (context) => Welcome(),
                '/login': (context) => LoginPage(),
                '/signup': (context) => SignUpPage(),
              }
          );
        }
    );
  }
}