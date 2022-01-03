import 'package:devstore_project/objects/product_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class InnerCategoryProducts extends StatefulWidget {
  const InnerCategoryProducts({Key? key, required this.analytics, required this.observer})
      : super(key: key);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _InnerCategoryProductsState createState() => _InnerCategoryProductsState();
}

class _InnerCategoryProductsState extends State<InnerCategoryProducts> {
  List exampleList = [1, 2, 3, 4, 5];
  @override
  Widget build(BuildContext context) {
    int length = exampleList.length;
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 30,
      runSpacing: 10,
      children: [
        for(int i = 0; i < length; i++)
          productButton(analytics: widget.analytics, observer: widget.observer),
      ],
    );
  }
}
