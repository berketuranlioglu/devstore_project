import 'package:devstore_project/objects/productButton.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class phones extends StatefulWidget {
  const phones({Key? key}) : super(key: key);

  @override
  _phonesState createState() => _phonesState();
}

class _phonesState extends State<phones> {

  Widget twoButtonsRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: Dimen.regularPadding16,
            child: productButton().button(context),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: Dimen.regularPadding16,
            child: productButton().button(context),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(Icons.arrow_back_ios_rounded,
                color: AppColors.secondaryColor)
        ),
        title: Text(
          "Phones",
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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 20, 30),
                child: productButton().button(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}