// @dart=2.9

import 'package:flutter/material.dart';
import 'package:devstore_project/routes/welcome.dart';
import 'package:devstore_project/routes/login.dart';
import 'package:devstore_project/routes/signup.dart';

void main() => runApp(MaterialApp(
      //home: Welcome(),
      //initialRoute: '/login',
      routes: {
        '/': (context) => Welcome(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
      },
    ));
