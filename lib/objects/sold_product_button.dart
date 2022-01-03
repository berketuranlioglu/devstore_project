import 'package:devstore_project/routes/product_view.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SoldProductButton extends StatefulWidget {
  const SoldProductButton({Key? key}) : super(key: key);

  @override
  _SoldProductButtonState createState() => _SoldProductButtonState();
}

class _SoldProductButtonState extends State<SoldProductButton> {
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
                    "assets/category_phones.png",
                    fit: BoxFit.fitHeight,
                  )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "RATING",
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
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
                SizedBox(height:8),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(
                              Radius.circular(5.0)
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "10%",
                          style: GoogleFonts.openSans(
                            color: AppColors.secondaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "\$1099.00",
                              style: GoogleFonts.openSans(
                                color: AppColors.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              "\$999.00",
                              style: GoogleFonts.openSans(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
