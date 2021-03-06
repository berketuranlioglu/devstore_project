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
import 'package:devstore_project/routes/seller_create.dart';

FirebaseAuth auth = FirebaseAuth.instance;

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

class SellerProfile extends StatefulWidget {
  const SellerProfile(
      {Key? key,
      required this.reference,
      required this.analytics,
      required this.observer})
      : super(key: key);

  final dynamic reference;
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _SellerProfileState createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {
  //analytics begin
  Future<void> _currentScreen() async {
    await widget.analytics.setCurrentScreen(
        screenName: 'Seller Profile', screenClassOverride: 'sellerProfile');
  }

  Future<void> _setLogEvent() async {
    await widget.analytics
        .logEvent(name: 'sellerProfile', parameters: <String, dynamic>{});
  }

  final isSelectedOne = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    String id = widget.reference.id.toString();
    return FutureBuilder(
      future: db.userCollection.doc(id).get(),
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
                    SizedBox(width: 12),
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
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
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
                SizedBox(width: 10),
                if (uid == id)
                  IconButton(
                    onPressed: () {
                      pushNewScreen(context,
                          screen: EditProfilePage(
                              analytics: widget.analytics,
                              observer: widget.observer));
                    },
                    icon: Icon(Icons.edit_outlined),
                  ),
                if (uid == id)
                  IconButton(
                    onPressed: () {
                      pushNewScreen(context,
                          screen: SellerItemCreate(
                              analytics: widget.analytics,
                              observer: widget.observer));
                    },
                    icon: const Icon(Icons.add_outlined),
                  ),
                const SizedBox(width: 10),
              ],
              backgroundColor: AppColors.sellerAppBarColor,
              shadowColor: Colors.transparent,
              toolbarHeight: MediaQuery.of(context).size.height / 9,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: ToggleButtons(
                            textStyle: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            color: Colors.black45, //unselected text
                            selectedColor: Colors.black, //selected text
                            fillColor: const Color(0xFFECECEC), //selected cell
                            splashColor: Colors.grey, // when pressing
                            highlightColor: const Color(0xFFECECEC),
                            renderBorder: false,
                            borderRadius: BorderRadius.circular(50.0),
                            isSelected: isSelectedOne,
                            onPressed: (int index) {
                              setState(() {
                                for (int buttonIndex = 0;
                                    buttonIndex < isSelectedOne.length;
                                    buttonIndex++) {
                                  if (buttonIndex == index) {
                                    isSelectedOne[buttonIndex] = true;
                                  } else {
                                    isSelectedOne[buttonIndex] = false;
                                  }
                                }
                              });
                            },
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.0),
                                child: Text('Selling'),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.0),
                                child: Text('Sold'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  if (isSelectedOne[0] == true)
                    SellingProducts(
                        isSelling: true,
                        id: id,
                        analytics: widget.analytics,
                        observer: widget.observer),
                  if (isSelectedOne[1] == true)
                    SellingProducts(
                        isSelling: false,
                        id: id,
                        analytics: widget.analytics,
                        observer: widget.observer),
                  const SizedBox(height: 30),
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
/*
Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(Icons.arrow_back_ios_rounded,
                color: AppColors.secondaryColor)),
        title: Row(
          children: [
            Text(
              _appBarTitle,
              style: GoogleFonts.openSans(
                color: AppColors.secondaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width:12),
            Container(
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
                  "  4.5  ",
                  style: GoogleFonts.openSans(
                    color: AppColors.secondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                pushNewScreen(
                    context,
                    screen: EditProfilePage());
              },
              icon: Icon(Icons.edit_outlined)
          ),
          IconButton(
              onPressed: () {
                //TODO: CREATE SAYFASI GELECEK (EMIR)
              },
              icon: Icon(Icons.add_outlined),
          ),
          SizedBox(width: 10),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height:15),
            Center(
              child: ToggleButtons(
                textStyle: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                color: Colors.black45, //unselected text
                selectedColor: Colors.black, //selected text
                fillColor: const Color(0xFFECECEC), //selected cell
                splashColor: Colors.grey, // when pressing
                highlightColor: const Color(0xFFECECEC),
                borderRadius: BorderRadius.circular(50.0),
                isSelected: isSelected,
                onPressed: (int index) {
                  setState(() {
                    for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                      if (buttonIndex == index) {
                        isSelected[buttonIndex] = true;
                      } else {
                        isSelected[buttonIndex] = false;
                      }
                    }
                  });
                },
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text('Selling'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text('Sold'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Icon(Icons.sort_rounded),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Icon(Icons.filter_list_outlined),
                  ),
                ],
              ),
            ),
            SizedBox(height:15),
            if(isSelected[0] == true)
              SellingProducts(isSelling: true),
            if(isSelected[1] == true)
              SellingProducts(isSelling: false),
            SizedBox(height:30),
          ],
        ),
      ),
        backgroundColor: AppColors.mainBackgroundColor,
    );
 */

