import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/profile/profilecontroller.dart';
import 'package:learning_managment_system/core/constant/url.dart';

import 'package:learning_managment_system/model/profile/proflemodel.dart';
import 'package:learning_managment_system/services/services.dart';

abstract class ProfileController extends GetxController {
  final http.Client client = http.Client();
  // final ProfileUpdteController controller = Get.put(ProfileUpdteController());
  var enrolled = <EnrolledCourses>[].obs;
  // var profileModel = <ProfileModel>[].obs;
  // ProfileModel? profileModel;
}

class ProfileControllerImp extends ProfileController {
  MyServices myServices = Get.find();
  //var student= <Student>[].obs;
  Student student = Student();
  var studentmm = Student().obs;
  // var profile = <Student>[].obs;

  @override
  void onInit() {
    fetchProfile();

    super.onInit();
  }

  void fetchProfile() async {
    try {
      String? token = myServices.sharedPreferences.getString('access_token');

      var response = await client.get(Uri.parse(AppUrl.profile), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      print("profile");
      print(response.statusCode);
      print(response);
      if (response.statusCode == 200) {
        print(response);

        var jsonData = jsonDecode(response.body);
        //profileModel = ProfileModel.fromJson(jsonData['student']);
        student = Student.fromJson(jsonData['student']);
        print('object');

        // controller.updatedUser(imageFile);
        enrolled.value = List<EnrolledCourses>.from(jsonData['enrolled_courses']
            .map((model) => EnrolledCourses.fromJson(model)));

        // profileModel.value = (jsonData['student'] as List)
        //     .map((model) => ProfileModel.fromJson(model))
        //     .toList();
        print(jsonData);
        update();
      } else {
        print("falseprofile");
      }
    } finally {
      print('doneprofile');
    }
  }

  var isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
