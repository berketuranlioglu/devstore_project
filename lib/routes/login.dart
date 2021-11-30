import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:devstore_project/services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String mail = '';
  String pass = '';
  final _formKey = GlobalKey<FormState>();

  AuthService auth = AuthService();

  void buttonClicked(){
    print('Button Clicked');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/Frame 1.png"),
                      fit: BoxFit.fill,
                    )
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0,),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 28.0,
                color: AppColors.textColor,
              ),
              children: <TextSpan>[
                TextSpan(text: 'Welcome to ', style: loginPage_WelcomeRegular),
                TextSpan(text: 'dev', style: loginPage_WelcomeBold),
                TextSpan(text: 'store', style: loginPage_WelcomeRegular),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            'Login to your existing account to continue',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.0,
              color: Color(0xff5f5b5b),
            ),
          ),
          const SizedBox(height: 8.0,),
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 4.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          hintText: 'E-mail',
                          hintStyle: const TextStyle(fontSize:14.0),
                          prefixIcon: const Icon(Icons.mail),
                          contentPadding: const EdgeInsets.all(12.0),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter an e-mail address!';
                          } else {
                            String trimmedValue = value.trim();
                            if (trimmedValue.isEmpty) {
                              return 'E-mail address cannot be empty!';
                            }
                            if (!EmailValidator.validate(trimmedValue)) {
                              return 'The e-mail you entered does not exist!';
                            }
                          }
                          return null;
                        },
                        onSaved: (value) {
                          if (value != null) {
                            mail = value;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          hintText: 'Password',
                          hintStyle: const TextStyle(fontSize:14.0),
                          prefixIcon: const Icon(Icons.lock),
                          contentPadding: const EdgeInsets.all(12.0),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        validator: (value) {
                          if(value != null) {
                            if(value.isEmpty) {
                              return 'Password cannot be empty!';
                            }
                            if(value.length < 8) {
                              return 'Password must be at least 8 characters!';
                            }
                          }
                          else {
                            return 'Please enter your password!';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          pass = value ?? '';
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 1.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text(
                        'Forgot your password?',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      onPressed: buttonClicked,
                      style: TextButton.styleFrom(
                        alignment: AlignmentDirectional.topEnd,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Form(
            key: _formKey,
            child: FlatButton(
              child: const Text(
                'LOG IN',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                ),
              ),
              color: AppColors.primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              onPressed: () {
                if(_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  auth.loginWithMailAndPass(mail, pass);

                  ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Log in successful!')));
                }
              },
            ),
          ),
          const SizedBox(height: 16.0,),
          const Text(
            'or connect using',
            style: TextStyle(
              color: Color(0xff5f5b5b),
              fontSize: 10.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RawMaterialButton(
                  onPressed: buttonClicked,
                  fillColor: AppColors.secondaryColor,
                  child: Image.asset(
                    'assets/Gmail Icon.png',
                    width: 12.0,
                    height: 12.0,
                    fit: BoxFit.cover,
                  ),
                  padding: const EdgeInsets.all(15.0),
                  shape: const CircleBorder(),
                ),
                RawMaterialButton(
                  onPressed: buttonClicked,
                  fillColor: AppColors.secondaryColor,
                  child: Image.asset(
                    'assets/Facebook Icon.png',
                    fit: BoxFit.cover,
                  ),
                  padding: const EdgeInsets.all(11.0),
                  shape: const CircleBorder(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18.0,),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 12.0,
                color: AppColors.textColor,
              ),
              children: <TextSpan>[
                const TextSpan(text: 'Don\'t have an account? '),
                TextSpan(
                  text: 'Sign up',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
