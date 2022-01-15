import 'package:devstore_project/routes/feed.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:devstore_project/utils/dimension.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/routes/profile.dart';
import 'package:devstore_project/objects/category_button.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:devstore_project/routes/checkout.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter/src/widgets/text.dart';

class CheckoutSuccessView extends StatefulWidget {
  const CheckoutSuccessView({Key? key}) : super(key: key);

  @override
  _CheckoutSuccessViewState createState() => _CheckoutSuccessViewState();
}

class _CheckoutSuccessViewState extends State<CheckoutSuccessView> {
  final _formKey = GlobalKey<FormState>();
  late final FirebaseAnalytics analytics;
  late final FirebaseAnalyticsObserver observer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                children: [
                  SizedBox(width:115,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Image(
                      image: AssetImage('assets/success.gif'),
                      height: 150.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                Text('Successful', style: GoogleFonts.openSans(
                  color: AppColors.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                Text('Your payment was done successfully', style: GoogleFonts.openSans(
                  color: AppColors.settingsTabBarIconsColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                ),
              ),
              Container(
                height: 50.0,
                width: 355.0,
                child: OutlinedButton(
                  onPressed: () {
                    pushNewScreen(context, screen: FeedView(analytics: analytics, observer: observer));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Okay',
                      style: welcomePage_SignUp,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}