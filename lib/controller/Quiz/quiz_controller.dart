import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/Quiz/quiz_videos_controller.dart';
import 'package:learning_managment_system/core/class/statusrequest.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/routes.dart';
import 'package:learning_managment_system/core/constant/url.dart';
import 'package:learning_managment_system/core/functions/handlingdata.dart';
import 'package:learning_managment_system/data/datasource/remote/quiz/send_answer_quizdata.dart';
import 'package:learning_managment_system/model/course_details/quiz_model.dart';
import 'package:learning_managment_system/services/services.dart';

abstract class QuizController extends GetxController {
  postQuiz();
  addGroupValue();
 // addSelectedValue(int questionIndex, int? value);
}

class QuizControllerImp extends QuizController {
  static QuizPageControllerImp quizPageControllerImp = Get.put(QuizPageControllerImp());
  SendAnswersQuizData sendAnswersQuizData = SendAnswersQuizData(Get.find());
  MyServices myServices = Get.find();
  Rx<StatusRequest> statusRequest = StatusRequest.none.obs;
  

  final RxList<int?> groupValuelist = <int?>[].obs;
  final RxList<int?> numOfAnswerslist = <int?>[].obs;
  List<Map<String, int>> answersList = <Map<String, int>>[].obs;
  int quiznum = 0;
  int? quizId;
  RxBool seeCorrectAnswers=false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  // @override
  // void onClose() {
  //   clearState();
  //   super.onClose();
  // }

 

  void setQuizNum(int quizIndex) {
    quiznum = quizIndex+1;
    update();
    print('getQuizNummmmmmmmmmmmmm $quiznum');
  }

  void setQuizId(int? quizzId) {
    quizId = quizzId;
    print('QuizzzzzzzzzIddddddddd $quizId');
  }

  void addAnswerToListOfMaps(int index, int questionId, int? chosenChoiceId) {
    if (chosenChoiceId != null) {
      Map<String, int> answer = {
        "question_id": questionId,
        "chosen_choice_id": chosenChoiceId,
      };
      if (index < answersList.length) {
        answersList[index] = answer;
      } else {
        answersList.add(answer);
        update();
      }
      print('begin');
      answersList.forEach((element) {
        print(element);
      });
      print('end');
    }
  }

  void getFinalListOfMaps() {
    answersList.removeWhere((element) => element.isEmpty);
    print('begin all');
    answersList.forEach((element) {
      print(element);
    });
    print('end all');
  }

  @override
  addGroupValue() {
    int? q;
    groupValuelist.add(q);
    numOfAnswerslist.add(q);
    answersList.add({});
  }

//   @override
//   postQuiz() async {
//     try {
//       getFinalListOfMaps();
//       if (answersList.isEmpty)
//       {
//          Get.defaultDialog(title: 'You should study harder😄', content: Text(''), titleStyle: const TextStyle(color: AppColor.primaryColor, fontSize: 25));
//          Future.delayed(const Duration(seconds: 2), () {
//           if (Get.isDialogOpen ?? false) {
//             Get.back();
//           }
//         });
//         Future.delayed(const Duration(seconds: 2), () {
//           Get.toNamed(AppRoute.navbar);
//         });
//       }
//       else{
//       String? token = myServices.sharedPreferences.getString('access_token');
//       var response = await sendAnswersQuizData.postAnswers(quizId, quiznum, answersList, token);
//       statusRequest = handlingData(response);
//       if (statusRequest == StatusRequest.success)
//        {
//         if (response['message'] == 'Congratiolations!')
//         {
//        // clearState();
//         Get.defaultDialog(title: 'Congratulations 🎉', content: Text( 'Your grade is : ${response['grade'].toString()}' , ), titleStyle: const TextStyle(color: AppColor.primaryColor, fontSize: 25),
//          confirm: MaterialButton(onPressed: (){ Get.back(); seeCorrectAnswers=true;update();} , child: Text('see'),));
//         }
//         else if (response['message'] == "This record is already exists.")
//         {
//          // clearState();
//         Get.defaultDialog(title: 'You passed the exam last time', content: const Text( ''), titleStyle: const TextStyle(color: AppColor.primaryColor, fontSize: 25),
//         confirm: MaterialButton(onPressed: (){seeCorrectAnswers=true;update();} , child: Text('see'),));
//         }
        
//         // Future.delayed(const Duration(seconds: 2), () {
//         //   if (Get.isDialogOpen ?? false) {
//         //     Get.back();
//         //   }
//         // });
//         // Future.delayed(const Duration(seconds: 2), () {
//         //   Get.offAllNamed(AppRoute.navbar);
//         // });
//       }
//        else { 
//  Get.defaultDialog(title: 'You passed the exam last time', content: const Text( ''), titleStyle: const TextStyle(color: AppColor.primaryColor, fontSize: 25),
//         confirm: MaterialButton(onPressed: (){Get.back(); seeCorrectAnswers=true;update();} , child: Text('see'),));
        
//         }

//         // Future.delayed(const Duration(seconds: 2), () {
//         //   if (Get.isDialogOpen ?? false) {
//         //     Get.back();
//         //   }
//         // });
//         // Future.delayed(const Duration(seconds: 2), () {
//         //   Get.offAllNamed(AppRoute.navbar);
//         // });

       


//     }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

@override
postQuiz() async {
  try {
    String? name=myServices.sharedPreferences.getString('user name');
    getFinalListOfMaps();
    if (answersList.isEmpty) {
      //You should study harder😄
      Get.defaultDialog(title: '$name,You should answer ', content: Text(''), titleStyle: const TextStyle(color: AppColor.primaryColor, fontSize: 25));
      // Future.delayed(const Duration(seconds: 2), () {
      //   if (Get.isDialogOpen ?? false) {
      //     Get.back();
      //   }
      // });
      // Future.delayed(const Duration(seconds: 2), () {
      //   Get.toNamed(AppRoute.navbar);
      // });
    } 
  else {
    String url;
      statusRequest = StatusRequest.loading.obs;
     update();
      String? token = myServices.sharedPreferences.getString('access_token');
      int? preGrade = myServices.sharedPreferences.getInt(quizId.toString());
      print('geeeeet graaaaade $preGrade');
      if(preGrade == null)
      { 
        url=AppUrl.sendQuiz;
        print('Not taken befooore');
      }
      else {
         url=AppUrl.sendQuiz;
         print(' taken befooore');
      }

      var response = await sendAnswersQuizData.postAnswers(url, quizId, quiznum, answersList, token);
      statusRequest.value = handlingData(response);
       print('meeeeesege first ${response}');
      if (statusRequest.value == StatusRequest.success) {
        if (response['message'] == "Congratiolations!") {
          myServices.sharedPreferences.setInt(quizId.toString(),response['grade'] );
          Get.defaultDialog(
            title: 'Congratulations 🎉 $name',
            content: Text('Your grade is : ${response['grade'].toString()} % '),
            titleStyle: const TextStyle(color: AppColor.primaryColor, fontSize: 25),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  onPressed: () 
               {
               Get.back();
                seeCorrectAnswers.value = true;
              }, child: Text('See correct answers', style: TextStyle(color: AppColor.grey),),),

              MaterialButton(
                  onPressed: () 
               {
              Get.offAllNamed(AppRoute.navbar);
              }, child: Text('Go home', style: TextStyle(color: AppColor.grey),),)

              ],
            )],
          );
        } 
         else if (response['message'] == "This record is already exists.")  {
        print('meeeeesege ${response['message']}');
       // statusRequest = StatusRequest.failure;
        Get.defaultDialog(
          title: '$name ,You have already passed the quiz 😄',
          
          titleStyle: const TextStyle(color: AppColor.primaryColor, fontSize: 20),
        
          content: 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  onPressed: () 
               {
               Get.back();
                seeCorrectAnswers.value = true;
              }, child: Text('See correct answers', style: TextStyle(color: AppColor.grey),),),

              MaterialButton(
                  onPressed: () 
               {
              Get.offAllNamed(AppRoute.navbar);
              }, child: Text('Go home', style: TextStyle(color: AppColor.grey),),)

              ],
            ),  
        );
        statusRequest.value = StatusRequest.failure;
      }

      } 
      
    }
  } catch (e) {

    //statusRequest = StatusRequest.failure;
    print('Error: $e');
  }
  update();
}


  void clearState() {
    groupValuelist.clear();
    numOfAnswerslist.clear();
    answersList.clear();
  }
}
