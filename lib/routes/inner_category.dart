import 'package:devstore_project/objects/inner_category_products.dart';
import 'package:devstore_project/objects/productButton.dart';
import 'package:devstore_project/routes/product_view.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class InnerCategory extends StatefulWidget {
  const InnerCategory({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _InnerCategoryState createState() => _InnerCategoryState();
}

class _InnerCategoryState extends State<InnerCategory> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(Icons.arrow_back_ios_rounded,
                color: AppColors.secondaryColor)),
        title: Text(
          widget.title,
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
                SizedBox(height:15),
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
