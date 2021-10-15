import 'package:classified_app/screens/users/settings_screen.dart';
import 'package:classified_app/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  String title;
  bool enableReturnButton;
  bool showActions;

  AppBarWidget({
    Key? key,
    required this.title,
    this.enableReturnButton = false,
    this.showActions = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColors.mainColor,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),      
      actions: [
        showActions ?
        GestureDetector(
          onTap: (){
            Get.to(()=> const SettingsScreen());
          },
          child: Container(
            alignment: Alignment.center,
            child: const CircleAvatar(
              backgroundImage: AssetImage("assets/logo.png"),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
              shape: BoxShape.circle,
            ),
            //width: 40,
            //height: 120,
          ),
        ) : const SizedBox(),
      ],
      automaticallyImplyLeading:
          enableReturnButton, // Avoid the return button on android devices
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
