import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/Quiz/quiz_controller.dart';
import 'package:learning_managment_system/controller/Quiz/quiz_videos_controller.dart';
import 'package:learning_managment_system/core/class/handlinigdataview.dart';
import 'package:learning_managment_system/core/class/statusrequest.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/functions/alertexit.dart';
import 'package:learning_managment_system/view/screen/CourseDetails/courseDetails.dart';
import 'package:learning_managment_system/view/screen/quiz/quizzes_videos.dart';
import 'package:learning_managment_system/view/widget/Quiz/quest.dart';
import 'package:learning_managment_system/view/widget/custom_widget/custom_button.dart';

class QuizPage extends StatelessWidget {
  QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    QuizVideosControllerImp controllerImp = Get.put(QuizVideosControllerImp());
    QuizControllerImp quizControllerImp = Get.put(QuizControllerImp());
   // RxBool timer=true.obs;
    //WidgetsBinding.instance.addPostFrameCallback((_) {});
    return WillPopScope(
      onWillPop: alertExitFromQuiz,
      child: Scaffold(
        body: Obx(() {
          // WidgetsBinding.instance.addPostFrameCallback((_) {});
          if (controllerImp.quizzes == null) {
            return Center(child: CircularProgressIndicator());
          }
          return HandinigDataRequest(statusRequest: quizControllerImp.statusRequest.value, widget: 
          Stack(
            children: [
              NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      shadowColor: AppColor.lightGreyColor,
                      forceElevated: true,
                      title: const Text(
                        'Quiz',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                          color: AppColor.primaryColor,
                        ),
                      ),
                      centerTitle: true,
                      expandedHeight: 70,
                      leading: const Text(''),
                    ),
                  ];
                },
                body: ListView.builder(
                  itemCount: (controllerImp.quizzes?.questions?.length ?? 0) + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == controllerImp.quizzes?.questions?.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                        child:quizControllerImp.seeCorrectAnswers.value ? 
                         CustomButton(
                          textButton: quizControllerImp.seeCorrectAnswers.value ? 'Go Home' : 'Submit',
                          onTap: () async {
                            quizControllerImp.clearState();
                            await controllerImp.getCourseDetails(quizControllerImp.quizId!); 
                            print('CourseDetailsPage ${quizControllerImp.quizId!}');
                            Get.back();
                            Get.back();
   //                         Get.back();
                           Get.off(() => (QuizVideos()));
                            // Get.back();
                            // Get.back();
                            // quizControllerImp.clearState();
                         //   Get.back();//Get.offAllNamed(AppRoute.navbar);
                          },
                        )
                        : CustomButton(
                          textButton:'Submit',
                          onTap: () async {        
                            await quizControllerImp.postQuiz();
                            // if(quizControllerImp.statusRequest.value!=StatusRequest.offlineFailure)
                            // {timer.value=false;}
                            //  timer.value=false;
                          },
                        )
                      );
                    } else {
                    var question = controllerImp.quizzes?.questions?[index]; 
                      return Question(
                        question: question?.questionText ?? 'No question',
                        answer1: question?.choices?[0].choiceText ?? 'No answer',
                        answer2: question?.choices?[1].choiceText ?? 'No answer',
                        answer3: question?.choices?[2].choiceText ?? 'No answer',
                        answer4: question?.choices?[3].choiceText ?? 'No answer',
                        questionIndex: index,
                        questionid: question?.id ?? 0,
                        answer1id: question?.choices?[0].id ?? 0,
                        answer2id: question?.choices?[1].id ?? 0,
                        answer3id: question?.choices?[2].id ?? 0,
                        answer4id: question?.choices?[3].id ?? 0,
                        isCorrect1: question?.choices?[0].isCorrect ?? 0,
                        isCorrect2: question?.choices?[1].isCorrect ?? 0,
                        isCorrect3: question?.choices?[2].isCorrect ?? 0,
                        isCorrect4: question?.choices?[3].isCorrect ?? 0,
                      );
                    }
                  },
                ),
              ),
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: quizControllerImp.seeCorrectAnswers.value  
                //|| timer.value==false
                    ? Text('')
                    : Container(
                        width: Get.width / 3,
                        height: Get.width / 3,
                        child: CircularCountDownTimer(
                          duration: controllerImp.quizzes?.timer ?? 0,
                          controller: CountDownController(),
                          width: Get.width / 3,
                          height: Get.width / 3,
                          ringColor: AppColor.lightGreyColor!,
                          fillColor: AppColor.violetColor,
                          backgroundColor: AppColor.primaryColor,
                          strokeWidth: 7.0,
                          strokeCap: StrokeCap.round,
                          textStyle: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                          textFormat: CountdownTextFormat.MM_SS,
                          isReverse: true,
                          isReverseAnimation: false,
                          isTimerTextShown: true,
                          autoStart: true,
                          onStart: () {
                            print('Countdown Started');
                          },
                          onComplete: () {
                            Get.defaultDialog(
                                barrierDismissible: false,
                                title: 'Time is over',
                                content: const Text('We hope you completed the quiz', textAlign: TextAlign.center, style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400, color: AppColor.violetColor)),
                                confirm: MaterialButton(
                                  onPressed: () async {
                                    Get.back();
                                    await quizControllerImp.postQuiz();
                                  },child: const Text(
                                    'Submit',
                                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600, color: AppColor.primaryColor),
                                  ),
                                ),
                                titleStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: AppColor.primaryColor));

                            print('Countdown Ended');
                          },
                          onChange: (String timeStamp) {
                            print('Countdown Changed $timeStamp');
                          },
                          timeFormatterFunction: (defaultFormatterFunction, duration) {
                            if (duration.inSeconds == 0) {
                              return "THE END";
                            } else {
                              return Function.apply(defaultFormatterFunction, [duration]);
                            }
                          },
                        ),
                      ),
              ),
            ],
          ));
        }),
      ),
    );
  }
}