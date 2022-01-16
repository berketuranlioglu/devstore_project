import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devstore_project/objects/products.dart';
import 'package:devstore_project/routes/edit_product.dart';
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

class SellingProductButton extends StatefulWidget {
  const SellingProductButton(
      {Key? key,
      required this.reference,
      required this.analytics,
      required this.observer})
      : super(key: key);
  final dynamic reference;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _SellingProductButtonState createState() => _SellingProductButtonState();
}

String username = "";

class _SellingProductButtonState extends State<SellingProductButton> {
  @override
  Widget build(BuildContext context) {
    String id = widget.reference.id.toString();
    return FutureBuilder(
      future: db.productsCollection.doc(id).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Products productsClass =
              Products.fromJson(snapshot.data!.data() as Map<String, dynamic>);
          getUserName(uid).then((value) {
            username = value;
          });
          if (productsClass.stockCount > 0) {
            return Column(
              children: [
                ElevatedButton(
                  onPressed: () => {
                    pushNewScreen(
                      context,
                      screen: productView(
                          id: id,
                          username: username,
                          analytics: widget.analytics,
                          observer: widget.observer),
                      withNavBar: false,
                    ),
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: (Image.network(
                            productsClass.imageURL[0],
                            width: 70,
                            height: 70,
                          )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: AppColors.starColor,
                                  size: 16.0,
                                ),
                                Text(
                                  productsClass.rating.toString(),
                                  style: GoogleFonts.openSans(
                                    color: Colors.black54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "(${productsClass.ratingCount.toString()})",
                                  style: GoogleFonts.openSans(
                                    color: Colors.black54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            productsClass.productName,
                            style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 8),
                        productsClass.previousPrice != productsClass.salePrice
                            ? Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${((productsClass.previousPrice - productsClass.salePrice) / productsClass.previousPrice * 100).toInt()}%",
                                        style: GoogleFonts.openSans(
                                          color: AppColors.secondaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "\$${productsClass.previousPrice}.00",
                                            style: GoogleFonts.openSans(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationThickness: 2,
                                              decorationColor:
                                                  AppColors.primaryColor,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "\$${productsClass.salePrice}.00",
                                            style: GoogleFonts.openSans(
                                              color: AppColors.primaryColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "\$${productsClass.salePrice}.00",
                                        style: GoogleFonts.openSans(
                                          color: AppColors.primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ]),
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.secondaryColor,
                    fixedSize: Size(150, 200),
                  ),
                ),
                SizedBox(height: 5),
                OutlinedButton(
                  onPressed: () {
                    pushNewScreen(context,
                        screen: EditProductPage(
                            analytics: widget.analytics,
                            observer: widget.observer,
                            id: id));
                  },
                  child: Text("Edit",
                      style: GoogleFonts.openSans(
                        color: AppColors.primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      )),
                  style: OutlinedButton.styleFrom(
                      fixedSize: Size(150, 20),
                      side: BorderSide(
                        color: AppColors.primaryColor,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                ),
              ],
            );
          } else {
            return Center(
              child: Container(
                child: Center(
                  child: Text(
                    "Looks like everything is sold!",
                    style: GoogleFonts.openSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                width: MediaQuery.of(context).size.width - 64,
                height: 300,
              ),
            );
          }
        }
        return Scaffold();
      },
    );
  }
}
/*
Column(
      children: [
        ElevatedButton(
          onPressed: () => {
            /*
            pushNewScreen(
              context,
              screen: productView(id: id, analytics: widget.analytics, observer: widget.observer),
            ),
             */
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: (Image.asset(
                    "assets/category_phones.png",
                    fit: BoxFit.fitHeight,
                  )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: AppColors.starColor,
                        size: 16.0,
                      ),
                      Text(
                        "4.2",
                        style: GoogleFonts.openSans(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "PRODUCT NAME",
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height:8),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(
                              Radius.circular(5.0)
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "10%",
                          style: GoogleFonts.openSans(
                            color: AppColors.secondaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "\$1099.00",
                              style: GoogleFonts.openSans(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 2,
                                decorationColor: AppColors.primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "\$999.00",
                              style: GoogleFonts.openSans(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
          style: ElevatedButton.styleFrom(
            primary: AppColors.secondaryColor,
            fixedSize: Size(150, 200),
          ),
        ),
        SizedBox(height: 5),
        OutlinedButton(
          onPressed: () {
            //TODO: EDIT VE DELETE YAPILACAK (EMIR)
          },
          child: Text("Edit",
              style: GoogleFonts.openSans(
                color: AppColors.primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              )),
          style: OutlinedButton.styleFrom(
              fixedSize: Size(150, 20),
              side: BorderSide(
                color: AppColors.primaryColor,
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
        ),
      ],
    );
 */
