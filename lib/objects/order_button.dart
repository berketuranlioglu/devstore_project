import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devstore_project/objects/products.dart';
import 'package:devstore_project/services/db.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

DBService db = DBService();

class OrderButton extends StatefulWidget {
  const OrderButton({Key? key, required this.status, required this.reference, required this.analytics, required this.observer})
      : super(key: key);

  final String status;
  final dynamic reference;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  @override
  Widget build(BuildContext context) {
    String id = widget.reference.id.toString();
    return FutureBuilder(
      future: db.productsCollection.doc(id).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Products productsClass =
          Products.fromJson(snapshot.data!.data() as Map<String, dynamic>);

          return Container(
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              border: Border.all(
                width: 1.0,
                color: AppColors.secondaryColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 6, 6, 6),
                  child: Image.network(
                    productsClass.imageURL[0],
                    width: 80.0,
                    height: 80.0,
                  ),
                ),
              ],
            ),
          );
        }
        return Scaffold();
      },
    );
  }
}
