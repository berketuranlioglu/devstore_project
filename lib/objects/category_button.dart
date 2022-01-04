import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:devstore_project/routes/inner_category.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class categoryButton extends StatefulWidget {
  const categoryButton({Key? key, required this.image, required this.title, required this.analytics, required this.observer})
      : super(key: key);
  final String title;
  final String image;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _categoryButtonState createState() => _categoryButtonState();
}

class _categoryButtonState extends State<categoryButton> {

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {
        print(MediaQuery.of(context).size.width),
        pushNewScreen(
          context,
          screen: InnerCategory(title: widget.title, analytics: widget.analytics, observer: widget.observer),
        ),
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: (Image.network(
                widget.image,
                width: 70, height: 70,
              )),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                widget.title,
                style: GoogleFonts.openSans(
                  color: AppColors.primaryColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
      style: ElevatedButton.styleFrom(
        primary: AppColors.categoryButtonColor,
        fixedSize: Size(
            MediaQuery.of(context).size.width / 2.5,
            120
        ),
      ),
    );
  }
}

