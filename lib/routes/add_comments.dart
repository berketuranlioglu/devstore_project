import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devstore_project/objects/products.dart';
import 'package:devstore_project/objects/users.dart';
import 'package:devstore_project/routes/edit_product.dart';
import 'package:devstore_project/routes/seller_profile.dart';
import 'package:devstore_project/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:devstore_project/utils/dimension.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:intl/intl.dart';

import 'cart.dart';

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

DBService db = DBService();

final FirebaseAuth auth = FirebaseAuth.instance;

final User user = auth.currentUser!;
final uid = user.uid;

String formatTimestamp(Timestamp timestamp) {
  assert(timestamp != null);
  String convertedDate;
  convertedDate = DateFormat.yMMMd().format(timestamp.toDate());
  return convertedDate;
}

class AddCommentsView extends StatefulWidget {
  const AddCommentsView(
      {Key? key,
        required this.id,
        required this.username,
        required this.analytics,
        required this.observer})
      : super(key: key);

  final String id;
  final String username;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _AddCommentsViewState createState() => _AddCommentsViewState();
}

void buttonClicked() {
  print('Button Clicked');
}

final isSelected = <bool>[true, false, false];
String comment = "";

class _AddCommentsViewState extends State<AddCommentsView> {
  final int _current = 0;
  final CarouselController _controller = CarouselController();

  //analytics begin
  Future<void> _currentScreen() async {
    await widget.analytics.setCurrentScreen(
        screenName: 'Product Page', screenClassOverride: 'productPage');
  }

  Future<void> _setLogEvent() async {
    await widget.analytics
        .logEvent(name: 'product_page', parameters: <String, dynamic>{});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.productsCollection.doc(widget.id).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Products productsClass =
          Products.fromJson(snapshot.data!.data() as Map<String, dynamic>);
          List<dynamic> contents = productsClass.imageURL;
          return Scaffold(
            backgroundColor: AppColors.mainBackgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: IconButton(
                splashRadius: 16.0,
                onPressed: () => {Navigator.pop(context)},
                icon: const Icon(Icons.arrow_back_ios_rounded,
                    color: Colors.black),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network(
                    productsClass.imageURL[0],
                    height: 200,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Comment about ${productsClass.productName}",
                              style: fav_camp_recomBanner,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.grey[200],
                              filled: true,
                              hintText: 'Comment',
                              hintStyle:
                              const TextStyle(fontSize: 14.0),
                              prefixIcon: const Icon(
                                  Icons.comment,
                                  color: Colors.grey),
                              contentPadding:
                              const EdgeInsets.all(12.0),
                              enabledBorder:
                              const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(15)),
                              ),
                            ),
                            maxLines: 5,
                            enableSuggestions: false,
                            autocorrect: false,
                            validator: (value) {
                              if (value == null) {
                                return 'Details field cannot be empty';
                              } else {
                                String trimmedValue =
                                value.trim();
                                if (trimmedValue.isEmpty) {
                                  return 'Details field cannot be empty';
                                }
                              }
                              return null;
                            },
                            onSaved: (value) {
                              if (value != null) {
                                comment = value;
                              }
                            },
                            onChanged: (value) {
                              if (value != null) {
                                comment = value;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: [
                        Text("Your rating:"),
                        SizedBox(width:12),
                        Container(
                          width: 120,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.grey[200],
                              filled: true,
                              hintText: 'Rating',
                              hintStyle:
                              const TextStyle(fontSize: 14.0),
                              prefixIcon: const Icon(
                                Icons.star,
                                color: AppColors.starColor,
                              ),
                              contentPadding:
                              const EdgeInsets.all(12.0),
                              enabledBorder:
                              const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(15)),
                              ),
                            ),
                            enableSuggestions: false,
                            autocorrect: false,
                            validator: (value) {
                              if (value == null) {
                                return 'Details field cannot be empty';
                              } else {
                                String trimmedValue =
                                value.trim();
                                if (trimmedValue.isEmpty) {
                                  return 'Details field cannot be empty';
                                }
                              }
                              return null;
                            },
                            onSaved: (value) {
                              if (value != null) {
                                comment = value;
                              }
                            },
                            onChanged: (value) {
                              if (value != null) {
                                comment = value;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height:20),
                ],
              ),
            ),
          );
        }
        return const Scaffold();
      },
    );
  }
}
