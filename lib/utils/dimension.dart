import 'package:flutter/material.dart';

class Dimen {
  static const double loginMargin16 = 16.0; // for login page line 39 size 16 padding
  static const double loginMargin12 = 12.0; // for login page line 90, 135: size 12 padding
  static const double loginMargin11 = 11.0; // for login page line 242: size 11 padding
  static const double loginMargin8 = 8.0; // for login page line 219: size 8 padding
  static const double loginMargin15 = 15.0; // for login page line 232: size 15 padding
  static const double searchBar = 16.0;
  static const double emptyIllust = 50.0;

  static get regularPadding16 => EdgeInsets.all(loginMargin16);  // for the paddings with 16
  static get regularPadding11 => EdgeInsets.all(loginMargin11);  // for the paddings with 11
  static get regularPadding8 => EdgeInsets.all(loginMargin8);   //  for the paddings with 8
  static get regularPadding12 => EdgeInsets.all(loginMargin12); //  for the paddings with 12
  static get regularPadding15 => EdgeInsets.all(loginMargin15); //  for the paddings with 15
  static get searchBarPadding => EdgeInsets.fromLTRB(0, 20, searchBar, 0);
  static get emptyIllustPadding => EdgeInsets.all(emptyIllust);
  static get topRowCategories => EdgeInsets.fromLTRB(30, 25, 30, 25);
  static get twoButtonsRowPadding => EdgeInsets.fromLTRB(10, 5, 10, 5);
  static get searchBarPadding2 => const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 2.0);
}