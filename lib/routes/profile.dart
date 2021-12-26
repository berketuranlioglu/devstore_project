import 'package:flutter/material.dart';
import 'package:devstore_project/objects/profile_menu.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:devstore_project/routes/edit_profile.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(height: 40),


            SizedBox(
              height: 115,
              width: 115,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/pro_image.png"),
                  ),
                  /*
                  Positioned(
                    right: -16,
                    bottom: 0,
                    child: SizedBox(
                      height: 46,
                      width: 46,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: Colors.white),
                          ),
                          primary: Colors.white,
                          backgroundColor: Color(0xFFF5F6F9),
                        ),
                        onPressed: () {},
                        child: SvgPicture.asset("assets/camera_icon.svg"),
                      ),
                    ),
                  )
                  */
                ],
              ),
            ),


            SizedBox(height: 20),

            Text(
              'Bob Richardson',
              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: Color(0xFF9441E4),),
            ),

            Text(
              '@bobrichard9443',
              style: const TextStyle(fontSize: 14,color: Colors.black54,),
            ),

            SizedBox(height: 30),

            ProfileMenu(
              text: "Orders",
              icon: "assets/box.jpg",
              press: () => {},
            ),
            ProfileMenu(
              text: "Bookmarks",
              icon: "assets/mark.png",
              press: () {},
            ),
            ProfileMenu(
              text: "Favorites",
              icon: "assets/kalp.png",
              press: () {},
            ),
            ProfileMenu(
              text: "Reviews",
              icon: "assets/comment.png",
              press: () {},
            ),
            ProfileMenu(
              text: "Account Information",
              icon: "assets/man.png",
              press: () {},
            ),
            ProfileMenu(
              text: "Profile Settings",
              icon: "assets/set.png",
              press: () {
                Navigator.pushNamed(context, '/editProfile');
              },
            ),
          ],
        ),
      )
    );
  }
}