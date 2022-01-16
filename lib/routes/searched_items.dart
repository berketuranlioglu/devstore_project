import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devstore_project/objects/product_button.dart';
import 'package:devstore_project/objects/products.dart';
import 'package:devstore_project/services/db.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

DBService db = DBService();

class SearchedItems extends StatefulWidget {
  const SearchedItems({Key? key, required this.text, required this.analytics, required this.observer})
      : super(key: key);

  final String text;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _SearchedItemsState createState() => _SearchedItemsState();
}

class _SearchedItemsState extends State<SearchedItems> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.productsCollection.doc(widget.text).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Products productsClass =
          Products.fromJson(snapshot.data!.data() as Map<String, dynamic>);
          List<dynamic> contents = productsClass.imageURL;
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () => {Navigator.pop(context)},
                  icon: Icon(Icons.arrow_back_ios_rounded,
                      color: AppColors.secondaryColor)),
              title: Text(
                "Search Results",
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
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 30,
                  runSpacing: 10,
                  children: [
                    productButton(reference: db.productsCollection.doc(widget.text), analytics: widget.analytics, observer: widget.observer),
                  ],
                ),
              ),
            ),
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
        leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(Icons.arrow_back_ios_rounded,
                color: AppColors.secondaryColor)),
        title: Text(
          "Search Results",
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
      body: Center(
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 30,
          runSpacing: 10,
          children: [
            Container(color:Colors.black, width: 200, height: 200,)
          ],
        ),
      ),
    );
 */
