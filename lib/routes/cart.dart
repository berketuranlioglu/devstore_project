import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devstore_project/objects/cart_container.dart';
import 'package:devstore_project/objects/users.dart';
import 'package:devstore_project/routes/feed.dart';
import 'package:devstore_project/routes/profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:devstore_project/utils/dimension.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:devstore_project/services/db.dart';

import 'checkout.dart';

DBService db = DBService();

class cart extends StatefulWidget {
  const cart({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _cartState createState() => _cartState();
}

final FirebaseAuth auth = FirebaseAuth.instance;

final User user = auth.currentUser!;
final uid = user.uid;
int totalAmount = 0;

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
    return FutureBuilder(
      future: db.userCollection.doc(uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Users usersClass =
              Users.fromJson(snapshot.data!.data() as Map<String, dynamic>);

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
                backgroundColor: AppColors.mainBackgroundColor,
                elevation: 0,
                toolbarHeight: MediaQuery.of(context).size.height / 9,
                leading: const SizedBox(),
                leadingWidth: 15,
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => {
                      pushNewScreen(
                        context,
                        screen: Profile(
                            analytics: widget.analytics,
                            observer: widget.observer),
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
              child: Center(
                child: Column(
                  children: [
                    for (int i = 0; i < usersClass.cart.length; i++)
                      cartContainer(
                          reference: usersClass.cart[i]['prodReference'],
                          analytics: widget.analytics,
                          observer: widget.observer),
                    const SizedBox(
                      height: 32,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      color: Colors.grey,
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Total Amount:",
                                style: cartTotalAmount,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                "\$999.00",
                                style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      color: const Color(0xFFFFFFFF),
                      height: 38.0,
                      width: 115.0,
                      child: FlatButton(
                        onPressed: () {
                          pushNewScreen(context,
                              screen: CheckoutView(
                                  analytics: widget.analytics,
                                  observer: widget.observer),
                              );
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
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      color: const Color(0xFFFFFFFF),
                      height: 38.0,
                      width: 115.0,
                      child: FlatButton(
                        onPressed: () {
                          pushNewScreen(context,
                              screen: FeedView(
                                  analytics: widget.analytics,
                                  observer: widget.observer),
                              withNavBar: true);
                        },
                        child: Text(
                          'CONTINUE',
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
            ),
          );
        }
        return Scaffold();
      },
    );
  }
}
