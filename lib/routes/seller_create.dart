import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devstore_project/objects/product_button.dart';
import 'package:devstore_project/objects/products.dart';
import 'package:devstore_project/objects/selling_products.dart';
import 'package:devstore_project/objects/users.dart';
import 'package:devstore_project/routes/edit_profile.dart';
import 'package:devstore_project/services/db.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/dimension.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'account_info.dart';

FirebaseAuth auth = FirebaseAuth.instance;

final User user = auth.currentUser!;
final uid = user.uid;

DBService db = DBService();

String productDescription = "";
String productName = "";
int productPrice = 0;
String images = "";
List imageList = [];

final _formKey = GlobalKey<FormState>();

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

class SellerItemCreate extends StatefulWidget {
  const SellerItemCreate(
      {Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _SellerItemCreateState createState() => _SellerItemCreateState();
}

class _SellerItemCreateState extends State<SellerItemCreate> {
  //analytics begin
  Future<void> _currentScreen() async {
    await widget.analytics.setCurrentScreen(
        screenName: 'Seller Item Create',
        screenClassOverride: 'sellerProfileCreate');
  }

  Future<void> _setLogEvent() async {
    await widget.analytics
        .logEvent(name: 'sellerProfileCreate', parameters: <String, dynamic>{});
  }

  dynamic sellingPage = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.userCollection.doc(user.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Products productsClass =
              Products.fromJson(snapshot.data!.data() as Map<String, dynamic>);
          getUserName(uid).then((value) {
            username = value;
          });
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () => {Navigator.pop(context)},
                  icon: const Icon(Icons.arrow_back_ios_rounded,
                      color: AppColors.secondaryColor)),
              title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      "Sell Your Item",
                      style: GoogleFonts.openSans(
                        color: AppColors.secondaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                ),
                SizedBox(width: 10),
                IconButton(
                    onPressed: () {
                      pushNewScreen(context,
                          screen: EditProfilePage(
                              analytics: widget.analytics,
                              observer: widget.observer));
                    },
                    icon: Icon(Icons.edit_outlined)),
              ],
              backgroundColor: AppColors.sellerAppBarColor,
              shadowColor: Colors.transparent,
              toolbarHeight: MediaQuery.of(context).size.height / 9,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
              ),
            ),
            backgroundColor: AppColors.mainBackgroundColor,
            body: Container(
              padding: EdgeInsets.only(left: 16, top: 40, right: 16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(24, 24, 24, 4),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            fillColor: Colors.grey[200],
                                            filled: true,
                                            hintText: 'Item Image URL',
                                            hintStyle:
                                                const TextStyle(fontSize: 14.0),
                                            prefixIcon: const Icon(Icons.image,
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
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Image URL field cannot be empty!';
                                            } else {
                                              String trimmedValue =
                                                  value.trim();
                                              if (trimmedValue.isEmpty) {
                                                return 'Image URL field cannot be empty!';
                                              }
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            if (value != null) {
                                              imageUrl = value;
                                            }
                                          },
                                          onChanged: (value) {
                                            if (value != null) {
                                              imageUrl = value;
                                            }
                                          },
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            fillColor: Colors.grey[200],
                                            filled: true,
                                            hintText: 'Item Name',
                                            hintStyle:
                                                const TextStyle(fontSize: 14.0),
                                            prefixIcon: const Icon(
                                                Icons.web_outlined,
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
                                          enableSuggestions: false,
                                          autocorrect: false,
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Name field cannot be empty';
                                            } else {
                                              String trimmedValue =
                                                  value.trim();
                                              if (trimmedValue.isEmpty) {
                                                return 'Name field cannot be empty';
                                              }
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            if (value != null) {
                                              productName = value;
                                            }
                                          },
                                          onChanged: (value) {
                                            if (value != null) {
                                              productName = value;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            fillColor: Colors.grey[200],
                                            filled: true,
                                            hintText: 'Item Price',
                                            hintStyle:
                                                const TextStyle(fontSize: 14.0),
                                            prefixIcon: const Icon(
                                                Icons.attach_money,
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
                                          enableSuggestions: false,
                                          autocorrect: false,
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Price field cannot be empty';
                                            } else {
                                              String trimmedValue =
                                                  value.trim();
                                              if (trimmedValue.isEmpty) {
                                                return 'Price field cannot be empty';
                                              }
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            if (value != null) {
                                              productPrice = int.parse(value);
                                            }
                                          },
                                          onChanged: (value) {
                                            if (value != null) {
                                              productPrice = int.parse(value);
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            fillColor: Colors.grey[200],
                                            filled: true,
                                            hintText: 'Item Description',
                                            hintStyle:
                                                const TextStyle(fontSize: 14.0),
                                            prefixIcon: const Icon(
                                                Icons.article,
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
                                              productDescription = value;
                                            }
                                          },
                                          onChanged: (value) {
                                            if (value != null) {
                                              productDescription = value;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Form(
                                    child: FlatButton(
                                      child: Text(
                                        'Confirm Selling',
                                        style: signupPage_ButtonTxts,
                                      ),
                                      color: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Posting The Item!')));
                                          imageList.add(images);
                                          db.addItem(
                                              productName,
                                              'Phones',
                                              productDescription,
                                              productPrice,
                                              imageList,
                                              uid,
                                              username,
                                              productName + ' ' + username);
                                        }
                                        String docSend =
                                            productName + ' ' + username;

                                        DocumentReference ref =
                                            FirebaseFirestore.instance
                                                .collection('products')
                                                .doc(docSend);

                                        Map<String, dynamic> data = {
                                          'prod': ref,
                                        };
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(uid)
                                            .update({
                                          'productReference':
                                              FieldValue.arrayUnion([data])
                                        }).whenComplete(() {
                                          print('Added to Prod Ref');
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
