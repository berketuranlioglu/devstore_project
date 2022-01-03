import 'package:devstore_project/routes/product_view.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SellerProducts extends StatefulWidget {
  const SellerProducts({Key? key}) : super(key: key);

  @override
  _SellerProductsState createState() => _SellerProductsState();
}

class _SellerProductsState extends State<SellerProducts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => {
            pushNewScreen(
              context,
              screen: productView(),
            ),
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: (Image.asset(
                    "/assets/category_phones.png",
                    height: 60.0,
                    width: 0.0,
                  )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "PRODUCT NAME",
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
          style: ElevatedButton.styleFrom(
            primary: AppColors.secondaryColor,
            fixedSize: Size(150, 200),
          ),
        ),
        SizedBox(height: 5),
        OutlinedButton(
          onPressed: () {
            //TODO: EDIT VE DELETE YAPILACAK (EMIR)
          },
          child: Text("Edit",
              style: GoogleFonts.openSans(
                color: AppColors.primaryColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              )),
          style: OutlinedButton.styleFrom(
              fixedSize: Size(150, 20),
              side: BorderSide(
                color: AppColors.primaryColor,
                width: 2,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              )),
        ),
      ],
    );
  }
}
