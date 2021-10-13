import 'package:classified_app/utils/size_utils.dart';
import 'package:classified_app/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdCardWidget extends StatefulWidget {
  //const AdCardWidget({ Key? key }) : super(key: key);

  String title;
  int price;
  String image;

  AdCardWidget({
    Key? key,
    required this.title,
    required this.price,
    required this.image,
  }) : super(key: key);

  @override
  _AdCardWidgetWidgetState createState() => _AdCardWidgetWidgetState();
}

class _AdCardWidgetWidgetState extends State<AdCardWidget> {
  @override
  Widget build(BuildContext context) {
    // Initialice the Sizeconfig with the context
    SizeConfig(context);

    return Container(
      height: SizeConfig.screenHeight * 0.60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey,),
      ),
      child: Stack(
        children: [
          Align(
            child: GestureDetector(
              onTap: () {
               
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(                  
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                    widget.image,                   
                  ),
                ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: SizeConfig.screenHeight * 0.10,
              width: double.infinity,
              color: CustomColors.mainColor.withOpacity(0.5),
              child: Container(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 4.0, left: 16.0, right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                    Text(
                      "\$ ${widget.price.toDouble()}",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                          color: CustomColors.priceColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
