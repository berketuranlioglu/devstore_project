import 'package:devstore_project/routes/categories.dart';
import 'package:devstore_project/routes/notification.dart';
import 'package:devstore_project/routes/search.dart';
import 'package:flutter/material.dart';
import 'package:devstore_project/routes/persNavBar.dart';
import 'package:devstore_project/routes/profile.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:devstore_project/utils/dimension.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class FeedView extends StatefulWidget {
  const FeedView({Key? key}) : super(key: key);

  @override
  _FeedViewState createState() => _FeedViewState();
}

void buttonClicked() {
  print('Button Clicked');
}

class _FeedViewState extends State<FeedView> {
  bool offers_isEmpty = true;

  @override
  Widget build(BuildContext context) {
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FlatButton(
                        onPressed: () => {
                          pushNewScreen(context, screen: Profile()),
                        },
                        child: const Icon(
                          Icons.account_circle_rounded,
                          color: AppColors.primaryColor,
                          size: 40,
                        ),
                      ),
                      FlatButton(
                        onPressed: () => {
                          pushNewScreen(context, screen: notification()),
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
                            child: Text('Campaign 1!',
                                style: fav_camp_recomEmpty)),
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
                        pushNewScreen(context, screen: categories()),
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
                  Container(
                    color: const Color(0xFFDADADA),
                    height: 100.0,
                    width: 351.0,
                    child: (offers_isEmpty)
                        ? Align(
                            alignment: Alignment.center,
                            child: Text('You haven\'t visited any items!',
                                style: fav_camp_recomEmpty),
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: Text('Favorite Item 1!',
                                style: fav_camp_recomEmpty)),
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
                  Container(
                    color: const Color(0xFFDADADA),
                    height: 100.0,
                    width: 351.0,
                    child: (offers_isEmpty)
                        ? Align(
                            alignment: Alignment.center,
                            child: Text('There is nothing to recommend!',
                                style: fav_camp_recomEmpty),
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: Text('Recommended Item 1!',
                                style: fav_camp_recomEmpty)),
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
