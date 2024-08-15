import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:learning_managment_system/controller/Auth/login_controller.dart';

import 'package:learning_managment_system/controller/profile/profilegetdata.dart';
import 'package:learning_managment_system/controller/profile/profilecontroller.dart';
import 'package:learning_managment_system/controller/search.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/routes.dart';
import 'package:learning_managment_system/view/screen/Auth/login.dart';
import 'package:learning_managment_system/view/screen/aboutUs/aboutUs.dart';
import 'package:learning_managment_system/view/screen/profile/editprofile.dart';

import 'package:learning_managment_system/view/widget/profile/profiletilewidget.dart';

class ProfilePage2 extends StatelessWidget {
  final ProfileControllerImp controller = Get.put(ProfileControllerImp());
  final LoginControllerImp loginController = Get.put(LoginControllerImp());
  final ProfileUpdteController controllerpro =
      Get.put(ProfileUpdteController());
  final HomeControllerImp homeController = Get.put(HomeControllerImp());

  String? imageKey;
  String? F;
  String? L;
  String? E;
  void _showDialog1(String title, String content, String content1) {
    Get.defaultDialog(
      //  shadowColor: AppColor.purple4,
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: AppColor.whiteColor,
      title: title,
      titleStyle: TextStyle(color: Colors.black),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content,
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          Text(
            content1,
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ],
      ),
    );
  }

  void _showDialoglogout(
    String title,
  ) {
    Get.defaultDialog(
      //  shadowColor: AppColor.purple4,
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: AppColor.whiteColor,
      title: title,
      titleStyle: TextStyle(fontSize: 18, color: Colors.black),
      titlePadding: EdgeInsets.all(20),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
              onPressed: () {
                loginController.logout();
               Get.offAllNamed(AppRoute.splash);
              },
              child: Text(
                'Yes',
                style: TextStyle(fontSize: 20),
              )),
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                'No',
                style: TextStyle(fontSize: 20),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: ProfileTile(
              icon: Icons.person,
              title: 'Account',
              onTap: () => Get.to(() => ProfileUpdateScreen())),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProfileTile(
            icon: Icons.wallet,
            title: 'Wallet',
            // content:" controller.birthday.value",
            onTap: () => _showDialog1(
              'Wallet',
              "Balance: ${controller.student.wallet!.balance}",
              "Points:  ${controller.student.wallet!.points}",
            ),
          ),
        ),
        // ProfileTile(
        //     icon: Icons.settings,
        //     title: 'Settings',
        //     // content: "controller.phone.value",
        //     onTap: () {
        //       // showCustomDialog(context);
        //       Get.to(SettingsScreen());
        //     }
        //     //     _showDialog('Phone', " controller.phone.value", (value) {
        //     //   // controller.updateProfile(newPhone: value);
        //     //}),
        //     ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProfileTile(
              icon: Icons.emoji_emotions,
              title: 'AboutUs',
              onTap: () {
                Get.to(AboutUsPage());
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProfileTile(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () => _showDialoglogout('Are you sure you want to log out?'),
          ),
        ),
      ],
    );
  }
}
