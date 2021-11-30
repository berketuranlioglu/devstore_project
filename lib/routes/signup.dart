import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:devstore_project/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String mail = "";
  String pass1 = "";
  String pass2 = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100.0),
              RichText(
                text: TextSpan(
                  style: signupPage_InfoSentence1,
                  children: <TextSpan>[
                    TextSpan(text: "Let's get started "),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'Create an account to get all features',
                textAlign: TextAlign.center,
                style: signupPage_InfoSentence2,
              ),
              SizedBox(height: 50.0),
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
                              hintText: 'Name Surname',
                              hintStyle: const TextStyle(fontSize: 14.0),
                              prefixIcon: const Icon(Icons.person_outline,
                                  color: Colors.grey),
                              contentPadding: const EdgeInsets.all(12.0),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.grey[200],
                              filled: true,
                              hintText: 'Email',
                              hintStyle: const TextStyle(fontSize: 14.0),
                              prefixIcon: const Icon(Icons.email_outlined,
                                  color: Colors.grey),
                              contentPadding: const EdgeInsets.all(12.0),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
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
                    const SizedBox(height: 8.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.grey[200],
                              filled: true,
                              hintText: 'Phone',
                              hintStyle: const TextStyle(fontSize: 14.0),
                              prefixIcon: const Icon(Icons.phone_outlined,
                                  color: Colors.grey),
                              contentPadding: const EdgeInsets.all(12.0),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.grey[200],
                              filled: true,
                              hintText: 'Username',
                              hintStyle: const TextStyle(fontSize: 14.0),
                              prefixIcon: const Icon(Icons.person_outline,
                                  color: Colors.grey),
                              contentPadding: const EdgeInsets.all(12.0),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
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
                              hintStyle: const TextStyle(fontSize: 14.0),
                              prefixIcon: const Icon(Icons.lock_outlined,
                                  color: Colors.grey),
                              contentPadding: const EdgeInsets.all(12.0),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            validator: (value) {
                              if (value == null) {
                                return 'Password field cannot be empty';
                              } else {
                                String trimmedValue = value.trim();
                                if (trimmedValue.isEmpty) {
                                  return 'Password field cannot be empty';
                                }
                                if (trimmedValue.length < 8) {
                                  return 'Password must be at least 8 characters long';
                                }
                              }
                              return null;
                            },
                            onSaved: (value) {
                              if (value != null) {
                                pass1 = value;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: Colors.grey[200],
                              filled: true,
                              hintText: 'Confirm Password',
                              hintStyle: const TextStyle(fontSize: 14.0),
                              prefixIcon: const Icon(Icons.lock_outline,
                                  color: Colors.grey),
                              contentPadding: const EdgeInsets.all(12.0),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            validator: (value) {
                              if (value == null) {
                                return 'Password field cannot be empty';
                              } else {
                                String trimmedValue = value.trim();
                                if (trimmedValue.isEmpty) {
                                  return 'Password field cannot be empty';
                                }
                                if (trimmedValue.length < 8) {
                                  return 'Password must be at least 8 characters long';
                                }
                                if (pass1 != value) {
                                  return 'Passwords must be same';
                                }
                              }
                              return null;
                            },
                            onSaved: (value) {
                              if (value != null) {
                                pass2 = value;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Form(
                      child: FlatButton(
                        child: Text(
                          'SIGN IN',
                          style: signupPage_ButtonTxts,
                        ),
                        color: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Sign In Successful!')));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
