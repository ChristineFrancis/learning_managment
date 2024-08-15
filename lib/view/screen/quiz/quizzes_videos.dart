import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/Quiz/quiz_controller.dart';
import 'package:learning_managment_system/controller/Quiz/quiz_videos_controller.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/services/services.dart';
import 'package:learning_managment_system/view/screen/CourseDetails/video.dart';
import 'package:learning_managment_system/view/screen/quiz/before_quiz.dart';

class QuizVideos extends StatelessWidget {
  QuizVideos({super.key});

  @override
  Widget build(BuildContext context) {
    QuizVideosControllerImp controller = Get.put(QuizVideosControllerImp());
    QuizControllerImp quizControllerImp = Get.put(QuizControllerImp());
     MyServices myServices = Get.find();
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
                          if (controller.cantGoToQuizPage(controller.course!.quizzes![currentQuizNum].id!))
                          {
                            int? preGrade = myServices.sharedPreferences.getInt(controller.course!.quizzes![currentQuizNum].id.toString());
                          String? name=myServices.sharedPreferences.getString('user name');
                          Get.defaultDialog(
                         title:'$name,you have already passsed the quiz😄',
                          content: Text('Your grade is $preGrade %',
                          style:TextStyle( fontSize: 18) ,),
                          titleStyle: const TextStyle(color: AppColor.primaryColor, fontSize: 20),
                          );
                          
                        }
                        else{
                          await controller.fetchQuiz(currentQuizNum);
                          quizControllerImp.setQuizNum(currentQuizNum);
                          quizControllerImp.setQuizId(controller.course!.quizzes![currentQuizNum].id);
                          Get.to(() => BeforeQuizPage())!.then((_) {
                            quizControllerImp.clearState();
                          }
                          );
                          
                        }
                        },
                        child:CustomQuizVideos(text:'Quiz $quizNum' ,icon:Icons.quiz_outlined ,),
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
                        child:CustomQuizVideos(text:'Video $videosNum' ,icon:Icons.video_collection_outlined ,)
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
class CustomQuizVideos extends StatelessWidget {
  final String text;
  final IconData icon;
  const CustomQuizVideos({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        Text(text,
                            style: const TextStyle(
                               fontSize: 30, fontWeight: FontWeight.w600)),
                          Icon(icon,
                              color: AppColor.primaryColor,
                            size: 35,)
                      ],
                    ),
                  );
  }
}