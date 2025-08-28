import 'package:flutter/material.dart';
import 'package:user_app/Authentication/login_screen.dart';
import 'package:user_app/Authentication/methods/common_methods.dart';
import 'package:user_app/pages/home_page.dart';
import 'package:user_app/widgets/loading_dialog.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController phoneNumbeTextEditingController =
      TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  CommonMethods cMethods = CommonMethods();

  checkIfNetworkIsAvilable() async {
    bool isConnected = await cMethods.checkConnectivity(context);
    if (isConnected) {
      signUpFormValidation();
    }
  }

  signUpFormValidation() {
    if (userNameTextEditingController.text.trim().length < 4) {
      cMethods.displaySnackBar(
        'your name must be at least 4 or more characters.',
        context,
      );
    } else if (phoneNumbeTextEditingController.text.trim().length < 11) {
      cMethods.displaySnackBar(
        'Your phone number must be at least 11 digits.',
        context,
      );
    } else if (!emailTextEditingController.text.contains('@')) {
      cMethods.displaySnackBar('Please write valid email.', context);
    } else if (passwordTextEditingController.text.trim().length < 6) {
      cMethods.displaySnackBar(
        'Your password must be at least 6 or more characters.',
        context,
      );
    } else {
      registerNewUser();
    }
  }

  registerNewUser() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          LoadingDialog(messageText: "Registering your account..."),
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
                "Create a User's Account",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              // * Text Fields + Button
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(height: 22),
                    // * User Name
                    TextField(
                      controller: userNameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'User Name',
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),

                    SizedBox(height: 22),
                    // * Phone Number
                    TextField(
                      controller: phoneNumbeTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),

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
                        'Sign Up',
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
                    MaterialPageRoute(builder: (c) => LoginScreen()),
                  );
                },
                child: Text(
                  'Already have an Account? Login Her',
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
