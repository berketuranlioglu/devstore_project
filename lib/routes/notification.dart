import 'package:devstore_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:devstore_project/utils/dimension.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/routes/profile.dart';
import 'package:devstore_project/objects/category_button.dart';

class notification extends StatefulWidget {
  const notification({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification> {

  //analytics begin
  Future<void> _currentScreen() async {
    await widget.analytics.setCurrentScreen(
        screenName: 'Feed View', screenClassOverride: 'feedView');
  }

  Future<void> _setLogEvent() async {
    await widget.analytics
        .logEvent(name: 'feed_view', parameters: <String, dynamic>{});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Discounts & Offers",
            style: GoogleFonts.openSans(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: AppColors.backgroundColor,
          shadowColor: Colors.transparent,
          toolbarHeight: MediaQuery.of(context).size.height / 9,
          leading: SizedBox(),
          leadingWidth: 15,
          actions: <Widget>[
            FlatButton(
              onPressed: () => {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new Profile(analytics: widget.analytics, observer: widget.observer))),
              },
              child: Icon(
                Icons.account_circle_rounded,
                color: AppColors.primaryColor,
                size: 40,
              ),
            ),
            SizedBox(width: 10),
          ]),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Padding(
              padding: Dimen.regularPadding8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),

            Container (
              height: 150.0,
              width: 318.0,
              decoration: BoxDecoration(
                color: const Color(0xFFDADADA),
                image: DecorationImage(
                  image: AssetImage(
                      'assets/discount1.jpg',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),

            Padding(
              padding: Dimen.regularPadding16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),

            Container (
              height: 150.0,
              width: 318.0,
              decoration: BoxDecoration(
                color: const Color(0xFFDADADA),
                image: DecorationImage(
                  image: AssetImage(
                      'assets/discount2.png',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),

            Padding(
              padding: Dimen.regularPadding16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),

            Container (
              height: 150.0,
              width: 318.0,
              decoration: BoxDecoration(
                color: const Color(0xFFDADADA),
                image: DecorationImage(
                  image: AssetImage(
                      'assets/discount3.png',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),

            Padding(
              padding: Dimen.regularPadding16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),

            Container (
              height: 150.0,
              width: 318.0,
              decoration: BoxDecoration(
                color: const Color(0xFFDADADA),
                image: DecorationImage(
                  image: AssetImage(
                      'assets/discount4.jpg',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),

            Padding(
              padding: Dimen.regularPadding16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



