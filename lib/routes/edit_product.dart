import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devstore_project/objects/products.dart';
import 'package:devstore_project/routes/account_info.dart';
import 'package:devstore_project/routes/welcome.dart';
import 'package:devstore_project/services/db.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage(
      {Key? key,
      required this.id,
      required this.analytics,
      required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  final String id;

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

final FirebaseAuth auth = FirebaseAuth.instance;

final User user = auth.currentUser!;
final uid = user.uid;

String imageURL = "";
String name = "";
int price = 0;

DBService db = DBService();

final _formKey = GlobalKey<FormState>();

Future<String> userNameFinal = getUserName(uid);
final firestoreInstance = FirebaseFirestore.instance;

class _EditProductPageState extends State<EditProductPage> {
  bool showPassword = false;
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
            body: Container(
              padding: EdgeInsets.only(left: 16, top: 40, right: 16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    const Text(
                      "Edit Product",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        child: Image.network(productsClass.imageURL[0]),
                      ),
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
                                                Icons.description,
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
                                          autocorrect: false,
                                          onSaved: (value) {
                                            if (value != null) {
                                              name = value;
                                            }
                                          },
                                          onChanged: (value) {
                                            if (value != null) {
                                              name = value;
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
                                            prefixIcon: const Icon(Icons.money,
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
                                          keyboardType: TextInputType.number,
                                          obscureText: true,
                                          enableSuggestions: false,
                                          autocorrect: false,
                                          onSaved: (value) {},
                                          onChanged: (value) {},
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
                                            hintText: 'Image URL - 1',
                                            hintStyle:
                                                const TextStyle(fontSize: 14.0),
                                            prefixIcon: const Icon(
                                                Icons.image_outlined,
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
                                          keyboardType: TextInputType.number,
                                          obscureText: true,
                                          enableSuggestions: false,
                                          autocorrect: false,
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
                                        'Edit Product',
                                        style: signupPage_ButtonTxts,
                                      ),
                                      color: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      onPressed: () {
                                        db.editProductDetails(
                                            widget.id, name, imageURL, 259);
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
