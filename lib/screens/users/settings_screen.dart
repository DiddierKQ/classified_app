
import 'package:classified_app/screens/users/edit_profile_screen.dart';
import 'package:classified_app/utils/colors_utils.dart';
import 'package:classified_app/utils/size_utils.dart';
import 'package:classified_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialice the Sizeconfig with the context
    SizeConfig(context);

    return Scaffold(
      appBar: AppBarWidget(
        title: 'Settings',
        enableReturnButton: true,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(
            top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    onTap: () {
                      Get.to(EditProfileScreen());
                    },
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage("assets/logo.png"),
                    ),
                    title: const Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      "Phone",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(12),
                      ),
                    ),
                    trailing: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          color: CustomColors.buttonColor,
                          fontSize: getProportionateScreenWidth(12),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(
                      Icons.post_add_outlined,
                      size: SizeConfig.screenHeight * 0.03,
                    ),
                    title: Text(
                      "My ads",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(12),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(
                      Icons.person_outline_outlined,
                      size: SizeConfig.screenHeight * 0.03,
                    ),
                    title: Text(
                      "About us",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(12),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.contacts_outlined,
                      size: SizeConfig.screenHeight * 0.03,
                    ),
                    title: Text(
                      "Contact us",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
