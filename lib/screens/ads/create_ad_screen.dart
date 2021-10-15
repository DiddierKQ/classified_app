import 'package:classified_app/utils/colors_utils.dart';
import 'package:classified_app/utils/size_utils.dart';
import 'package:classified_app/widgets/appbar.dart';
import 'package:flutter/material.dart';

class CreateAdScreen extends StatelessWidget {
  CreateAdScreen({Key? key}) : super(key: key);

  // Textfield values
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();
  final TextEditingController _contactNumberCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Initialice the Sizeconfig with the context
    SizeConfig(context);

    return Scaffold(
      appBar: AppBarWidget(
        title: 'Create ad',
        enableReturnButton: true,
      ),
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
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(
                    SizeConfig.screenHeight * 0.01,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo_outlined,
                        size: SizeConfig.screenHeight * 0.04,
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.01,
                      ),
                      Text(
                        'Tap to upload',
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(12),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: CustomColors.greyColor.withOpacity(0.5),
                    ),
                    shape: BoxShape.rectangle,
                  ),
                  width: SizeConfig.screenHeight * 0.14,
                  height: SizeConfig.screenHeight * 0.14,
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              titleTextField(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              priceTextField(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              contactNumberTextField(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.02,
              ),
              descriptionTextField(),
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
                    'Submit ad',
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
            ],
          ),
        ),
      ),
    );
  }

  // Create the title TextField
  Container titleTextField() {
    return Container(
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.04,
        right: SizeConfig.screenWidth * 0.04,
      ),
      child: TextField(
        controller: _titleCtrl,
        keyboardType: TextInputType.text,
        cursorColor: CustomColors.greyColor,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.greyColor),
          ),
          labelText: 'Title',
          labelStyle: TextStyle(
            //fontSize: 20,
            color: CustomColors.greyColor,
          ),
        ),
      ),
    );
  }

  // Create the price TextField
  Container priceTextField() {
    return Container(
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.04,
        right: SizeConfig.screenWidth * 0.04,
      ),
      child: TextField(
        controller: _priceCtrl,
        keyboardType: TextInputType.text,
        cursorColor: CustomColors.greyColor,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.greyColor),
          ),
          labelText: 'Price',
          labelStyle: TextStyle(
            //fontSize: 20,
            color: CustomColors.greyColor,
          ),
        ),
      ),
    );
  }

  // Create the contact number TextField
  Container contactNumberTextField() {
    return Container(
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.04,
        right: SizeConfig.screenWidth * 0.04,
      ),
      child: TextField(
        controller: _contactNumberCtrl,
        keyboardType: TextInputType.text,
        cursorColor: CustomColors.greyColor,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.greyColor),
          ),
          labelText: 'Contact number',
          labelStyle: TextStyle(
            //fontSize: 20,
            color: CustomColors.greyColor,
          ),
        ),
      ),
    );
  }

  // Create the description TextField
  Container descriptionTextField() {
    return Container(
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.04,
        right: SizeConfig.screenWidth * 0.04,
      ),
      child: TextField(
        controller: _descriptionCtrl,
        keyboardType: TextInputType.text,
        cursorColor: CustomColors.greyColor,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.greyColor),
          ),
          labelText: 'Description',
          labelStyle: TextStyle(
            //fontSize: 20,
            color: CustomColors.greyColor,
          ),
        ),
      ),
    );
  }
}
