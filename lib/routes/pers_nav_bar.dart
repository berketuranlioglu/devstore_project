import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:devstore_project/routes/cart.dart';
import 'package:devstore_project/routes/categories_view.dart';
import 'package:devstore_project/routes/favorites.dart';
import 'package:devstore_project/routes/orders.dart';
import 'package:devstore_project/routes/feed.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class persNavBar extends StatefulWidget {
  const persNavBar({Key? key, required this.analytics, required this.observer})
      : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _persNavBarState createState() => _persNavBarState();
}

class _persNavBarState extends State<persNavBar> {
  PersistentTabController _controller =PersistentTabController(initialIndex: 0);

  //analytics begin
  Future<void> _currentScreen() async {
    await widget.analytics.setCurrentScreen(
        screenName: 'Navigation Bar', screenClassOverride: 'navBar');
  }

  Future<void> _setLogEvent() async {
    await widget.analytics
        .logEvent(name: 'nav_bar', parameters: <String, dynamic>{});
  }

//Screens for each nav items.
  List<Widget> _NavScreens() {
    return [
      FeedView(analytics: widget.analytics, observer: widget.observer),
      CategoriesView(analytics: widget.analytics, observer: widget.observer),
      cart(analytics: widget.analytics, observer: widget.observer),
      favorites(analytics: widget.analytics, observer: widget.observer),
      orders(analytics: widget.analytics, observer: widget.observer),
    ];
  }


  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home_outlined),
        title: ("Home"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.settingsTabBarIconsColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.category_outlined),
        title: ("Categories"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.settingsTabBarIconsColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.shopping_cart_outlined),
        title: ("Cart"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.settingsTabBarIconsColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.favorite_border_rounded),
        title: ("Favorites"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.settingsTabBarIconsColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.inbox_outlined),
        title: ("Orders"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: AppColors.settingsTabBarIconsColor,
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _NavScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: Colors.white,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          hideNavigationBarWhenKeyboardShows: true,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          popAllScreensOnTapOfSelectedTab: true,
          navBarStyle: NavBarStyle.style3,
        )
    );
  }
}
