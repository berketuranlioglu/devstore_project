import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devstore_project/objects/product_button.dart';
import 'package:devstore_project/objects/products.dart';
import 'package:devstore_project/services/db.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'categories.dart';

DBService db = DBService();

class InnerCategoryProducts extends StatefulWidget {
  const InnerCategoryProducts({Key? key, required this.title, required this.analytics, required this.observer})
      : super(key: key);
  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _InnerCategoryProductsState createState() => _InnerCategoryProductsState();
}

class _InnerCategoryProductsState extends State<InnerCategoryProducts> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.categoriesCollection.doc(widget.title).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Categories categoriesClass =
          Categories.fromJson(snapshot.data!.data() as Map<String, dynamic>);
          return Wrap(
            alignment: WrapAlignment.start,
            spacing: 30,
            runSpacing: 10,
            children: [
              for(int i = 0; i < categoriesClass.productReference.length; i++)
                productButton(reference: categoriesClass.productReference[i], analytics: widget.analytics, observer: widget.observer),
            ],
          );
        }
        return Scaffold();
      },
    );
  }
}

/*
Wrap(
      alignment: WrapAlignment.start,
      spacing: 30,
      runSpacing: 10,
      children: [
        for(int i = 0; i < length; i++)
          productButton(analytics: widget.analytics, observer: widget.observer),
      ],
    );
 */
