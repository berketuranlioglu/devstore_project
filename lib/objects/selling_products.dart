import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devstore_project/objects/selling_product_button.dart';
import 'package:devstore_project/objects/sold_product_button.dart';
import 'package:devstore_project/objects/users.dart';
import 'package:devstore_project/routes/account_info.dart';
import 'package:devstore_project/routes/product_view.dart';
import 'package:devstore_project/services/db.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

final User user = auth.currentUser!;
final uid = user.uid;

DBService db = DBService();

Future<String> userNameFinal = getUserName(uid);
final firestoreInstance = FirebaseFirestore.instance;
void printData() {
  firestoreInstance.collection('users').doc("password").get();
}

Future<Map<String, dynamic>?> getUser(String uid) async {
  var data =
  await firestoreInstance.collection("users").doc(uid).get().then((value) {
    return value.data();
  });
  return data;
}

Future<String> getUserName(String uid) async {
  var userData = {};
  userData = (await getUser(uid))!;
  var a = await getUser(uid);
  print(userData["username"]);
  return userData["username"];
}

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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.userCollection.doc(user.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Users userClass =
          Users.fromJson(snapshot.data!.data() as Map<String, dynamic>);

          return Wrap(
            alignment: WrapAlignment.start,
            spacing: 30,
            runSpacing: 10,
            children: [
              for(int i = 0; i < userClass.productReference.length; i++)
                if(widget.isSelling)
                  SellingProductButton(reference: userClass.productReference[i], analytics: widget.analytics, observer: widget.observer),
              for(int i = 0; i < userClass.productReference.length; i++)
                if(!widget.isSelling)
                  SoldProductButton(reference: userClass.productReference[i], analytics: widget.analytics, observer: widget.observer),
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
          if(widget.isSelling)
            SellingProductButton(analytics: widget.analytics, observer: widget.observer),
        for(int i = 0; i < length; i++)
          if(!widget.isSelling)
            SoldProductButton(analytics: widget.analytics, observer: widget.observer),
      ],
    );
 */