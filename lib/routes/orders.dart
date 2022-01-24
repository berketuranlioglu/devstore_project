import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devstore_project/objects/order_button.dart';
import 'package:devstore_project/objects/users.dart';
import 'package:devstore_project/routes/add_comments.dart';
import 'package:devstore_project/routes/product_view.dart';
import 'package:devstore_project/routes/profile.dart';
import 'package:devstore_project/services/db.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:intl/intl.dart';

DBService db = DBService();

final FirebaseAuth auth = FirebaseAuth.instance;

final User user = auth.currentUser!;
final uid = user.uid;

class OrdersView extends StatefulWidget {
  const OrdersView({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _OrdersViewState createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {

  //analytics begin
  Future<void> _currentScreen() async {
    await widget.analytics.setCurrentScreen(
        screenName: 'Orders View', screenClassOverride: 'ordersView');
  }

  Future<void> _setLogEvent() async {
    await widget.analytics
        .logEvent(name: 'orders_view', parameters: <String, dynamic>{});
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
                  "Orders",
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for(int i = 0; i < usersClass.orders.length; i++)
                        Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                                  child: Text(
                                    DateFormat('d MMMM y').format(
                                        usersClass.orders[i]["date"].toDate()
                                    ),
                                    style: OrdersPage_Date,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                              child: OrderButton(
                                status: usersClass.orders[i]['status'],
                                reference: usersClass.orders[i]['product'],
                                analytics: widget.analytics,
                                observer: widget.observer,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: OutlinedButton(
                                  onPressed: () {
                                    pushNewScreen(
                                      context,
                                      screen: AddCommentsView(
                                        id: usersClass.orders[i]['product'].id.toString(),
                                        username: usersClass.username,
                                        analytics: widget.analytics,
                                        observer: widget.observer,
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Comment about it",
                                        style: GoogleFonts.openSans(
                                          color: AppColors.primaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal, //orders page order date
                                        ),
                                      ),
                                      SizedBox(width:4),
                                      Icon(
                                        Icons.arrow_forward,
                                        size: 20,
                                        color: AppColors.primaryColor,
                                      ),
                                    ],
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: AppColors.primaryColor,
                                      width: 2,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height:32),
                ],
              ),
            ),
            backgroundColor: AppColors.mainBackgroundColor,
          );
        }
        return Scaffold();
      },
    );
  }
}