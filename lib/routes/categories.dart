import 'package:devstore_project/utils/styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:devstore_project/utils/dimension.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/routes/profile.dart';
import 'package:devstore_project/objects/category_button.dart';

class categories extends StatefulWidget {
  const categories({Key? key}) : super(key: key);

  @override
  _categoriesState createState() => _categoriesState();
}

class _categoriesState extends State<categories> {
  Widget twoButtonsRow(
      String image1, String title1, String image2, String title2) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: Dimen.twoButtonsRowPadding,
            child: categoryButton().button(context, image1, title1),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: Dimen.twoButtonsRowPadding,
            child: categoryButton().button(context, image2, title2),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Categories",
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
            Padding(
              padding: Dimen.twoButtonsRowPadding,
              child: twoButtonsRow(
                  "assets/category_computers.png",
                  "Computers & Tablets",
                  "assets/category_phones.png",
                  "Phones"),
            ),
            Padding(
              padding: Dimen.twoButtonsRowPadding,
              child: twoButtonsRow(
                  "assets/category_accessories.png",
                  "Electronic Accessories",
                  "assets/category_tv.png",
                  "TVs & Sound"),
            ),
            Padding(
              padding: Dimen.twoButtonsRowPadding,
              child: twoButtonsRow("assets/category_gaming.png", "Gaming",
                  "assets/category_smart_watch.png", "Wearables"),
            ),
            Padding(
              padding: Dimen.twoButtonsRowPadding,
              child: twoButtonsRow(
                  "assets/category_kitchen_appliances.png",
                  "Kitchen Appliances",
                  "assets/category_personal_care.png",
                  "Personal Care"),
            ),
            Padding(
              padding: Dimen.twoButtonsRowPadding,
              child: twoButtonsRow(
                  "assets/category_home_appliances.png",
                  "Home Appliances",
                  "assets/category_camera.png",
                  "Photography & Camera"),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
    );
  }
}
