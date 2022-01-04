import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devstore_project/objects/categories.dart';
import 'package:devstore_project/services/db.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:devstore_project/utils/dimension.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/routes/profile.dart';
import 'package:devstore_project/objects/category_button.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

DBService db = DBService();

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {

  //analytics begin
  Future<void> _currentScreen() async {
    await widget.analytics.setCurrentScreen(
        screenName: 'Category Page', screenClassOverride: 'categories');
  }

  Future<void> _setLogEvent() async {
    await widget.analytics
        .logEvent(name: 'categories_page', parameters: <String, dynamic>{});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.categoriesCollection.doc('category_names').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Categories categoriesClass =
          Categories.fromJson(snapshot.data!.data() as Map<String, dynamic>);
          return Scaffold(
            appBar: AppBar(
                title: Text(
                  "Categories",
                  style: GoogleFonts.openSans(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                backgroundColor: AppColors.backgroundColor,
                shadowColor: Colors.transparent,
                toolbarHeight: MediaQuery.of(context).size.height / 9,
                leading: const SizedBox(),
                leadingWidth: 15,
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => {
                      pushNewScreen(
                        context,
                        screen: Profile(analytics: widget.analytics, observer: widget.observer),
                      ),
                    },
                    child: const Icon(
                      Icons.account_circle_rounded,
                      color: AppColors.primaryColor,
                      size: 40,
                    ),
                  ),
                  const SizedBox(width: 10),
                ]),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Wrap(
                      direction: Axis.horizontal,
                      runSpacing: 10,
                      children: [
                        for (int i = 0; i < categoriesClass.products.length; i++)
                          Padding(
                            padding: Dimen.twoButtonsRowPadding,
                            child: categoryButton(
                                image: categoriesClass.products[i]["imageURL"],
                                title: categoriesClass.products[i]["name"],
                                analytics: widget.analytics,
                                observer: widget.observer),
                          )
                      ],
                    ),
                  ),
                  SizedBox(height:25),
                ],
              ),
            ),
            backgroundColor: AppColors.backgroundColor,
          );
        }
        return Scaffold();
      },
    );
  }
}
/*
Scaffold(
      appBar: AppBar(
          title: Text(
            "Categories",
            style: GoogleFonts.openSans(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: AppColors.backgroundColor,
          shadowColor: Colors.transparent,
          toolbarHeight: MediaQuery.of(context).size.height / 9,
          leading: const SizedBox(),
          leadingWidth: 15,
          actions: <Widget>[
            FlatButton(
              onPressed: () => {
                pushNewScreen(
                    context,
                    screen: Profile(analytics: widget.analytics, observer: widget.observer),
                ),
              },
              child: const Icon(
                Icons.account_circle_rounded,
                color: AppColors.primaryColor,
                size: 40,
              ),
            ),
            const SizedBox(width: 10),
          ]),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: Dimen.twoButtonsRowPadding,
              child: twoButtonsRow(
                  "assets/category_computers.png",
                  "Computers & Tablets",
                  "assets/category_phones.png",
                  "Phones"),
            ),
            Padding(
              padding: Dimen.twoButtonsRowPadding,
              child: twoButtonsRow(
                  "assets/category_accessories.png",
                  "Electronic Accessories",
                  "assets/category_tv.png",
                  "TVs & Sound"),
            ),
            Padding(
              padding: Dimen.twoButtonsRowPadding,
              child: twoButtonsRow("assets/category_gaming.png", "Gaming",
                  "assets/category_smart_watch.png", "Wearables"),
            ),
            Padding(
              padding: Dimen.twoButtonsRowPadding,
              child: twoButtonsRow(
                  "assets/category_kitchen_appliances.png",
                  "Kitchen Appliances",
                  "assets/category_personal_care.png",
                  "Personal Care"),
            ),
            Padding(
              padding: Dimen.twoButtonsRowPadding,
              child: twoButtonsRow(
                  "assets/category_home_appliances.png",
                  "Home Appliances",
                  "assets/category_camera.png",
                  "Photography & Camera"),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
    );
 */
