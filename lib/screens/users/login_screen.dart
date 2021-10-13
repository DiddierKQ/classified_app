import 'package:classified_app/utils/colors_utils.dart';
import 'package:classified_app/utils/size_utils.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Textfield values
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
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
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                emailTextField(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                passwordTextField(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                Container(
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
                    onPressed: () {},
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: getProportionateScreenWidth(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                signUpText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Create the email TextField
  Container emailTextField() {
    return Container(
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.04,
        right: SizeConfig.screenWidth * 0.04,
      ),
      child: TextField(
        controller: _emailCtrl,
        keyboardType: TextInputType.emailAddress,
        cursorColor: CustomColors.greyColor,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.greyColor),
          ),
          labelText: "Email address",
          labelStyle: TextStyle(
            //fontSize: 20,
            color: CustomColors.greyColor,
          ),
        ),
      ),
    );
  }

  // Create the password TextField
  Container passwordTextField() {
    return Container(
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.04,
        right: SizeConfig.screenWidth * 0.04,
      ),
      child: TextField(
        controller: _passwordCtrl,
        keyboardType: TextInputType.text,
        cursorColor: CustomColors.greyColor,
        obscureText: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.greyColor),
          ),
          labelText: "Password",
          labelStyle: TextStyle(
            //fontSize: 20,
            color: CustomColors.greyColor,
          ),
        ),
      ),
    );
  }

  // Create the sign up text
  Container signUpText() {
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
        onPressed: () {},
      ),
    );
  }
}
