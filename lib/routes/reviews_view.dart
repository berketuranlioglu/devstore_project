import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devstore_project/objects/users.dart';
import 'package:devstore_project/services/db.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/dimension.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

DBService db = DBService();

final FirebaseAuth auth = FirebaseAuth.instance;

final User user = auth.currentUser!;
final uid = user.uid;

class ReviewsView extends StatefulWidget {
  const ReviewsView({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _ReviewsViewState createState() => _ReviewsViewState();
}

class _ReviewsViewState extends State<ReviewsView> {

  //analytics begin
  Future<void> _currentScreen() async {
    await widget.analytics.setCurrentScreen(
        screenName: 'Reviews View', screenClassOverride: 'reviewsView');
  }

  Future<void> _setLogEvent() async {
    await widget.analytics
        .logEvent(name: 'reviews_view', parameters: <String, dynamic>{});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.userCollection.doc(uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Users usersClass =
          Users.fromJson(snapshot.data!.data() as Map<String, dynamic>);

          return Scaffold(
            body: Padding(
              padding: Dimen.regularPadding12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for(int i=0; i < usersClass.comments.length; i++)
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            border: Border.all(
                              width: 1.0,
                              color: AppColors.secondaryColor,
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(15.0)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    usersClass.username,
                                    style: productPageSellerText2,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    usersClass.comments[i]['comment'],
                                    style: productPageRating,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    usersClass.comments[i]['rating'].toString(),
                                    style: productPageRating,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height:10),
                      ],
                    ),
                ],
              ),
            ),
          );
        }
        return Scaffold();
      },
    );
  }
}

