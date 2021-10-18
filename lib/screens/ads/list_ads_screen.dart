import 'package:classified_app/screens/ads/create_ad_screen.dart';
import 'package:classified_app/screens/users/settings_screen.dart';
import 'package:classified_app/services/auth_service.dart';
import 'package:classified_app/utils/colors_utils.dart';
import 'package:classified_app/utils/size_utils.dart';
import 'package:classified_app/widgets/card_ad.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListAdsScreen extends StatefulWidget {
  const ListAdsScreen({Key? key}) : super(key: key);

  @override
  _ListAdsScreenState createState() => _ListAdsScreenState();
}

class _ListAdsScreenState extends State<ListAdsScreen> {
  var apiUrlAds = Uri.parse("https://adlisting.herokuapp.com/ads");
  var apiUrlUser = Uri.parse("https://adlisting.herokuapp.com/user/profile");
  List _ads = [];
  var _user = {};
  // Instance to the class to manage the token
  final Auth _auth = Get.put(Auth());

  getAds() async {
    try {
      await http.get(apiUrlAds).then((res) {
        setState(() {
          var data = json.decode(res.body);
          _ads = data["data"];
          getCurrentUser();
        });
      }).catchError((e) {
        showScaffoldMessenger(e.toString());
      });
    } catch (e) {
      showScaffoldMessenger(e.toString());
    }
  }
  // Method to get the current user
  getCurrentUser() async {
    try {
      var token = _auth.token.value;
      await http.post(
        apiUrlUser,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ).then((res) {
        var data = json.decode(res.body);
        // Validate the status (distinct to false)
        if (!data["status"]) {
          showScaffoldMessenger(data["message"]); // false (show a message)
        } else {
          setState(() {
            var data = json.decode(res.body);
            _user = data["data"];
          });
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
    getAds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.mainColor,
        title: const Text(
          'Ads Listing',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => SettingsScreen(
                    userData: _user,
                  ));
            },
            child: Container(
              alignment: Alignment.center,
              child: buildUserImg(),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        backgroundColor: CustomColors.buttonColor,
        color: CustomColors.whiteColor,
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              getAds();
            });
            showScaffoldMessenger('Page Refreshed', 'success');
          });
        },
        child: Container(
          padding: EdgeInsets.all(
            SizeConfig.screenWidth * 0.02,
          ),
          child: _ads.isEmpty
              ? const Text('')
              : buildGridView(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: CustomColors.buttonColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Get.to(() => const CreateAdScreen());
        },
        child: const Icon(Icons.add_a_photo_outlined),
      ),
    );
  }

  // Load the img when it's ready
  Widget buildUserImg() {
    return Container(
      padding: EdgeInsets.only(
        right: getProportionateScreenWidth(4),
      ),
      child: CircleAvatar(
        backgroundColor: CustomColors.greyColor,
        backgroundImage:
            _user.isNotEmpty ? NetworkImage(_user["imgURL"]) : null,
      ),
    );
  }

  // Build the GridView with all the content
  GridView buildGridView() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: getProportionateScreenWidth(8),
          mainAxisSpacing: getProportionateScreenWidth(8),
        ),
        itemCount: _ads.length,
        itemBuilder: (BuildContext context, index) {
          return AdCardWidget(adData: _ads[index]);
        });
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
