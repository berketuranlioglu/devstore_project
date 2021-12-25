import 'package:devstore_project/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:devstore_project/utils/dimension.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/routes/profile.dart';

class categories extends StatefulWidget {
  const categories({Key? key}) : super(key: key);

  @override
  _categoriesState createState() => _categoriesState();
}

class _categoriesState extends State<categories> {

  Widget topRow() {
    return Row(
      children: [
        Expanded(
            flex: 5,
            child: Text(
              "Categories",
              style: categoriesTitle,
            )
        ),
        Expanded(
            flex: 1,
            child: OutlinedButton(
              onPressed: () => {
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new Profile())
                ),
              },
              child: Icon(
                Icons.account_circle_rounded,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                primary: AppColors.primaryColor,
              ),
            )
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: Dimen.topRowCategories,
                child: topRow(),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
