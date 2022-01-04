import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class New extends StatefulWidget {
  const New({Key? key}) : super(key: key);

  @override
  _NewState createState() => _NewState();
}

String messageTitle = "Empty";
String notificationAlert = "alert";

FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

class _NewState extends State<New> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
