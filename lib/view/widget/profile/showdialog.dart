import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:learning_managment_system/controller/darkmode.dart';
import 'package:learning_managment_system/controller/profile/profilecontroller.dart';
import 'package:learning_managment_system/controller/profile/profilegetdata.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/routes.dart';
import 'package:learning_managment_system/view/screen/Auth/sign_up.dart';

final ProfileUpdteController controllerpro = Get.put(ProfileUpdteController());
final ProfileControllerImp themeController = Get.put(ProfileControllerImp());
DarkModeController darkModeController = Get.put(DarkModeController());
showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shadowColor: AppColor.purple4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: AppColor.whiteColor,
        title: Center(child: Text('Alert!')),
        content: Text(
          'Do you really want to delete your Account?',
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                // color: AppColor.primaryColor,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 112, 165, 250)
                          .withOpacity(0.2)
                          .withOpacity(0.9),

                      spreadRadius: 2,
                      blurRadius: 8,
                      blurStyle: BlurStyle.outer,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // لإغلاق مربع الحوار
                  },
                  child: Text('No'),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 112, 165, 250)
                          .withOpacity(0.5)
                          .withOpacity(0.9),

                      spreadRadius: 2,
                      blurRadius: 8,
                      blurStyle: BlurStyle.outer,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton(
                  onPressed: () {
                    controllerpro.deletProfile();
                    
                    Get.offAllNamed(AppRoute.onboarding);
                  },
                  child: Text('Yes'),
                ),
              ),
            ],
          )
        ],
      );
    },
  );
}

showCustomDialogDark(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shadowColor: AppColor.purple4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: AppColor.whiteColor,
        title: Center(child: Text('')),
        content: Text(
          '',
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Switch(
                  value: themeController.isDarkMode.value,
                  onChanged: (value) {
                    themeController.toggleTheme();
                  }),
            ],
          )
        ],
      );
    },
  );
}
