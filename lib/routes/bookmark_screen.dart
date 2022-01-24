import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devstore_project/objects/products.dart';
import 'package:devstore_project/objects/users.dart';
import 'package:devstore_project/services/db.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:devstore_project/objects/product.dart';
import 'package:google_fonts/google_fonts.dart';


//------------------------------------------------
//JUST DETERMINES THE SIZE OF THE SCREEN FOR CARDS
class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth = 0;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  return (inputWidth / 375.0) * screenWidth;
}
//------------------------------------------------

DBService db = DBService();

final FirebaseAuth auth = FirebaseAuth.instance;

final User user = auth.currentUser!;
final uid = user.uid;

class bookmark extends StatefulWidget {
  const bookmark({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _bookmarkState createState() => _bookmarkState();
}

class _bookmarkState extends State<bookmark> {

  //analytics begin
  Future<void> _currentScreen() async {
    await widget.analytics.setCurrentScreen(
        screenName: 'Bookmarks', screenClassOverride: 'bookmarks');
  }

  Future<void> _setLogEvent() async {
    await widget.analytics
        .logEvent(name: 'bookmarks', parameters: <String, dynamic>{});
  }
 static String routeName = "/bookmarks";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bookmarks",
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
      ),
      body: FutureBuilder(
        future: db.userCollection.doc(uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Users userClass =
            Users.fromJson(snapshot.data!.data() as Map<String, dynamic>);
            List<String> id = [];
            for (int i = 0; i < userClass.bookmarks.length; i++) {
              id.add(userClass.bookmarks[i]["bookmarkRef"].id);
            }
            return Padding(
              padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
              child: ListView.builder(
                itemCount: userClass.bookmarks.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Dismissible(
                    key: Key(index.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        //TODO: FAVORTIES'TEN SIL
                        DocumentReference ref = FirebaseFirestore.instance
                            .collection('products')
                            .doc(id[index]);
                        Map<String, dynamic> data = {
                          'bookmarkRef':
                          ref, // Updating Document Reference
                        };
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(uid)
                            .update({
                          'bookmarks': FieldValue.arrayRemove([data])
                        }).whenComplete(() {
                          print('Removed from Bookmarks');
                        });
                      });
                    },
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0x25E48241),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          MaterialButton(
                            onPressed: () {},
                            textColor:Color(0xFF9441E4),
                            child: Icon(
                              Icons.delete_rounded,
                              size: 25,
                            ),

                          ),
                        ],
                      ),
                    ),
                    child: favCard(reference: userClass.bookmarks[index]['bookmarkRef']),
                  ),
                ),
              ),
            );
          }
          return Scaffold();
        },
      ),
    );
  }
}

//EACH FAVORITE PRODUCT CARD
class favCard extends StatefulWidget {
  const favCard({Key? key, required this.reference}) : super(key: key);

  final dynamic reference;

  @override
  _favCardState createState() => _favCardState();
}

class _favCardState extends State<favCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.productsCollection.doc(widget.reference.id.toString()).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Products productsClass =
          Products.fromJson(snapshot.data!.data() as Map<String, dynamic>);
          return Row(
            children: [
              SizedBox(
                width: 88,
                child: AspectRatio(
                  aspectRatio: 0.88,
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.network(productsClass.imageURL[0]),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productsClass.productName,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    maxLines: 2,
                  ),
                  SizedBox(height: 10),
                  Text.rich(
                    TextSpan(
                      text: "\$${productsClass.salePrice}.00",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Color(0xFF9441E4)),
                    ),
                  )
                ],
              ),
              Spacer(),
              Column(
                  children:[
                    MaterialButton(
                      onPressed: () {
                        //TODO: ADD TO CART
                      },
                      color: Color(0xFF9441E4),
                      textColor: Colors.white,
                      child: Icon(
                        Icons.add_shopping_cart_outlined,
                        size: 20,
                      ),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    ),
                  ]
              ),
              SizedBox(width: 5),
            ],

          );

        }
        return Scaffold();
      },
    );
  }
}

/*
Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(cart.product.images[0]),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.product.title,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                text: "\$${cart.product.price}",
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Color(0xFF9441E4)),
              ),
            )
          ],
        ),
        Spacer(),
        Column(
            children:[
              MaterialButton(
                onPressed: () {},
                color: Color(0xFF9441E4),
                textColor: Colors.white,
                child: Icon(
                  Icons.add_shopping_cart_outlined,
                  size: 20,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              ),
            ]
        ),
        SizedBox(width: 5),
      ],

    );
 */




