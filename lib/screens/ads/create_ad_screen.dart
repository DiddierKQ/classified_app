import 'dart:convert';

import 'package:classified_app/services/auth_service.dart';
import 'package:classified_app/utils/colors_utils.dart';
import 'package:classified_app/utils/size_utils.dart';
import 'package:classified_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class CreateAdScreen extends StatefulWidget {
  const CreateAdScreen({Key? key}) : super(key: key);

  @override
  _CreateAdScreenState createState() => _CreateAdScreenState();
}

class _CreateAdScreenState extends State<CreateAdScreen> {
  // Create the key to the form
  final _formkey = GlobalKey<FormState>();
  // Textfield values
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();
  final TextEditingController _contactNumberCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();

  // Instance to the class to manage the token
  final Auth _auth = Get.put(Auth());

  var apiUrlAds = Uri.parse("https://adlisting.herokuapp.com/ads");
  var apiUrlAdPictures =
      Uri.parse("https://adlisting.herokuapp.com/upload/photos");

  var imagesUploaded = [];
  // Function to upload a single image
  uploadMultipleImg() async {
    try {
      var images = await ImagePicker().pickMultiImage();
      var request = http.MultipartRequest('POST', apiUrlAdPictures);
      images!.forEach((image) async {
        request.files.add(
          await http.MultipartFile.fromPath(
            'photos',
            image.path,
          ),
        );
      });

      var response = await http.Response.fromStream(await request.send());
      var data = json.decode(response.body);

      setState(() {
        imagesUploaded = data['data']['path'];
      });
    } catch (e) {
      showScaffoldMessenger(e.toString());
    }
  }
  // Function to create a new ad
  createAd() async {   
    // Validate if there are pictures uploaded
    if (imagesUploaded.isNotEmpty) {
      var body = json.encode({
        "title": _titleCtrl.text,
        "description": _descriptionCtrl.text,
        "price": _priceCtrl.text,
        "mobile": _contactNumberCtrl.text,
        "images": imagesUploaded,
      });
      try {
        var token = _auth.token.value;
        await http
            .post(
          apiUrlAds,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          body: body,
        )
            .then((res) {
          var data = json.decode(res.body);
          // Validate the status (distinct to false)
          if (!data["status"]) {
            showScaffoldMessenger(
                'It was an error to create the ad, please try again later'); // false (show a message)
          } else {
            showScaffoldMessenger(
                'Ad created successfully', 'success'); // true (show a message)
          }
        }).catchError((e) {
          showScaffoldMessenger(e.toString());
        });
      } catch (e) {
        showScaffoldMessenger(e.toString());
      }
    } else {
      showScaffoldMessenger('It is necessary to add pictures');
    }
  }

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
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                buildUploadPhotoIcon(),
                imagesUploaded.isNotEmpty
                    ? buildImagesPreview()
                    : SizedBox(
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
                buildSubmitButton(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Create icon to upload photo
  GestureDetector buildUploadPhotoIcon() {
    return GestureDetector(
      onTap: () {
        uploadMultipleImg();
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
    );
  }

  // Create a photo visualizator once the images are load
  Container buildImagesPreview() {
    return Container(
      //color: Colors.amber,
      padding: EdgeInsets.only(
        //left: SizeConfig.screenWidth * 0.01,
        //right: SizeConfig.screenWidth * 0.01,
        top: SizeConfig.screenHeight * 0.02,
        bottom: SizeConfig.screenHeight * 0.02,
      ),
      height: SizeConfig.screenHeight * 0.20,
      width: SizeConfig.screenWidth * 0.90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: imagesUploaded.length,
        itemBuilder: (bc, index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              width: SizeConfig.screenHeight * 0.14,
              height: SizeConfig.screenHeight * 0.14,
              padding: EdgeInsets.only(
                top: SizeConfig.screenWidth * 0.02,
                bottom: SizeConfig.screenWidth * 0.02,
              ),
              margin: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.01,
                right: SizeConfig.screenWidth * 0.01,
              ),
              decoration: BoxDecoration(
                //color: Colors.blue,
                border: Border.all(
                  color: CustomColors.greyColor.withOpacity(0.5),
                ),
                shape: BoxShape.rectangle,
              ),
              child: Container(
                width: SizeConfig.screenHeight * 0.14,
                height: SizeConfig.screenHeight * 0.14,
                margin: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.02,
                  right: SizeConfig.screenWidth * 0.02,
                ),
                padding: EdgeInsets.only(
                  top: SizeConfig.screenWidth * 0.02,
                  bottom: SizeConfig.screenWidth * 0.02,
                ),
                decoration: BoxDecoration(
                  //color: Colors.red,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      imagesUploaded[index],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
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
      child: TextFormField(
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
        onSaved: (value) => setState(() => _titleCtrl.text = value!),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter a title';
          } else {
            return null;
          }
        },
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
      child: TextFormField(
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
        onSaved: (value) => setState(() => _priceCtrl.text = value!),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter a price';
          } else {
            return null;
          }
        },
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
      child: TextFormField(
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
        onSaved: (value) => setState(() => _contactNumberCtrl.text = value!),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter a contact number';
          } else {
            return null;
          }
        },
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
      child: TextFormField(
        controller: _descriptionCtrl,
        keyboardType: TextInputType.multiline,
        cursorColor: CustomColors.greyColor,
        maxLines: 3,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.greyColor),
          ),
          labelText: 'Description',
          // Used to multiline to position the text on top
          alignLabelWithHint: true, 
          labelStyle: TextStyle(
            //fontSize: 20,
            color: CustomColors.greyColor,
          ),
        ),
        onSaved: (value) => setState(() => _descriptionCtrl.text = value!),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter a description';
          } else {
            return null;
          }
        },
      ),
    );
  }

  // Create the submit button
  Container buildSubmitButton() {
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
            SizeConfig.screenHeight * 0.08,
          ),
        ),
        onPressed: () {
          final isValid = _formkey.currentState!.validate();

          if (isValid) {
            _formkey.currentState!.save();
            createAd();
          }
        },
        child: Text(
          'Submit ad',
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenWidth(14),
          ),
        ),
      ),
    );
  }

  // Create a dynamic notification
  showScaffoldMessenger(message, [type = '']) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(12),
          ),
        ),
        backgroundColor: type != '' ? Colors.green : Colors.red,
      ),
    );
  }
}
