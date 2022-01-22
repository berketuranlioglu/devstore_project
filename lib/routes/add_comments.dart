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
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:intl/intl.dart';

import 'cart.dart';

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
double rating = 0.0;
final _formKey = GlobalKey<FormState>();

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
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
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
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                                maxLines: 3,
                                enableSuggestions: false,
                                autocorrect: false,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Type your comment.';
                                  } else {
                                    String trimmedValue =
                                    value.trim();
                                    if (trimmedValue.isEmpty) {
                                      return 'Type your comment.';
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
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            const Text("Your rating:"),
                            const SizedBox(width:12),
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
                                    return 'Type your rating.';
                                  } else {
                                    String trimmedValue =
                                    value.trim();
                                    if (trimmedValue.isEmpty) {
                                      return 'Type your rating.';
                                    }
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  if (value != null) {
                                    rating = double.parse(value);
                                  }
                                },
                                onChanged: (value) {
                                  if (value != null) {
                                    rating = double.parse(value);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                        child: Container(
                          width: 200,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Posting The Comment!'),
                                  ),
                                );
                              }
                              DateTime currentPhoneDate =
                                DateTime.now();
                              Timestamp myTimeStamp =
                                Timestamp.fromDate(currentPhoneDate);

                              DocumentReference ref =
                              FirebaseFirestore.instance
                                  .collection('products')
                                  .doc(widget.id);

                              Map<String, dynamic> dataUser = {
                                'comment': comment,
                                'date': myTimeStamp,
                                'rating': rating,
                                'product': ref,
                              };
                              Map<String, dynamic> dataProducts = {
                                'comment': comment,
                                'date': myTimeStamp,
                                'rating': rating,
                                'ppUrl': "https://i.stack.imgur.com/l60Hf.png",
                                'username': widget.username,
                              };
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .update({
                                'comments':
                                FieldValue.arrayUnion([dataUser])
                              }).whenComplete(() {
                                print('Added to Comments');
                              });
                              FirebaseFirestore.instance
                                  .collection('products')
                                  .doc(widget.id)
                                  .update({
                                'comments':
                                FieldValue.arrayUnion([dataProducts])
                              }).whenComplete(() {
                                print('Added to Comments');
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Post your comment",
                                  style: GoogleFonts.openSans(
                                    color: AppColors.primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal, //orders page order date
                                  ),
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
                      ),
                      const SizedBox(height:20),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return const Scaffold();
      },
    );
  }
}
