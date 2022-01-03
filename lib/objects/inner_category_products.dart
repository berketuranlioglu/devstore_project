import 'package:devstore_project/objects/productButton.dart';
import 'package:flutter/material.dart';

class InnerCategoryProducts extends StatefulWidget {
  const InnerCategoryProducts({Key? key}) : super(key: key);

  @override
  _InnerCategoryProductsState createState() => _InnerCategoryProductsState();
}

class _InnerCategoryProductsState extends State<InnerCategoryProducts> {
  List exampleList = [1, 2, 3, 4, 5];
  @override
  Widget build(BuildContext context) {
    int length = exampleList.length;
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 30,
      runSpacing: 10,
      children: [
        for(int i = 0; i < length; i++)
          productButton().button(context),
      ],
    );
  }
}
