import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/Quiz/quiz_controller.dart';
import 'package:learning_managment_system/controller/Quiz/quiz_videos_controller.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/view/screen/CourseDetails/video.dart';
import 'package:learning_managment_system/view/screen/quiz/before_quiz.dart';

class QuizVideos extends StatelessWidget {
  QuizVideos({super.key});

  @override
  Widget build(BuildContext context) {
    QuizVideosControllerImp controller = Get.put(QuizVideosControllerImp());
    QuizControllerImp quizControllerImp = Get.put(QuizControllerImp());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back , color: AppColor.whiteColor , size: 35,) , 
        onPressed: () {
          Get.back();
        },),
        title: Text(controller.course!.name!),
        titleTextStyle: TextStyle(fontSize: 35 , fontWeight: FontWeight.w500),
        backgroundColor: AppColor.primaryColor,),
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
                  itemCount: controller.course!.quizzes!.length + controller.course!.videos!.length,
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
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 20 , horizontal: 6),
                        padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 112, 116, 250)
                                .withOpacity(0.5)
                                .withOpacity(0.9),

                            spreadRadius: 5,
                            blurRadius: 6,
                            blurStyle: BlurStyle.outer,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white.withOpacity(0.5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Quiz $quizNum',
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w600)),
                          Icon(Icons.quiz_outlined ,
                               color: AppColor.primaryColor,
                              size: 35,)
                      ],
                    ),
                  )
                      );
                    } else {
                      int currentVideosNum =videosNum;
                      videosNum++;
                      return MaterialButton(
                        onPressed: () async {
                           Get.to(VideoPage(
                            url:controller.course!.videos![currentVideosNum].name!,
                             description: controller.course!.videos![currentVideosNum].description!,
                            ) );


                        },
                        child:Container(
                          margin: EdgeInsets.symmetric(vertical: 20 , horizontal: 6),
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 112, 116, 250)
                                .withOpacity(0.5)
                                .withOpacity(0.9),

                            spreadRadius: 5,
                            blurRadius: 6,
                            blurStyle: BlurStyle.outer,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white.withOpacity(0.5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Video $videosNum',
                            style: const TextStyle(
                               fontSize: 30, fontWeight: FontWeight.w600)),
                          Icon(Icons.video_collection_outlined,
                              color: AppColor.primaryColor,
                            size: 35,)
                      ],
                    ),
                  )
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