import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devstore_project/objects/products.dart';
import 'package:devstore_project/objects/users.dart';
import 'package:devstore_project/routes/account_info.dart';
import 'package:devstore_project/routes/product_view.dart';
import 'package:devstore_project/routes/profile.dart';
import 'package:devstore_project/services/db.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage(
      {Key? key,
      required this.id,
      required this.analytics,
      required this.observer})
      : super(key: key);

  final String id;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

DBService db = DBService();

int price = 0;
String nameDescription = "";
String imageURL = "";

final _formKey = GlobalKey<FormState>();

class _EditProductPageState extends State<EditProductPage> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.productsCollection.doc(widget.id).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Products productClass =
              Products.fromJson(snapshot.data!.data() as Map<String, dynamic>);
          return Scaffold(
            body: Container(
              padding: EdgeInsets.only(left: 16, top: 40, right: 16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    const Text(
                      "Edit Profile",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(productClass.imageURL[0]),
                    ),
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
                                            hintText: 'Image URL',
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
                                          onSaved: (value) {
                                            if (value != null) {
                                              imageURL = value;
                                            }
                                          },
                                          onChanged: (value) {
                                            if (value != null) {
                                              imageURL = value;
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
                                            hintText: 'Name & Description',
                                            hintStyle:
                                                const TextStyle(fontSize: 14.0),
                                            prefixIcon: const Icon(
                                                Icons.description_outlined,
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
                                          keyboardType: TextInputType.name,
                                          onSaved: (value) {
                                            if (value != null) {
                                              nameDescription = value;
                                            }
                                          },
                                          onChanged: (value) {
                                            if (value != null) {
                                              nameDescription = value;
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
                                            hintText: 'Price',
                                            hintStyle:
                                                const TextStyle(fontSize: 14.0),
                                            prefixIcon: const Icon(
                                                Icons.money_rounded,
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
                                          keyboardType: TextInputType.name,
                                          onSaved: (value) {
                                            if (value != null) {
                                              price = int.parse(value);
                                            }
                                          },
                                          onChanged: (value) {
                                            if (value != null) {
                                              price = int.parse(value);
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Form(
                                    child: FlatButton(
                                      child: Text(
                                        'Edit Product ',
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
                                                      'Editing the Product!')));
                                          db.editProductDetails(widget.id,
                                              nameDescription, imageURL, price);
                                        }
                                      },
                                    ),
                                  ),
                                  FlatButton(
                                    child: Text(
                                      'Delete Product',
                                      style: signupPage_ButtonTxts,
                                    ),
                                    color: AppColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: () {
                                      db.deleteProduct(widget.id);
                                    },
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
