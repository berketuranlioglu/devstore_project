import 'package:flutter/material.dart';

class phones extends StatefulWidget {
  const phones({Key? key}) : super(key: key);

  @override
  _phonesState createState() => _phonesState();
}

class _phonesState extends State<phones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "PLACEHOLDER CATEGORY SCREEN",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}