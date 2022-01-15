import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devstore_project/services/db.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'login.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _WelcomeState createState() => _WelcomeState();
}

DBService db = DBService();

class _WelcomeState extends State<Welcome> {
  //analytics begin
  Future<void> _currentScreen() async {
    await widget.analytics.setCurrentScreen(
        screenName: 'Welcome View', screenClassOverride: 'welcomeView');
  }

  Future<void> _setLogEvent() async {
    await widget.analytics
        .logEvent(name: 'welcome_view', parameters: <String, dynamic>{});
  }

  //end
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/vec_backg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100.0),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 60.0,
                    color: AppColors.secondaryColor,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'dev',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'store'),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 250.0),
              Container(
                height: 60.0,
                width: 250.0,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage(
                                analytics: widget.analytics,
                                observer: widget.observer)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Log In',
                      style: welcomePage_LogIn,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.thirdColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(
                      color: AppColors.thirdColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0), // IKI TUS ARASI BOSLUK
              Container(
                height: 60.0,
                width: 250.0,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Sign Up',
                      style: welcomePage_SignUp,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  db.addGuestUser('Anon2');
                  Navigator.popAndPushNamed(context, "/persNavBar");
                },
                child: Text(
                  'Continue as a guest.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.secondaryColor, // DEGISECEK
    );
  }
}
