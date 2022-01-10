import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devstore_project/objects/product_button.dart';
import 'package:devstore_project/objects/selling_products.dart';
import 'package:devstore_project/objects/users.dart';
import 'package:devstore_project/routes/edit_profile.dart';
import 'package:devstore_project/services/db.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/dimension.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:stacked/stacked_annotations.dart';

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

class SellerItemCreate extends StatefulWidget {
  const SellerItemCreate({Key? key, required this.analytics, required this.observer})
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
        screenName: 'Seller Profile Edit',
        screenClassOverride: 'sellerProfileEdit');
  }

  Future<void> _setLogEvent() async {
    await widget.analytics
        .logEvent(name: 'sellerProfileEdit', parameters: <String, dynamic>{});
  }

  dynamic sellingPage = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.userCollection.doc(user.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Users userClass =
          Users.fromJson(snapshot.data!.data() as Map<String, dynamic>);
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () => {Navigator.pop(context)},
                  icon: Icon(Icons.arrow_back_ios_rounded,
                      color: AppColors.secondaryColor)),
              title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      "${userClass.nameSurname}",
                      style: GoogleFonts.openSans(
                        color: AppColors.secondaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width:12),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                  child: Container(
                    width: 50,
                    decoration: BoxDecoration(
                      color: AppColors.ratingBlockColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0,3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "${userClass.rating}",
                        style: GoogleFonts.openSans(
                          color: AppColors.secondaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width:10),
                IconButton(
                    onPressed: () {
                      pushNewScreen(
                          context,
                          screen: EditProfilePage());
                    },
                    icon: Icon(Icons.edit_outlined)
                ),
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
          );
        }
        return Scaffold();
      },
    );
  }
}