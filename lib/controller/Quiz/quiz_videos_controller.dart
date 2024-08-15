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
import 'package:learning_managment_system/data/datasource/remote/enrollCourse/enrollCourseData.dart';
import 'package:learning_managment_system/model/course_details/courseDetails_model.dart';
import 'package:learning_managment_system/services/services.dart';
import 'package:http/http.dart' as http;

abstract class QuizVideosController extends GetxController {
  fetchQuiz(int quizIndex);
  getCourseDetails(int courseId);
  enroll(int courseId);
  unEnroll(int courseId);
}

class QuizVideosControllerImp extends QuizVideosController {
  static QuizControllerImp quizControllerImp = Get.put(QuizControllerImp());
  EnrollCourseData enrollCourseData = EnrollCourseData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest=StatusRequest.none;
  bool seeContent=false;
  Quizzes? quizzes;
  Course? course;
  Teacher? teacher;
  var jsonData;
  bool enrollCourse=false;
  RxInt quiznum = 0.obs;
  RxInt quizid = 0.obs;

  @override
  void onInit() async {
    print('cooooorse details');
    super.onInit();
    String? name = myServices.sharedPreferences.getString('user name');
    print('seeeeeeeeee content  $seeContent');
    print(name);
  }
  
  @override
  getCourseDetails(int courseId) async {
    // try {
      String? token = myServices.sharedPreferences.getString('access_token');
      String url='${AppUrl.quiz}/$courseId';
      print('course deeeeeeeetails url $url  ');
      //Uri url = Uri.parse(AppUrl.quiz);
      var response = await http.get(Uri.parse(url), headers: {
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
        teacher=Teacher.fromJson(jsonData['course']['teacher']);
        update();
        print(response.body);
        print('Quizzes: ${jsonData}');

      } else {
        print(response.body);
        print('Error status coooooode ${response.statusCode}');
      }
    } 
  }
  // catch (e) {
  //     print('Exception getCourseDetails: $e');
  //   }}

  @override
  fetchQuiz(int quizIndex) async {
   quizControllerImp.clearState();
    quiznum.value = quizIndex + 1; 
    quizzes = Quizzes.fromJson(jsonData['course']['quizzes'][quizIndex]);
    quizControllerImp.setQuizNum(quiznum.value); 
    quizControllerImp.setQuizId(quizzes?.id);
    quizid.value=quizzes?.id ?? 0;
     print('QuizNummmmmm from Fetchhhhhhhhhhhhhhh ${quiznum.value}');
     print('Quiziddddddd from Fetchhhhhhhhhhhhhhh ${quizid.value}');
    update();

    print('Quizzes: ${jsonData}');
    print('Quiz Index: $quiznum');
   
  }
  @override
  bool cantGoToQuizPage(int quizIndex)
  {
    int? preGrade = myServices.sharedPreferences.getInt(quizIndex.toString());
    if(preGrade!=null && preGrade>60)
    return true;
    else
    return false;
    
  }

  // fectchVideo(int videoIndex)async
  // {
  //    videos=Videos.fromJson(jsonData['course']['videos'][videoIndex]);

  // }


  
  @override
  enroll(int courseId)async {
    statusRequest = StatusRequest.loading;
     print('seeeeeeeeee content before $seeContent');
    seeContent=true;
      update();
      print('seeeeeeeeee content enroll $seeContent');

      try {
    String? token = myServices.sharedPreferences.getString('access_token');
     var response = await enrollCourseData.enroll(courseId, token);
         statusRequest = handlingData(response);
        if (statusRequest == StatusRequest.success) 
        {
          if (response['message'] == "You've enrolled in this course successfully.")
          { getCourseDetails(courseId);
             Get.defaultDialog(title:response['message'] , content: Text('') , titleStyle: const TextStyle(color: AppColor.primaryColor, fontSize: 20 ) );
          }
          else
          {
            Get.defaultDialog(title:response['message'] , content: Text('') , titleStyle: const TextStyle(color: AppColor.primaryColor, fontSize: 20 ) );

          }
        }
      }
      catch(e){print('eroooooor enroll course $e');}
      update();
    
  }
  
  @override
  unEnroll(int courseId) async{
    String? token = myServices.sharedPreferences.getString('access_token');
    Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': token != null ? 'Bearer $token' : '',
        'Content-Type': 'application/json',};
    String url='${AppUrl.quiz}/$courseId';
    try{
    var response = await http.delete(Uri.parse(url) , headers: headers);
    Map responseBody = jsonDecode(response.body);
    print('deleeeeeeeeeeeete coooooooures $responseBody');
    print('deleeeeeeeeeeeete coooooooures ${response.statusCode}');
    if(response.statusCode==200)
    { getCourseDetails(courseId);
      Get.defaultDialog(title:responseBody['message'] , content: Text('') , titleStyle: const TextStyle(color: AppColor.primaryColor, fontSize: 20 ) );

    }
    else
    {
      Get.defaultDialog(title:responseBody['message'] , content: Text('') , titleStyle: const TextStyle(color: AppColor.primaryColor, fontSize: 20 ) );
    }
    }catch(e)
    { print('eroooooor delete course $e');}
    update();
  }
}