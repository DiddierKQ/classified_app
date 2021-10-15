import 'package:classified_app/screens/ads/create_ad_screen.dart';
import 'package:classified_app/utils/colors_utils.dart';
import 'package:classified_app/widgets/appbar.dart';
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
  var URL = Uri.parse("https://adlisting.herokuapp.com/ads");
  List _ads = [];

  getAds() async {
    try {
      await http.get(URL).then((res) {
        setState(() {
          var data = json.decode(res.body);
          _ads = data["data"];
        });
      }).catchError((e) {});
    } catch (e) {
      print(e);
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
      appBar: AppBarWidget(title: "Ads Listing", showActions: true,),
      body: Container(
        color: Colors.grey.shade100,
        padding: const EdgeInsets.all(16.0),
        child: _ads.isEmpty ? Text("Please make request") : buildGridView(),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: CustomColors.buttonColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Get.to(()=>CreateAdScreen());
        },
        child: const Icon(Icons.add_a_photo_outlined),
      ),
    );
  }

  GridView buildGridView() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _ads.length,
        itemBuilder: (BuildContext context, index) {
          return AdCardWidget(
              title: _ads[index]['title'],
              price: _ads[index]['price'],
              image: _ads[index]['images'][0]);
        });
  }
}
