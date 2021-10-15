import 'package:classified_app/screens/users/login_screen.dart';
import 'package:classified_app/utils/colors_utils.dart';
import 'package:classified_app/utils/size_utils.dart';
import 'package:classified_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({ Key? key }) : super(key: key);

  // Textfield values
  final TextEditingController _nameCtrl = TextEditingController(text: 'Diddier');
  final TextEditingController _emailCtrl = TextEditingController(text: 'diddier.kantun@gmail.com');
  final TextEditingController _mobileNumberCtrl = TextEditingController(text: '9991581067');

  @override
  Widget build(BuildContext context) {
    // Initialice the Sizeconfig with the context
    SizeConfig(context);

    return Scaffold(
      appBar: AppBarWidget(title: 'Edit profile', enableReturnButton: true,),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(
            FocusNode(),
          ); // Function to hide the keyboard once you clic outside the textfield
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              CircleAvatar(
                maxRadius: getProportionateScreenHeight(48),
                backgroundImage:
                    AssetImage("assets/logo.png"),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              nameTextField(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              emailTextField(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              mobileNumberTextField(),
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
                    'Update profile',
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
              logOutText(),
            ],
          ),
        ),
      ),
    );
  }

  // Create the name TextField
  Container nameTextField() {
    return Container(
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.04,
        right: SizeConfig.screenWidth * 0.04,
      ),
      child: TextField(
        controller: _nameCtrl,
        keyboardType: TextInputType.text,
        cursorColor: CustomColors.greyColor,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.greyColor),
          ),
          labelText: 'Name',
          labelStyle: TextStyle(
            //fontSize: 20,
            color: CustomColors.greyColor,
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
          labelText: 'Email address',
          labelStyle: TextStyle(
            //fontSize: 20,
            color: CustomColors.greyColor,
          ),
        ),
      ),
    );
  }

  // Create the mobile number TextField
  Container mobileNumberTextField() {
    return Container(
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.04,
        right: SizeConfig.screenWidth * 0.04,
      ),
      child: TextField(
        controller: _mobileNumberCtrl,
        keyboardType: TextInputType.text,
        cursorColor: CustomColors.greyColor,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.greyColor),
          ),
          labelText: 'Mobile number',
          labelStyle: TextStyle(
            //fontSize: 20,
            color: CustomColors.greyColor,
          ),
        ),
      ),
    );
  }
  // Create the log out text
  Container logOutText() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        child: Text(
          'Logout',
          style: TextStyle(
            fontSize: getProportionateScreenWidth(12),
            color: CustomColors.buttonColor,
          ),
        ),
        onPressed: () {
          Get.to(() => LoginScreen());
        },
      ),
    );
  }
}