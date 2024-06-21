import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/imageasset.dart';
import 'package:learning_managment_system/services/services.dart';
import 'package:learning_managment_system/view/screen/quiz/quiz.dart';
import 'package:learning_managment_system/view/widget/custom_widget/custom_button.dart';
import 'package:lottie/lottie.dart';

class BeforeQuizPage extends StatelessWidget {
   BeforeQuizPage({super.key});
    
    
  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find();
    String? name=myServices.sharedPreferences.getString('user name');
    return  Scaffold(
   body:  Column(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child:Text( "$name,\nAre you ready????" ,textAlign: TextAlign.center,
                style: TextStyle( color: AppColor.primaryColor , fontSize: 35 , fontWeight: FontWeight.w700 ,),)),
            ),
            // const Text('Note:' ,
            //  style: TextStyle( color: AppColor.violetColor , fontSize: 35 , fontWeight: FontWeight.w700 ,),),
            //  const Text( "There is a timer will start as soon as " ,textAlign: TextAlign.center,
            //     style: TextStyle( color: AppColor.primaryColor , fontSize: 35 , fontWeight: FontWeight.w700 ,),),
            LottieBuilder.asset(ImageAsset.brforeQuizLottie2 , width: 200 ),
               Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child:Text( "It's a quiz time" ,textAlign: TextAlign.center,
                style: TextStyle( color: AppColor.primaryColor , fontSize: 35 , fontWeight: FontWeight.w700 ,),)),
            ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: CustomButton(textButton: "Let's start", onTap: (){Get.to(QuizPage());}),
              ),
               
              
          ],
        ),
    );
  }
}