import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/routes/welcome.dart';

//three-page onboarding view
class Content {
  String image;
  String heading;
  String description;
  Content({required this.image, required this.heading, required this.description});
}

List<Content> contents=[
  Content(
      heading: 'Welcome to devstore!',
      image: 'images/manshop.png',
      description: "A new generation shopping platform for all electronic products."
  ),
  Content(
      heading: 'Reliable Shopping',
      image: 'images/protect.png',
      description: "All products and sellers have been authenticated for safe shopping."
  ),
  Content(
      heading: 'Discounts & Offers',
      image: 'images/marketing.png',
      description: "Use the coupons on the product you want, whenever you want."
  ),
];

class WalkthroughView extends StatefulWidget {
  const WalkthroughView({Key? key}) : super(key: key);
  @override
  _WalkthroughViewState createState() => _WalkthroughViewState();
}

class _WalkthroughViewState extends State<WalkthroughView> {
  int c = 0;
  PageController pc = PageController(initialPage: 0);

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              controller: pc,
              itemCount: 3,
              onPageChanged: (int loc) {
                setState(() {
                  c = loc;
                });
              },
              itemBuilder: (_, x) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(40,50,40,40),
                  child: Column(
                    children: [
                      Image.asset(
                        contents[x].image,
                        width: MediaQuery.of(context).size.width,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child:  FittedBox(fit:BoxFit.scaleDown,
                          child: Text(
                            contents[x].heading,
                            style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                color: Colors.black.withOpacity(0.9),
                                fontSize: 25,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height:10),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                          child: Text(
                            contents[x].description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          )
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (loc) => dot(loc, context),),
          ),

          Container(
            height: MediaQuery.of(context).size.width * 0.11,
            margin: const EdgeInsets.fromLTRB(40, 40, 40, 10),
            width: double.infinity,
            child: FlatButton(
              child: Text(
                  c == 2 ? "Get Started!" : "Next",
                  style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                      fontSize: 15,
                  ))
              ),
              onPressed: () {
                if (c == 2) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Welcome(), //WELCOME PAGE
                    ),
                  );
                }
                pc.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeIn,
                );
              },

              color: AppColors.primaryColor,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
            child: TextButton(onPressed: (){
              pc.previousPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeIn,
              );},
                  child: const Text('Previous',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  )),
                ),
          )

        ], //children list
      ),
    );
  }

  Container dot(int loc, BuildContext context) {
    return Container(
      height: 10,
      width: c == loc ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.primaryColor,
      ),
    );
  }
}



