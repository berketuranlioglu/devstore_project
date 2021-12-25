import 'package:devstore_project/utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:devstore_project/utils/dimension.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/routes/profile.dart';
import 'package:devstore_project/objects/category_button.dart';

class notification extends StatefulWidget {
  const notification({Key? key}) : super(key: key);

  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification>
{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Discounts & Offers",
            style: GoogleFonts.openSans(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: AppColors.backgroundColor,
          shadowColor: Colors.transparent,
          toolbarHeight: MediaQuery.of(context).size.height / 9,
          leading: SizedBox(),
          leadingWidth: 15,
          actions: <Widget>[
            FlatButton(
              onPressed: () => {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new Profile())),
              },
              child: Icon(
                Icons.account_circle_rounded,
                color: AppColors.primaryColor,
                size: 40,
              ),
            ),
            SizedBox(width: 10),
          ]),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container (
              color: const Color(0xFFDADADA),
              height: 150.0,
              width: 318.0,
              child: (
                  Text('Discount Banner1', style: fav_camp_recomEmpty)
              ),
            ),

            Padding(
              padding: Dimen.regularPadding16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),

            Container (
              color: const Color(0xFFDADADA),
              height: 150.0,
              width: 318.0,
              child: (
                  Text('Discount Banner2', style: fav_camp_recomEmpty)
              ),
            ),

            Padding(
              padding: Dimen.regularPadding16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),

            Container (
              color: const Color(0xFFDADADA),
              height: 150.0,
              width: 318.0,
              child: (
                  Text('Discount Banner3', style: fav_camp_recomEmpty)
              ),
            ),
          ],
        ),
      ),
    );
  }
}



