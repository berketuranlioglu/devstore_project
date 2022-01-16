import 'package:devstore_project/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:devstore_project/objects/bookmark.dart';
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
      body: Body(),
    );
  }
}

//AFTER APPBAR, BODY HAS EACH PRODUCT ROWS
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: demoCarts.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(demoCarts[index].product.id.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                demoCarts.removeAt(index);
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
            child: favCard(cart: demoCarts[index]),
          ),
        ),
      ),
    );
  }
}

//EACH FAVORITE PRODUCT CARD
class favCard extends StatelessWidget {
  const favCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Bookmark cart;

  @override
  Widget build(BuildContext context) {
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
  }
}




