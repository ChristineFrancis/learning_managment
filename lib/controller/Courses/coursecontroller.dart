import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:learning_managment_system/core/constant/url.dart';

import 'package:learning_managment_system/model/courses/coursemodel.dart';
import 'package:learning_managment_system/services/services.dart';

abstract class CoursesController extends GetxController with GetTickerProviderStateMixin {
 
  toggleAnimation();
  final http.Client client = http.Client();
  CoursesModel? courses;
}

class CourseCountrollerImp extends CoursesController {
   AnimationController? animationController;
  final isPlaying = false.obs;



  @override
  void onInit() {
      animationController = AnimationController(
    vsync: this,
     duration: const Duration(milliseconds: 1000));
    animationController?.repeat();
    
    super.onInit();
  }

 @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  } 
   @override
  void toggleAnimation() {
    isPlaying.toggle();
    isPlaying.value ? animationController?.forward() : animationController?.stop();
  }

  var courseId;
  MyServices myServices = Get.find();
  var coursesList = <CoursesModel>[].obs;
  var jsonData;

  var isLoading = false.obs;

  Future<void> fetchCourses(var courseIndex) async {
    courseId = courseIndex;
    try {
      String? token = myServices.sharedPreferences.getString('access_token');
      var url = '${AppUrl.baseUrl}/categories/${courseId!}';
      var response = await client.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      print("yescours");
      print(response.statusCode);
      print(response);
      if (response.statusCode == 200) {
        print("true3");
        jsonData = jsonDecode(response.body);
        coursesList.value = List<CoursesModel>.from(jsonData['categories']
            .map((model) => CoursesModel.fromJson(model)));
        print(jsonData);
        if (courseIndex >= 0 && courseIndex < jsonData['categories'].length) {
          courses = CoursesModel.fromJson(jsonData['categories'][courseIndex]);
        }
      }
      update();
     
    } finally {
      
      print('done');
    }
  }

 
}
