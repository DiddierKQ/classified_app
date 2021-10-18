import 'dart:convert';

import 'package:classified_app/screens/users/login_screen.dart';
import 'package:classified_app/services/auth_service.dart';
import 'package:classified_app/utils/colors_utils.dart';
import 'package:classified_app/utils/size_utils.dart';
import 'package:classified_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {
  //const EditProfileScreen({ Key? key }) : super(key: key);

  var userData = {};

  EditProfileScreen({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Create the key to the form
  final _formkey = GlobalKey<FormState>();
  // Textfield values
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _mobileNumberCtrl = TextEditingController();

  // Instance to the class to manage the token
  final Auth _auth = Get.put(Auth());

  var apiUrlUser = Uri.parse("https://adlisting.herokuapp.com/user/");
  var apiUrlUserPicture =
      Uri.parse("https://adlisting.herokuapp.com/upload/profile");

  uploadImg() async {
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      var request = http.MultipartRequest('POST', apiUrlUserPicture);
      request.files.add(
        await http.MultipartFile.fromPath(
          'avatar',
          image!.path,
        ),
      );

      var response = await http.Response.fromStream(await request.send());
      var data = json.decode(response.body);
      var imgUrl = data['data']['path'];

      setState(() {
        widget.userData["imgURL"] = imgUrl;
      });
    } catch (e) {
      showScaffoldMessenger(e.toString());
    }
  }

  updateUser() async {
    var body = json.encode({
      "name": _nameCtrl.text,
      "email": _emailCtrl.text,
      "mobile": _mobileNumberCtrl.text,
      "imgURL": widget.userData["imgURL"],
    });
    try {
      var token = _auth.token.value;
      await http
          .patch(
        apiUrlUser,
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
              'It was an error updating the user, please try again later'); // false (show a message)
        } else {
          showScaffoldMessenger(
              'User updated successfully', 'success'); // true (show a message)
        }
      }).catchError((e) {
        showScaffoldMessenger(e.toString());
      });
    } catch (e) {
      showScaffoldMessenger(e.toString());
    }
  }

  @override
  void initState() {
    setState(() {
      _nameCtrl.text = widget.userData['name'];
      _emailCtrl.text = widget.userData['email'];
      _mobileNumberCtrl.text = widget.userData['mobile'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Initialice the Sizeconfig with the context
    SizeConfig(context);

    return Scaffold(
      appBar: AppBarWidget(
        title: 'Edit profile',
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
                buildProfilePicture(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                buildName(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                buildEmail(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                buildMobileNumber(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                buildUpdateProfileButton(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.03,
                ),
                buildLogOutText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Create the profile picture
  GestureDetector buildProfilePicture() {
    return GestureDetector(
      onTap: () {
        uploadImg();
      },
      child: CircleAvatar(
        maxRadius: getProportionateScreenHeight(48),
        backgroundImage: NetworkImage(widget.userData["imgURL"]),
      ),
    );
  }

  // Create the name TextField
  Container buildName() {
    return Container(
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.04,
        right: SizeConfig.screenWidth * 0.04,
      ),
      child: TextFormField(
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
        onSaved: (value) => setState(() => _nameCtrl.text = value!),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter a name';
          } else {
            return null;
          }
        },
      ),
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

  // Create the mobile number TextField
  Container buildMobileNumber() {
    return Container(
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.04,
        right: SizeConfig.screenWidth * 0.04,
      ),
      child: TextFormField(
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
        onSaved: (value) => setState(() => _mobileNumberCtrl.text = value!),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter a mobile number';
          } else {
            return null;
          }
        },
      ),
    );
  }

  // Create the button to update user profile
  Container buildUpdateProfileButton() {
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
          updateUser();
        },
        child: Text(
          'Update profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenWidth(14),
          ),
        ),
      ),
    );
  }

  // Create the log out text
  Container buildLogOutText() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        child: Text(
          'Logout',
          style: TextStyle(
            fontSize: getProportionateScreenWidth(14),
            color: CustomColors.buttonColor,
          ),
        ),
        onPressed: () {
          // _auth.token.value = '';
          // Get.to(() => const LoginScreen());
          showAlertDialog(context);
        },
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
  
  // Create the alert before logout
  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to close your session?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _auth.token.value = '';
              Get.to(() => const LoginScreen());
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
