import 'dart:convert';

import 'package:classified_app/services/auth_service.dart';
import 'package:classified_app/utils/colors_utils.dart';
import 'package:classified_app/utils/size_utils.dart';
import 'package:classified_app/widgets/appbar.dart';
import 'package:classified_app/widgets/horizontal_card_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({Key? key}) : super(key: key);

  @override
  _MyAdsScreenState createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  var apiUrlAds = Uri.parse("https://adlisting.herokuapp.com/ads/user");
  List _ads = [];
  // Instance to the class to manage the token
  final Auth _auth = Get.put(Auth());

  getMyAds() async {
    try {
      var token = _auth.token.value;
      await http.post(
        apiUrlAds,
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
            _ads = data["data"];
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
    getMyAds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.scaffoldBackgroundColor,
      appBar: AppBarWidget(title: 'My ads', enableReturnButton: true,),
      body: Center(
        child: Container(
          //padding: const EdgeInsets.all(4.0),
          child: _ads.isEmpty
              ? const Text("Please make request")
              : buildLisView(),
        ),
      ),
    );
  }

  ListView buildLisView() {
    return ListView.builder(
      itemCount: _ads.length,
      itemBuilder: (bc, index) {
        return AdHorizontalCardWidget(
          adData: _ads[index],
        );
      },
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
