// @dart=2.9
import 'package:devstore_project/routes/checkout_success.dart';
import 'package:devstore_project/routes/checkout.dart';
import 'package:devstore_project/routes/feed.dart';
import 'package:devstore_project/routes/pers_nav_bar.dart';
import 'package:devstore_project/routes/categories_view.dart';
import 'package:devstore_project/routes/cart.dart';
import 'package:devstore_project/routes/favorites.dart';
import 'package:devstore_project/routes/bookmark_screen.dart';
import 'package:devstore_project/routes/orders.dart';
import 'package:devstore_project/routes/profile.dart';
import 'package:devstore_project/services/notification.dart';
import 'package:flutter/material.dart';
import 'package:devstore_project/routes/welcome.dart';
import 'package:devstore_project/routes/login.dart';
import 'package:devstore_project/routes/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:devstore_project/routes/onbording.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:devstore_project/routes/edit_profile.dart';
import 'package:provider/provider.dart';

int initScreen = 0;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  //FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Cannot connect to firebase: ' + snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.done) {
            FlutterError.onError =
                FirebaseCrashlytics.instance.recordFlutterError;
            print('Firebase connected');
          }
          return AppBase(); //bunu if icine atmamiz lazim sanirim
        });
  }
}

class AppBase extends StatefulWidget {
  const AppBase({Key key}) : super(key: key);

  @override
  _AppBaseState createState() => _AppBaseState();
}

class _AppBaseState extends State<AppBase> {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorObservers: <NavigatorObserver>[observer],
        initialRoute: initScreen == 0 || initScreen == null ? '/first' : '/',
        routes: {
          '/': (context) => Welcome(analytics: analytics, observer: observer),
          '/feed': (context) => FeedView(analytics: analytics, observer: observer),
          '/persNavBar': (context) => persNavBar(analytics: analytics, observer: observer),
          '/categories': (context) => CategoriesView(analytics: analytics, observer: observer),
          '/cart': (context) => cart(analytics: analytics, observer: observer),
          '/favorites': (context) => favorites(analytics: analytics, observer: observer),
          '/bookmarks': (context) => bookmark(analytics: analytics, observer: observer),
          '/orders': (context) => OrdersView(analytics: analytics, observer: observer),
          '/profile': (context) => Profile(analytics: analytics, observer: observer),
          '/first': (context) =>
              WalkthroughView(analytics: analytics, observer: observer),
          '/login': (context) =>
              LoginPage(analytics: analytics, observer: observer),
          '/signup': (context) =>
              SignUpPage(analytics: analytics, observer: observer),
          '/checkout': (context) => CheckoutView(),
          '/checkout_success': (context) => CheckoutSuccessView(),
          '/editProfile': (context) => editProfile(),
        });
  }
}

