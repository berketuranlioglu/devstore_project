import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devstore_project/routes/categories_view.dart';
import 'package:devstore_project/routes/notification.dart';
import 'package:devstore_project/routes/search.dart';
import 'package:devstore_project/routes/welcome.dart';
import 'package:devstore_project/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:devstore_project/routes/pers_nav_bar.dart';
import 'package:devstore_project/routes/profile.dart';
import 'package:devstore_project/routes/login.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:devstore_project/utils/dimension.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class FeedView extends StatefulWidget {
  const FeedView({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  
  @override
  _FeedViewState createState() => _FeedViewState();
}

void buttonClicked() {
  print('Button Clicked');
}

class _FeedViewState extends State<FeedView> {

  //analytics begin
  Future<void> _currentScreen() async {
    await widget.analytics.setCurrentScreen(
        screenName: 'Feed View', screenClassOverride: 'feedView');
  }

  Future<void> _setLogEvent() async {
    await widget.analytics
        .logEvent(name: 'feed_view', parameters: <String, dynamic>{});
  }

  bool offers_isEmpty = false;
  User? firebaseUser = FirebaseAuth.instance.currentUser;

  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 64.0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 28.0,
                        color: Color(0xFF9441E4),
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'dev', style: feed_devstoreBold),
                        TextSpan(text: 'store', style: feed_devstore),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(width: 65.0),
                  Wrap(
                    spacing: -36.0,
                    children: [
                      FlatButton(
                        onPressed: () => {
                          print(AuthService().user.first.toString()),
                          if(AuthService().user == null){
                            pushNewScreen(context,
                            screen: Welcome(analytics: widget.analytics, observer: widget.observer),
                            withNavBar: false
                            )
                          } else {
                                pushNewScreen(context, screen: Profile(analytics: widget.analytics, observer: widget.observer)
                              ),
                            }
                        },
                        child: const Icon(
                          Icons.account_circle_rounded,
                          color: AppColors.primaryColor,
                          size: 40,
                        ),
                      ),
                      FlatButton(
                        onPressed: () async {
                          pushNewScreen(context,
                              screen: notification(
                                  analytics: widget.analytics,
                                  observer: widget.observer
                              )
                          );
                        },
                        child: const Icon(
                          Icons.notifications_active_rounded,
                          color: AppColors.primaryColor,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: Dimen.searchBarPadding2,
              child: MaterialButton(
                height: 40.0,
                minWidth: 340.0,
                onPressed: () => {
                  pushNewScreen(context, screen: Search()),
                },
                color: AppColors.secondaryColor,
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Color(0xFFDADADA)),
                    const VerticalDivider(width: 6.0),
                    Text('Search', style: feed_searchBar),
                  ],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
              ),
            ),
            const SizedBox(height: 18.0),
            Center(
              child: Column(
                children: [
                  Container(
                    color: const Color(0xFFDADADA),
                    height: 100.0,
                    width: 351.0,
                    child: (offers_isEmpty)
                        ? Align(
                            alignment: Alignment.center,
                            child: Text(
                                'New irresistible campaigns coming soon!',
                                style: fav_camp_recomEmpty),
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: FittedBox(
                              child: Image.asset(
                                'assets/campaign1.jpg',
                                fit: BoxFit.fill,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: Dimen.regularPadding16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RawMaterialButton(
                    constraints: BoxConstraints.tight(const Size(60, 60)),
                    onPressed: buttonClicked,
                    fillColor: AppColors.secondaryColor,
                    child: Image.asset(
                      'assets/CompCategory.png',
                      fit: BoxFit.cover,
                    ),
                    padding: Dimen.regularPadding11,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                  ),
                  RawMaterialButton(
                    constraints: BoxConstraints.tight(const Size(60, 60)),
                    onPressed: buttonClicked,
                    fillColor: AppColors.secondaryColor,
                    child: Image.asset(
                      'assets/PhoneCategory.png',
                      fit: BoxFit.cover,
                    ),
                    padding: Dimen.regularPadding11,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                  ),
                  RawMaterialButton(
                    constraints: BoxConstraints.tight(const Size(60, 60)),
                    onPressed: buttonClicked,
                    fillColor: AppColors.secondaryColor,
                    child: Image.asset(
                      'assets/TVCategory.png',
                      fit: BoxFit.cover,
                    ),
                    padding: Dimen.regularPadding11,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                  ),
                  RawMaterialButton(
                    constraints: BoxConstraints.tight(const Size(60, 60)),
                    onPressed: () =>
                        pushNewScreen(context, screen: CategoriesView(analytics: widget.analytics, observer: widget.observer)),
                    fillColor: AppColors.secondaryColor,
                    child: Image.asset(
                      'assets/More.png',
                      fit: BoxFit.cover,
                    ),
                    padding: Dimen.regularPadding11,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0),
            Padding(
              padding: Dimen.regularPadding8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Recently Visited', style: fav_camp_recomBanner),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  (offers_isEmpty)
                      ? Container(
                          color: const Color(0xFFDADADA),
                          height: 100.0,
                          width: 351.0,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('You haven\'t visited any items!',
                                style: fav_camp_recomEmpty),
                          ))
                      : SizedBox(
                          height: 100.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal, // <-- Like so
                            children: <Widget>[
                              Container(
                                width: 125.0,
                                decoration: const BoxDecoration(
                                  color: AppColors.settingIconsColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                child: Column(
                                  children: [
                                    const Image(
                                      image:
                                          AssetImage("assets/iphone13-1.png"),
                                      height: 75.0,
                                    ),
                                    Text('iPhone 13 Pro', style: productText),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              Container(
                                width: 125.0,
                                decoration: const BoxDecoration(
                                  color: AppColors.settingIconsColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                child: Column(
                                  children: [
                                    const Image(
                                      image:
                                          AssetImage("assets/iphone13-3.png"),
                                      height: 75.0,
                                    ),
                                    Text('iPhone 13 Pro Max',
                                        style: productText),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
            Padding(
              padding: Dimen.regularPadding8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Recommended to You', style: fav_camp_recomBanner),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  (offers_isEmpty)
                      ? Container(
                          color: const Color(0xFFDADADA),
                          height: 100.0,
                          width: 351.0,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('There is nothing to recommend!',
                                style: fav_camp_recomEmpty),
                          ))
                      : SizedBox(
                          height: 100.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal, // <-- Like so
                            children: <Widget>[
                              Container(
                                width: 125.0,
                                decoration: const BoxDecoration(
                                  color: AppColors.settingIconsColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                child: Column(
                                  children: [
                                    const Image(
                                      image:
                                          AssetImage("assets/samsung-tv.png"),
                                      width: 75.0,
                                      height: 75.0,
                                    ),
                                    Text('QLED 4K Samsung TV',
                                        style: productText),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              Container(
                                width: 125.0,
                                decoration: const BoxDecoration(
                                  color: AppColors.settingIconsColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                child: Column(
                                  children: [
                                    const Image(
                                      image:
                                          AssetImage("assets/iphone13-1.png"),
                                      height: 75.0,
                                    ),
                                    Text('iPhone 13 Pro', style: productText),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              Container(
                                width: 125.0,
                                decoration: const BoxDecoration(
                                  color: AppColors.settingIconsColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                child: Column(
                                  children: [
                                    const Image(
                                      image: AssetImage("assets/nofrost.png"),
                                      height: 75.0,
                                    ),
                                    Text('Samsung Family Hub',
                                        style: productText),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              Container(
                                width: 125.0,
                                decoration: const BoxDecoration(
                                  color: AppColors.settingIconsColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                child: Column(
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          "assets/category_smart_watch.png"),
                                      width: 65.0,
                                      height: 75.0,
                                    ),
                                    Text('Apple Watch Series 2',
                                        style: productText),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
