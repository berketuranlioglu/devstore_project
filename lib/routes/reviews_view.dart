import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devstore_project/objects/users.dart';
import 'package:devstore_project/routes/product_view.dart';
import 'package:devstore_project/services/db.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/dimension.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

DBService db = DBService();

final FirebaseAuth auth = FirebaseAuth.instance;

final User user = auth.currentUser!;
final uid = user.uid;

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

class ReviewsView extends StatefulWidget {
  const ReviewsView({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _ReviewsViewState createState() => _ReviewsViewState();
}

class _ReviewsViewState extends State<ReviewsView> {
//analytics begin
  Future<void> _currentScreen() async {
    await widget.analytics.setCurrentScreen(
        screenName: 'Reviews View', screenClassOverride: 'reviewsView');
  }

  Future<void> _setLogEvent() async {
    await widget.analytics
        .logEvent(name: 'reviews_view', parameters: <String, dynamic>{});
  }

  String username = "";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.userCollection.doc(uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Users usersClass =
              Users.fromJson(snapshot.data!.data() as Map<String, dynamic>);
          getUserName(uid).then((value) {
            username = value;
          });
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Reviews",
                style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: AppColors.mainBackgroundColor,
              elevation: 0,
              toolbarHeight: MediaQuery.of(context).size.height / 9,
              leading: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 8,
                ),
                child: IconButton(
                  splashRadius: 16.0,
                  onPressed: () => {Navigator.pop(context)},
                  icon: const Icon(Icons.arrow_back_ios_rounded,
                      color: Colors.black),
                ),
              ),
              leadingWidth: 40,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < usersClass.comments.length; i++)
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                              child: Text(
                                DateFormat('d MMMM y').format(
                                    usersClass.comments[i]["date"].toDate()),
                                style: OrdersPage_Date,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.secondaryColor,
                              border: Border.all(
                                width: 1.0,
                                color: AppColors.secondaryColor,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 6, 6, 6),
                                    child: Image.network(
                                      usersClass.imageUrl!,
                                      width: 40.0,
                                      height: 40.0,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: AppColors.starColor,
                                              size: 16.0,
                                            ),
                                            Text(
                                              ' Rating: (',
                                              style: productPageRating,
                                            ),
                                            Text(
                                              usersClass.comments[i]['rating']
                                                  .toString(),
                                              style: productPageRating,
                                            ),
                                            Text(
                                              '/5)',
                                              style: productPageRating,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              usersClass.username,
                                              style: productPageSellerText2,
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Wrap(children: [
                                      Text(
                                        usersClass.comments[i]['comment'],
                                        style: productPageRating,
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(6, 6, 6, 0),
                          child: OutlinedButton(
                            onPressed: () => {
                              pushNewScreen(
                                context,
                                screen: productView(
                                    id: usersClass.comments[i]['product'].id
                                        .toString(),
                                    username: username,
                                    analytics: widget.analytics,
                                    observer: widget.observer),
                                withNavBar: false,
                              ),
                            },
                            child: Text(
                              "Visit that product",
                              style: GoogleFonts.openSans(
                                color: AppColors.primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              fixedSize: Size(160, 20),
                              side: const BorderSide(
                                color: AppColors.primaryColor,
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                      ],
                    ),
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
