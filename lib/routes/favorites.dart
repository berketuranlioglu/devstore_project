import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:devstore_project/objects/favs.dart';
import 'package:devstore_project/objects/product.dart';


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


class favorites extends StatefulWidget {
  const favorites({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _favoritesState createState() => _favoritesState();
}

class _favoritesState extends State<favorites> {

  //analytics begin
  Future<void> _currentScreen() async {
    await widget.analytics.setCurrentScreen(
        screenName: 'Favorites', screenClassOverride: 'favorites');
  }

  Future<void> _setLogEvent() async {
    await widget.analytics
        .logEvent(name: 'favorites', parameters: <String, dynamic>{});
  }
 static String routeName = "/favorites";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Text(
              "My Favorites",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
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
                color: Color(0x259441E4),
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

  final Favs cart;

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




