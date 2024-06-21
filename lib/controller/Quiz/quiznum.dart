import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:learning_managment_system/controller/Quiz/quiz_page_controller.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/view/screen/quiz/before_quiz.dart';

class Quiznum extends StatelessWidget {
  const Quiznum({super.key});

  @override
  Widget build(BuildContext context) {
    QuizPageControllerImp controllerImp = Get.put(QuizPageControllerImp());
    return  Scaffold(
       body: GetBuilder<QuizPageControllerImp>(
          builder: (controller) {
            
            if (controller.course == null) {
              return Center(child: CircularProgressIndicator());
            }

            return Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controllerImp.course?.quizzes?.length ?? 0,
                    itemBuilder: (BuildContext context, int index)
                     { return
                      MaterialButton(
                        onPressed: () async{ await controllerImp.fetchQuiz(index);
                        Get.to(BeforeQuizPage());},
                        child: Text(controller.course?.quizzes?[index].id != null
                          ? 'Quiz ${controller.course?.quizzes?[index].id}'
                          : 'no quiz',
                        style: TextStyle(color: AppColor.primaryColor , fontSize: 30),),);
                      },),
                ),
              ],
            );
            })
    );
  }
}