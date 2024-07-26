// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:learning_managment_system/controller/Quiz/quiz_controller.dart';
// import 'package:learning_managment_system/core/constant/color.dart';

// class CustomQuestion extends StatelessWidget {
//   final String question;
//   final String answer1;
//   final String answer2;
//   final String answer3;
//   final String answer4;
//   final int questionIndex;
//   final int? questionid;
//   final int? answer1id;
//   final int? answer2id;
//   final int? answer3id;
//   final int? answer4id;

//   CustomQuestion({
//     super.key,
//     required this.question,
//     required this.answer1,
//     required this.answer2,
//     required this.answer3,
//     required this.answer4,
//     required this.questionIndex, required this.questionid, required this.answer1id, required this.answer2id, required this.answer3id, required this.answer4id,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Get.put(QuizControllerImp());
//     return GetBuilder<QuizControllerImp>(builder: (controller) {
//       String? groupValue = controller.getSelectedValue(questionIndex);
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal:  20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Text((questionIndex+1).toString() , style: const TextStyle(fontSize: 20 , color: AppColor.primaryColor),),
//                 const Text('-', style: TextStyle(fontSize: 20 , color: AppColor.primaryColor),),
//                 const SizedBox(width: 6,),
//                 Text(question , style: const TextStyle(fontSize: 20 ),),
//               ],
//             ),
        
//             CustomAnswer(answer: answer1,groupValue: groupValue , questionIndex: questionIndex,),
//             CustomAnswer(answer: answer2,groupValue: groupValue , questionIndex: questionIndex,),
//             CustomAnswer(answer: answer3,groupValue: groupValue , questionIndex: questionIndex,),
//             CustomAnswer(answer: answer4,groupValue: groupValue , questionIndex: questionIndex,),
//             const Divider(color: AppColor.violetColor,thickness: 4,),
//             const SizedBox(height: 20),
//           ],
//         ),
//       );
//     });
//   }
// }
// class CustomAnswer extends StatelessWidget {
//   final String answer;
//   final String? groupValue;
//   final int questionIndex;
//   const CustomAnswer({super.key, required this.answer, required this.groupValue, required this.questionIndex});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<QuizControllerImp>(builder: (controller) =>
//      RadioListTile(
//             activeColor: AppColor.primaryColor,
//             title: Text(answer),
//             value: answer,
//             groupValue: groupValue,
//             onChanged: (val) {
//               controller.onValChanged(questionIndex, val);
//             },
//           )
//            )
//            ;
//   }
// }
