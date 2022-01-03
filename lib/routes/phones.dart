import 'package:devstore_project/objects/inner_category_products.dart';
import 'package:devstore_project/objects/productButton.dart';
import 'package:devstore_project/routes/product_view.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class phones extends StatefulWidget {
  const phones({Key? key}) : super(key: key);

  @override
  _phonesState createState() => _phonesState();
}

class _phonesState extends State<phones> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(Icons.arrow_back_ios_rounded,
                color: AppColors.secondaryColor)),
        title: Text(
          "Inner Category Page",
          style: GoogleFonts.openSans(
            color: AppColors.secondaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        shadowColor: Colors.transparent,
        toolbarHeight: MediaQuery.of(context).size.height / 9,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
              children: [
                InnerCategoryProducts(),
                SizedBox(height:20),
              ],
            ),
        ),
      ),
      backgroundColor: AppColors.mainBackgroundColor,
    );
  }
}
