import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:devstore_project/routes/cart.dart';
import 'package:devstore_project/routes/categories.dart';
import 'package:devstore_project/routes/favorites.dart';
import 'package:devstore_project/routes/orders.dart';
import 'package:devstore_project/routes/feed.dart';

class persNavBar extends StatefulWidget {
  const persNavBar({Key? key}) : super(key: key);

  @override
  _persNavBarState createState() => _persNavBarState();
}

class _persNavBarState extends State<persNavBar> {
  PersistentTabController _controller =PersistentTabController(initialIndex: 0);

//Screens for each nav items.
  List<Widget> _NavScreens() {
    return [
      FeedView(),
      categories(),
      cart(),
      favorites(),
      orders(),
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
