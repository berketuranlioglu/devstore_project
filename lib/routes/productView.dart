import 'package:flutter/material.dart';

class productView extends StatefulWidget {
  const productView({Key? key}) : super(key: key);

  @override
  _productViewState createState() => _productViewState();
}

class _productViewState extends State<productView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "ORDERS SCREEN",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
