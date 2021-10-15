import 'dart:convert';

import 'package:classified_app/screens/ads/list_ads_screen.dart';
import 'package:classified_app/screens/users/signup_screen.dart';
import 'package:classified_app/services/auth_service.dart';
import 'package:classified_app/utils/colors_utils.dart';
import 'package:classified_app/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Create the key to the form
  final _formkey = GlobalKey<FormState>();
  // Textfield values
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  // Instance to the class to manage the token
  final Auth _auth = Auth();

  var apiUrl = Uri.parse("https://adlisting.herokuapp.com/auth/login");

  login() {
    var body = json.encode({
      "email": _emailCtrl.text,
      "password": _passwordCtrl.text,
    });

    try {
      http
          .post(
        apiUrl,
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      )
          .then((res) {
        var data = json.decode(res.body);
        // Validate the status (distinct to false)
        if (!data["status"]) {
          showScaffoldMessenger(data["message"]); // false (show a message)
        } else {
          // true (save the token and enter in the home screen)
          var token = data["data"]["token"];
          _auth.setToken(token);
          Get.offAll(() => const ListAdsScreen());
        }
      }).catchError((e) {
        showScaffoldMessenger(e);
      });
    } catch (e) {
      showScaffoldMessenger(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialice the Sizeconfig with the context
    SizeConfig(context);

    return Scaffold(
      backgroundColor: CustomColors.scaffoldBackgroundColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(
              FocusNode(),
            ); // Function to hide the keyboard once you clic outside the textfield
          },
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildLogo(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.04,
                  ),
                  buildEmail(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  buildPassword(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  buildLoginButton(),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.04,
                  ),
                  buildSignUpText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Create the logo
  Stack buildLogo() {
    return Stack(
      children: [
        Image.asset(
          "assets/background.png",
          width: SizeConfig.screenWidth,
          fit: BoxFit.cover,
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            top: SizeConfig.screenHeight * 0.12,
            bottom: SizeConfig.screenHeight * 0.12,
          ),
          child: Image.asset(
            "assets/logo.png",
            width: SizeConfig.screenWidth * 0.50,
          ),
        ),
      ],
    );
  }

  // Create the email TextField
  Container buildEmail() {
    return Container(
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.04,
        right: SizeConfig.screenWidth * 0.04,
      ),
      child: TextFormField(
        controller: _emailCtrl,
        keyboardType: TextInputType.emailAddress,
        cursorColor: CustomColors.greyColor,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.greyColor),
          ),
          labelText: 'Email address',
          labelStyle: TextStyle(
            //fontSize: 20,
            color: CustomColors.greyColor,
          ),
        ),
        //onChanged: (value) => setState(() => _emailCtrl.text = value),
        onSaved: (value) => setState(() => _emailCtrl.text = value!),
        validator: (value) {
          const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
          final regExp = RegExp(pattern);

          if (value!.isEmpty) {
            return 'Enter an email';
          } else if (!regExp.hasMatch(value)) {
            return 'Enter a valid email';
          } else {
            return null;
          }
        },
      ),
    );
  }

  // Create the password TextField
  Container buildPassword() {
    return Container(
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.04,
        right: SizeConfig.screenWidth * 0.04,
      ),
      child: TextFormField(
        controller: _passwordCtrl,
        keyboardType: TextInputType.text,
        cursorColor: CustomColors.greyColor,
        obscureText: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.greyColor),
          ),
          labelText: 'Password',
          labelStyle: TextStyle(
            //fontSize: 20,
            color: CustomColors.greyColor,
          ),
        ),
        //onChanged: (value) => setState(() => _passwordCtrl.text = value),
        onSaved: (value) => setState(() => _passwordCtrl.text = value!),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter a password';
          } else {
            return null;
          }
        },
      ),
    );
  }

  // Create the login button
  Container buildLoginButton() {
    return Container(
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.04,
        right: SizeConfig.screenWidth * 0.04,
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: CustomColors.buttonColor,
          minimumSize: Size(
            SizeConfig.screenWidth,
            SizeConfig.screenHeight * 0.06,
          ),
        ),
        onPressed: () {
          final isValid = _formkey.currentState!.validate();

          if (isValid) {
            _formkey.currentState!.save();
            login();
          }
        },
        child: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenWidth(12),
          ),
        ),
      ),
    );
  }

  // Create the sign up text
  Container buildSignUpText() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        child: Text(
          "Don't have any account?",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(12),
            color: CustomColors.buttonColor,
          ),
        ),
        onPressed: () {
          Get.to(() => const SignUpScreen());
        },
      ),
    );
  }

  // Create a dynamic notification
  showScaffoldMessenger(message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(12),
          ),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
