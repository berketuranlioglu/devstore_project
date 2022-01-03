import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:devstore_project/routes/inner_category.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class categoryButton {
  Widget button(BuildContext context, String image, String title) {
    return ElevatedButton(
      onPressed: () => {
        pushNewScreen(
            context,
            screen: InnerCategory(title: title),
        ),
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: (Image.asset(
                image,
                height: 60.0,
                width: 60.0,
              )),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                title,
                style: GoogleFonts.openSans(
                  color: AppColors.primaryColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
      style: ElevatedButton.styleFrom(
        primary: AppColors.categoryButtonColor,
        fixedSize: Size(20, 100),
      ),
    );
  }
}
