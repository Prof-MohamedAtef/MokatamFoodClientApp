import 'package:flutter/material.dart';
import 'package:user_app/Authentication/methods/common_methods.dart';
import 'package:user_app/Authentication/signup_screen.dart';
import 'package:user_app/pages/home_page.dart';
import 'package:user_app/widgets/loading_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  CommonMethods cMethods = CommonMethods();

  checkIfNetworkIsAvilable() async {
    bool isConnected = await cMethods.checkConnectivity(context);
    if (isConnected) {
      signinFormValidation();
    }
  }

  signinFormValidation() {
    if (!emailTextEditingController.text.contains('@')) {
      cMethods.displaySnackBar('Please write valid email.', context);
    } else if (passwordTextEditingController.text.trim().length < 5) {
      cMethods.displaySnackBar(
        'Your password must be at least 6 or more characters.',
        context,
      );
    } else {
      signInUser();
      Navigator.push(context, MaterialPageRoute(builder: (c) => HomePage()));
    }
  }

  signInUser() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          LoadingDialog(messageText: "Allowing you to Login..."),
    );
    // *test
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (c) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Image.asset("assets/images/logo.png", height: 300, width: 300),
              Text(
                "Login as a User",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              // * Text Fields + Button
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(height: 22),
                    // * Email
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),

                    SizedBox(height: 22),
                    // * Password
                    TextField(
                      controller: passwordTextEditingController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    SizedBox(height: 32),
                    // Button
                    ElevatedButton(
                      onPressed: () {
                        checkIfNetworkIsAvilable();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        padding: EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 14,
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (c) => SignupScreen()),
                  );
                },
                child: Text(
                  'Don\'t have an Account? Register Her',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
