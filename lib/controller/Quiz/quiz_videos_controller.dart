import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:learning_managment_system/controller/Quiz/quiz_controller.dart';
import 'package:learning_managment_system/core/class/statusrequest.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/routes.dart';
import 'package:learning_managment_system/core/constant/url.dart';
import 'package:learning_managment_system/core/functions/handlingdata.dart';
import 'package:learning_managment_system/model/course_details/quiz_model.dart';
import 'package:learning_managment_system/services/services.dart';

abstract class QuizPageController extends GetxController {
  fetchQuiz(int quizIndex);
  getCourseDetails();
}

class QuizPageControllerImp extends QuizPageController {
  static QuizControllerImp quizControllerImp = Get.put(QuizControllerImp());
  MyServices myServices = Get.find();
  Quizzes? quizzes;
  Course? course;
  var jsonData;
  List videos = ['1', '2', '3', '4', '5' , '6' , '7', '8' ];
  RxInt quiznum = 0.obs;
  RxInt quizid = 0.obs;

  @override
  void onInit() async {
    print('cooooorse details');
    super.onInit();
    await getCourseDetails();
    String? fullname = myServices.sharedPreferences.getString('full name');
    String? name = myServices.sharedPreferences.getString('user name');
    print(fullname);
    print(name);
  }
  // int getQuizNum() {
  //   return quiznum.value;
  // }
  // int? getQuizId() {
  //   return quizid.value;
  // }



  @override
  getCourseDetails() async {
    try {
      String? token = myServices.sharedPreferences.getString('access_token');
      Uri url = Uri.parse(AppUrl.quiz);
      var response = await http.get(url, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      print('tooooken $token');

      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonData = jsonDecode(response.body);
        course = Course.fromJson(jsonData['course']);
      if (response.statusCode == 200 || response.statusCode == 201) {
        jsonData = jsonDecode(response.body);
        course = Course.fromJson(jsonData['course']);
        update();
        print(response.body);
        print('Quizzes: ${jsonData}');

      } else {
        print(response.body);
        print('Error status coooooode ${response.statusCode}');
      }
    } 
  }
  catch (e) {
      print('Exception: $e');
    }}

  @override
  fetchQuiz(int quizIndex) async {
    // Clear previous quiz data
    quizControllerImp.clearState();

    quiznum.value = quizIndex + 1; // Adjusting to 1-based index
    quizzes = Quizzes.fromJson(jsonData['course']['quizzes'][quizIndex]);
    quizControllerImp.setQuizNum(quiznum.value); // Ensure this is set correctly
    quizControllerImp.setQuizId(quizzes?.id);
    quizid.value=quizzes?.id ?? 0;
     print('QuizNummmmmm from Fetchhhhhhhhhhhhhhh ${quiznum.value}');
     print('Quiziddddddd from Fetchhhhhhhhhhhhhhh ${quizid.value}');
    update();

    print('Quizzes: ${jsonData}');
    print('Quiz Index: $quiznum');
    print(quizzes?.timer);
  }

  // void putQuizNum(int quizIndex) {
  //   print('putQuizNum $quizIndex');
  //   quizControllerImp.setQuizNum(quizIndex + 1); // Adjusting to 1-based index
  // }

  // void putQuizId(int? quizId) {
  //   quizControllerImp.setQuizId(quizId);
  // }

  // @override
  // onSubmit() async {
  //   print('from onSubmit');
  //   await quizControllerImp.postQuiz();
  // }
}