import 'package:devstore_project/objects/selling_product_button.dart';
import 'package:devstore_project/objects/sold_product_button.dart';
import 'package:devstore_project/routes/product_view.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class SellingProducts extends StatefulWidget {
  const SellingProducts({Key? key, required this.isSelling, required this.analytics, required this.observer})
      : super(key: key);

  final bool isSelling;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _SellingProductsState createState() => _SellingProductsState();
}

class _SellingProductsState extends State<SellingProducts> {
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
          if(widget.isSelling)
            SellingProductButton(analytics: widget.analytics, observer: widget.observer),
        for(int i = 0; i < length; i++)
          if(!widget.isSelling)
            SoldProductButton(analytics: widget.analytics, observer: widget.observer),
      ],
    );
  }
}
