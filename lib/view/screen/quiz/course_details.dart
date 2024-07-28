import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/Quiz/quiz_controller.dart';
import 'package:learning_managment_system/controller/Quiz/quiz_videos_controller.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/view/screen/quiz/before_quiz.dart';

class CourseDetails extends StatelessWidget {
  CourseDetails({super.key});

  @override
  Widget build(BuildContext context) {
    QuizVideosControllerImp controller = Get.put(QuizVideosControllerImp());
    QuizControllerImp quizControllerImp = Get.put(QuizControllerImp());
    return Scaffold(
      body: GetBuilder<QuizVideosControllerImp>(
        builder: (controller) {
          if (controller.course == null) {
            return Center(child: CircularProgressIndicator());
          }

          int quizNum = 0;
          int videosNum = 0;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.course!.quizzes!.length + controller.videos.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (quizNum < controller.course!.quizzes!.length &&
                        controller.course!.quizzes![quizNum].afterVideo == videosNum) {
                      int currentQuizNum = quizNum;
                      quizNum++;

                      return MaterialButton(
                        onPressed: () async {
                          await controller.fetchQuiz(currentQuizNum);
                          quizControllerImp.setQuizNum(currentQuizNum);
                          quizControllerImp.setQuizId(controller.course!.quizzes![currentQuizNum].id);
                          Get.to(() => BeforeQuizPage())!.then((_) {
                            quizControllerImp.clearState();
                          });
                        },
                        child: Text(
                          'Quiz',
                          style: TextStyle(color: AppColor.primaryColor, fontSize: 30),
                        ),
                      );
                    } else {
                      videosNum++;
                      return Text(
                        'Video ${videosNum}',
                        style: TextStyle(fontSize: 30),
                      );
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}