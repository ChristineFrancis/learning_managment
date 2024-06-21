import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/Quiz/quiz_page_controller.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/functions/alertexit.dart';
import 'package:learning_managment_system/view/widget/Quiz/question.dart';
import 'package:learning_managment_system/view/widget/custom_widget/custom_button.dart';

class QuizPage extends StatelessWidget {
  QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    QuizPageControllerImp controllerImp = Get.put(QuizPageControllerImp());
    return WillPopScope(
      onWillPop: alertExitFromQuiz,
      child: Scaffold(
        body: GetBuilder<QuizPageControllerImp>(
          builder: (controller) {
            
            if (controller.quizzes == null) {
              return Center(child: CircularProgressIndicator());
            }

            return Stack(
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
                    itemCount: (controllerImp.quizzes?.questions?.length ?? 0) + 1, // Add 1 for the button
                    itemBuilder: (BuildContext context, int index) {
                      if (index == controllerImp.quizzes?.questions?.length) {
                        // This is the last item, so return the button
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                          child: CustomButton(
                            textButton: 'Submit',
                            onTap: () {
                              // Handle submit button press
                            },
                          ),
                        );
                      } else {
                        var question = controllerImp.quizzes?.questions?[index];
                        return CustomQuestion(
                          question: question?.questionText ?? 'No question',
                          answer1: question?.choices?[0].choiceText ?? 'No answer',
                          answer2: question?.choices?[1].choiceText ?? 'No answer',
                          answer3: question?.choices?[2].choiceText ?? 'No answer',
                          answer4: question?.choices?[3].choiceText ?? 'No answer',
                          questionIndex: index,
                          questionid: question?.id,
                          answer1id: question?.choices?[0].id,
                          answer2id: question?.choices?[1].id,
                          answer3id: question?.choices?[2].id,
                          answer4id: question?.choices?[3].id,
                          
                        );
                      }
                    },
                  ),
                ),
                Positioned(
                  bottom: 16.0,
                  right: 16.0,
                  child: Container(
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
                          content:  const Text('We hope you copmleted the quiz' , textAlign: TextAlign.center,style:  TextStyle(fontSize:25, fontWeight: FontWeight.w400 , color: AppColor.violetColor)),
                          confirm: MaterialButton(
                            onPressed: (){},
                           child: const Text('Submit' , style: TextStyle(fontSize: 26 , fontWeight: FontWeight.w600 , color: AppColor.primaryColor),),),
                           titleStyle: const TextStyle(fontSize: 30 , fontWeight: FontWeight.w600 , color: AppColor.primaryColor));
                          
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
            );
          },
        ),
      ),
    );
  }
}

