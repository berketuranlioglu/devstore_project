import 'package:devstore_project/objects/inner_category_products.dart';
import 'package:devstore_project/objects/product_button.dart';
import 'package:devstore_project/routes/product_view.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class InnerCategory extends StatefulWidget {
  const InnerCategory({Key? key, required this.title,  required this.analytics, required this.observer})
      : super(key: key);
  final String title;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _InnerCategoryState createState() => _InnerCategoryState();
}

class _InnerCategoryState extends State<InnerCategory> {

  //analytics begin
  Future<void> _currentScreen() async {
    await widget.analytics.setCurrentScreen(
        screenName: '${widget.title} View', screenClassOverride: '${widget.title}View');
  }

  Future<void> _setLogEvent() async {
    await widget.analytics
        .logEvent(name: '${widget.title}_view', parameters: <String, dynamic>{});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(Icons.arrow_back_ios_rounded,
                color: AppColors.secondaryColor)),
        title: Text(
          widget.title,
          style: GoogleFonts.openSans(
            color: AppColors.secondaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        shadowColor: Colors.transparent,
        toolbarHeight: MediaQuery.of(context).size.height / 9,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                  child: InnerCategoryProducts(title: widget.title, analytics: widget.analytics, observer: widget.observer),
                ),
              ],
            ),
        ),
      ),
      backgroundColor: AppColors.mainBackgroundColor,
    );
  }
}
