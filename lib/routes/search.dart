import 'package:flutter/material.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/dimension.dart';


class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: Dimen.searchBarPadding,
                        child: searchBar(context),
                      ),
                      Padding(
                        padding: Dimen.emptyIllustPadding,
                        child: emptyHistory(),
                      ),
                    ]
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget searchBar(context) {
  return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
              onPressed: () => {
                Navigator.of(context).pop()
                /*
              if (!FocusScope.of(context).isFirstFocus ||
                  FocusScope.of(context).hasPrimaryFocus) {
                Navigator.of(context).pop(),
              }
              else {
                FocusScope.of(context).unfocus(),
              }
               */
              },
              icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black)
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            child: TextField(
              cursorColor: AppColors.primaryColor,
              style: homePage_SearchBar,
              decoration: InputDecoration(
                fillColor: AppColors.secondaryColor,
                filled: true,
                hintText: "Search a product",
                hintStyle: homePage_SearchBar,
                contentPadding: EdgeInsets.all(10),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius:
                  BorderRadius.all(Radius.circular(15)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius:
                  BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
            decoration: BoxDecoration(
                boxShadow: [
                  const BoxShadow(
                    offset: Offset(0,3),
                    spreadRadius: 0.5,
                    blurRadius: 10,
                    color: AppColors.loginSearchShadow,
                  ),
                ]
            ),
          ),
        )
      ]
  );
}

Widget emptyHistory() {
  return Container(
    child: Column(
        children: [
          Image.asset(
              "assets/empty_illust.png"
          ),
          SizedBox(height:10),
          Text(
            "Oops... Looks like you haven't researched anything.",
            textAlign: TextAlign.center,
            style: searchPage_EmptySearchBold,
          ),
          SizedBox(height:5),
          Text(
            "What about a brand new phone?\nType \"iPhone 13 Pro\"",
            textAlign: TextAlign.center,
            style: searchPage_EmptySearchNormal,
          )
        ]
    ),
  );
}
