import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:learning_managment_system/controller/Courses/coursecontroller.dart';
import 'package:learning_managment_system/core/constant/url.dart';
import 'package:learning_managment_system/model/courses/coursemodel.dart';
import 'package:learning_managment_system/model/courses/subcoursesmodel.dart';
import 'package:learning_managment_system/services/services.dart';

abstract class SubCourseCont extends GetxController {
  final http.Client client = http.Client();
  var subcoursesList = <Subcoursesmodel>[].obs;

  Subcoursesmodel? coursemodel;
}

class SubCourseConImp extends SubCourseCont {
  @override
  void onInit() {
    super.onInit();
    fetchCourses(0);
  }
  

  var subId;
  CourseCountrollerImp countrollerImp = Get.find();
  MyServices myServices = Get.find();

  var isLoading = false.obs;

  Future<void> fetchCourses(subcourseIndex) async {
    subId = subcourseIndex;
    try {
      String? token = myServices.sharedPreferences.getString('access_token');
      var url = '${AppUrl.baseUrl}/courses?categoryId=$subId';
      var response = await client.get(Uri.parse(url), 
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      var jsonData;

      print("Subbbbbbbbb");
      print(response.statusCode);
      print(response);
      if (response.statusCode == 200) {
        print(response);

        print("true44444");

        jsonData = jsonDecode(response.body);

        subcoursesList.value = List<Subcoursesmodel>.from(jsonData['courses']
            .map((model) => Subcoursesmodel.fromJson(model)));

        print(jsonData);
        if (subcourseIndex >= 0 &&
            subcourseIndex < jsonData['courses'].length) {
          coursemodel = Subcoursesmodel.fromJson(
              jsonData['courses'][subcourseIndex]);
        }
      }
      update();
      
    }

    // catch (e) {
    //   print('Error fetching courses: $e');
    //   category.courses!.clear();
    // }
    finally {
//isLoading(true);
      print('donesubcourse');
    }
  }
}
