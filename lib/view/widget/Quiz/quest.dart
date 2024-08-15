import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:learning_managment_system/controller/Quiz/quiz_controller.dart';
import 'package:learning_managment_system/controller/Quiz/quiz_videos_controller.dart';
import 'package:learning_managment_system/core/constant/color.dart';

class Question extends StatelessWidget {
  final String question;
  final String answer1;
  final String answer2;
  final String answer3;
  final String answer4;
  final int questionIndex;
  final int questionid;
  final int answer1id;
  final int answer2id;
  final int answer3id;
  final int answer4id;
  final int isCorrect1;
  final int isCorrect2;
  final int isCorrect3;
  final int isCorrect4;

  Question({ required this.question, required this.answer1, required this.answer2, required this.answer3, required this.answer4, 
  required this.questionIndex, required this.questionid, required this.answer1id, required this.answer2id, required this.answer3id, required this.answer4id,
   required this.isCorrect1, required this.isCorrect2, required this.isCorrect3, required this.isCorrect4, 
   });

  @override
  Widget build(BuildContext context) {
   final QuizControllerImp controllerImp= Get.put(QuizControllerImp());
      controllerImp.addGroupValue();
    int  questionNumber=questionIndex+1;
    return 
       GetBuilder<QuizControllerImp>(
          builder: (controller) => 
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
                children: [
                   Row(
                children: [
                  Text((questionNumber).toString() , style: const TextStyle(fontSize: 28 ,fontWeight: FontWeight.w500,color: AppColor.primaryColor),),
                  const Text('-', style: TextStyle(fontSize: 23 ,fontWeight: FontWeight.w500, color: AppColor.primaryColor),),
                  const SizedBox(width: 6,),
                  Expanded(child: Text(question , style: const TextStyle(fontSize: 25 , fontWeight: FontWeight.w600),)),
                ],
              ),
                  Answer(text: answer1, value: answer1id, groupvalue: questionIndex, questionid: questionid, isCorrect: isCorrect1,),
                  Answer(text: answer2, value: answer2id, groupvalue: questionIndex , questionid: questionid , isCorrect: isCorrect2,),
                  Answer(text: answer3, value: answer3id,groupvalue: questionIndex , questionid: questionid , isCorrect: isCorrect3,),
                  Answer(text: answer4, value: answer4id,groupvalue: questionIndex , questionid: questionid , isCorrect: isCorrect4,),
                  const Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20),
                    child:  Divider(color: AppColor.violetColor,thickness: 5,),
                  ),
            const SizedBox(height: 20),
          //  MaterialButton(onPressed: ()async{print('from kk'); await controllerImp.postQuiz();} , child: Text('kk'),)
                ],
              ),
           )  
      ) ;
  }
}
class Answer extends StatelessWidget {
  final String text;
  final int value;
  final int groupvalue;
  final int questionid;
  final int isCorrect;

   Answer({super.key, required this.text, required this.value, required this.groupvalue, required this.questionid, required this.isCorrect });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizControllerImp>(
          builder: (controller) =>
    RadioListTile(
      tileColor:isCorrect==1 && controller.seeCorrectAnswers.value ? AppColor.greenColor : Colors.white ,
      activeColor: AppColor.primaryColor,
      title:Text(text) ,
      value:value , 
      groupValue: controller.groupValuelist[groupvalue], 
      onChanged: (val){
     controller.groupValuelist[groupvalue]=val;
     controller.addAnswerToListOfMaps(groupvalue, questionid, val);
     controller.update();
                }));
  }
}