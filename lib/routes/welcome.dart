import 'package:flutter/material.dart';
import 'package:devstore_project/utils/color.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/vec_backg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100.0),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 60.0,
                    color: AppColors.secondaryColor,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: 'dev', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'store'),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 250.0),
              Container(
                height: 60.0,
                width: 250.0,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.thirdColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(
                      color: AppColors.thirdColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0), // IKI TUS ARASI BOSLUK
              Container(
                height: 60.0,
                width: 250.0,
                child: OutlinedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextButton(onPressed: () {},
                child: Text(
                  'Continue as a guest.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.secondaryColor, // DEGISECEK
    );
  }
}

