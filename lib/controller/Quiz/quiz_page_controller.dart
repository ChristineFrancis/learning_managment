import 'dart:convert';

import 'package:get/get.dart';
//import 'package:get/get_connect/http/src/response/response.dart' as http;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:learning_managment_system/core/constant/url.dart';
import 'package:learning_managment_system/model/course_details/quiz_model.dart';
import 'package:learning_managment_system/services/services.dart';


abstract class QuizPageController extends GetxController {
  fetchQuiz(int quizIndex);
  getCourseDetails();
 
}

class QuizPageControllerImp extends QuizPageController {
  MyServices myServices = Get.find();
  Quizzes? quizzes;
  Course? course;
  var jsonData;
  List videos=['1', '2','3', '4','5' ];
  int quiznum=0;
  @override
  void onInit() async {
    super.onInit();
   await getCourseDetails();

   String? fullname=myServices.sharedPreferences.getString('full name');
   String? name=myServices.sharedPreferences.getString('user name');
              print(fullname);
              print(name);
    //await fetchQuiz();
  }

  @override
  getCourseDetails() async{
    try {
      String? token = myServices.sharedPreferences.getString('access_token');
       print(token);
      Uri url = Uri.parse(AppUrl.quiz);
      var response = await http.get(url,
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });

      if (response.statusCode == 200 || response.statusCode == 201 ) {
         jsonData = jsonDecode(response.body);
         course=Course.fromJson(jsonData['course']);
        update();
         print('Quizzeeeeeeeeeees : ${jsonData}');
         print(jsonData['course']);
         print(course?.quizzes?[0].quizName);
         print(course?.quizzes?[1].quizName);
        } else {
        print('Error status code ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  @override
  fetchQuiz(int quizIndex) async {
        quiznum=quizIndex;
        quizzes = Quizzes.fromJson(jsonData['course']['quizzes'][quizIndex]);
        update(); // Update the controller's state
       
        print('Quizzeeeeeeeeeees : ${jsonData}');
        print('QuizINdex : $quiznum');
        print(quizzes?.timer); 
        print(jsonData['course']['quizzes'][quizIndex]);
  
  }
  
  
}
