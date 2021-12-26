import 'package:flutter/material.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:devstore_project/utils/dimension.dart';

class productView extends StatefulWidget {
  const productView({Key? key}) : super(key: key);

  @override
  _productViewState createState() => _productViewState();
}

void buttonClicked() {
  print('Button Clicked');
}

final isSelected = <bool>[true, false, false];

class _productViewState extends State<productView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: const IconButton(
          splashRadius: 16.0,
          onPressed: buttonClicked,
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 350.0,
              child:
              ListView(
                scrollDirection: Axis.horizontal, // <-- Like so
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/iphone13-1.png"),
                          fit: BoxFit.fitHeight,
                        )),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/iphone13-2.png"),
                          fit: BoxFit.fitHeight,
                        )),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/iphone13-3.png"),
                          fit: BoxFit.fitHeight,
                        )),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('iPhone 13 Pro Max 256 GB', style: fav_camp_recomBanner),
                      Text(
                        'by Apple',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: -16.0,
                      children: const [
                        IconButton(
                          icon: Icon(Icons.favorite),
                          splashRadius: 21.0,
                          onPressed: buttonClicked,
                        ),
                        IconButton(
                          icon: Icon(Icons.bookmark),
                          splashRadius: 21.0,
                          onPressed: buttonClicked,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0,0.0,0.0,0.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.star,
                    color: Color(0xFF5B278D),
                    size: 16.0,
                  ),
                  SizedBox(width: 2.0),
                  Text(
                    '(Rating: 3.4)',
                    style: TextStyle(
                      fontSize: 9.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: const Color(0xFFBFA2DB).withOpacity(0.40),
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
              ),
              child: ToggleButtons(
                color: const Color(0xFF5B278D),
                selectedColor: const Color(0xFF5B278D),
                disabledColor: const Color(0xFFBFA2DB).withOpacity(0.40),
                fillColor: const Color(0xFFBFA2DB),
                splashColor: const Color(0xFF5B278D).withOpacity(0.12),
                hoverColor: const Color(0xFF5B278D).withOpacity(0.04),
                borderRadius: BorderRadius.circular(50.0),
                constraints: const BoxConstraints(minHeight: 34.0),
                isSelected: isSelected,
                onPressed: (index) {
                  // Respond to button selection
                  setState(() {
                    isSelected[index] = !isSelected[index];
                  });
                },
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Overview'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Details'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Comments'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
