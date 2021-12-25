import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:devstore_project/routes/phones.dart';

class categoryButton {
  Widget button(BuildContext cntxt, String image, String title) {
    return ElevatedButton(
      onPressed: () => {
        Navigator.push(cntxt, new MaterialPageRoute(
            builder: (cntxt) => new phones())
        ),
      },
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      image
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              title,
              style: GoogleFonts.openSans(
                color: AppColors.primaryColor,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ]
      ),
      style: ElevatedButton.styleFrom(
        primary: AppColors.categoryButtonColor,
        fixedSize: Size(20, 100),
      ),
    );
  }
}
