import 'package:devstore_project/routes/checkout.dart';
import 'package:devstore_project/routes/feed.dart';
import 'package:devstore_project/routes/pers_nav_bar.dart';
import 'package:devstore_project/routes/categories_view.dart';
import 'package:devstore_project/routes/cart.dart';
import 'package:devstore_project/routes/favorites.dart';
import 'package:devstore_project/routes/orders.dart';
import 'package:devstore_project/routes/profile.dart';
import 'package:flutter/material.dart';
import 'package:devstore_project/routes/welcome.dart';
import 'package:devstore_project/routes/login.dart';
import 'package:devstore_project/routes/signup.dart';
import 'package:devstore_project/routes/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:devstore_project/routes/onbording.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:devstore_project/utils/dimension.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/routes/profile.dart';
import 'package:devstore_project/objects/category_button.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class cart extends StatefulWidget {
  const cart({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<cart> {

  //analytics begin
  Future<void> _currentScreen() async {
    await widget.analytics.setCurrentScreen(
        screenName: 'Shopping Cart', screenClassOverride: 'cart');
  }

  Future<void> _setLogEvent() async {
    await widget.analytics
        .logEvent(name: 'cart', parameters: <String, dynamic>{});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
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
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: Dimen.regularPadding16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'assets/iphone13pro.png',
                    height: 100,
                    width: 100,
                  ),
                ],
              ),
            ),
            Text(
              "iPhone 13 Pro Max 256 GB Sierra Blue",
              textAlign: TextAlign.left,
              style: GoogleFonts.openSans(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Apple',
              textAlign: TextAlign.left,
              style: GoogleFonts.openSans(
                color: Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              '991,30\$',
              textAlign: TextAlign.left,
              style: GoogleFonts.openSans(
                color: Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
            ),
            Padding(
              padding: Dimen.regularPadding16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'assets/iphone13pro.png',
                    height: 100,
                    width: 100,
                  ),
                ],
              ),
            ),
            Text(
              "iPhone 13 Pro Max 1 TB Sierra Blue",
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Apple',
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                color: Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              '1.099,00\$',
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                color: Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
            ),
            Padding(
              padding: Dimen.regularPadding16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
            Padding(
              padding: Dimen.regularPadding16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
            Container(
              child: Text(
                'Subtotal 2.090,3\$',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Container(
              child: Text(
                'Shipping 8,99\$',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Container(
              child: Text(
                'TOTAL 2.099,29\$',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: Dimen.regularPadding16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
            Container(
              color: const Color(0xFFFFFFFF),
              height: 38.0,
              width: 115.0,
              child: FlatButton(
                onPressed: () {
                  pushNewScreen(context, screen: CheckoutView());
                },
                child: Text(
                  'CHECKOUT',
                  style: signupPage_ButtonTxts,
                ),
                color: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
