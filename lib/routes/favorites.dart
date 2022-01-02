import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "FAVORITES SCREEN",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}