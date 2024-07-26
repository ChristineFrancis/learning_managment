import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/imageasset.dart';
import 'package:learning_managment_system/view/screen/aboutUs/contactUs.dart';
import 'package:learning_managment_system/view/widget/aboutUs/customAboutUs.dart';
import 'package:learning_managment_system/view/widget/custom_widget/custom_button.dart';

class AboutUsPage extends StatelessWidget {
  
   AboutUsPage({super.key});
  @override
  Widget build(BuildContext context) {
  return Scaffold (
    appBar: AppBar(
     centerTitle: true,
     elevation: 5,
     leading: IconButton(
      onPressed: () { Get.back();},
      icon: const Icon(Icons.arrow_back),),
     title:const Text('About Us' ,
     textAlign:TextAlign.start,
     style: TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.w700,
      color: AppColor.primaryColor,),),
       ),
     body: SingleChildScrollView(
     padding: const EdgeInsets.symmetric(horizontal: 4 , vertical: 5),
     child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
       const Padding(
         padding: EdgeInsets.symmetric(vertical:10),
         child: Row(
          children: [
           Padding(
            padding: EdgeInsets.only(right: 2 , left: 1),
            child: Icon(Icons.games_outlined , color: AppColor.primaryColor,size:30,)),
           Text(
            'Why Choose Fekra App?' ,
            textAlign:TextAlign.center,
            style: TextStyle(
             fontSize: 25,
             fontWeight: FontWeight.w600, ),),
                ]),
             ),
        const CustomAboutUs(
          title:'Interactive Learning:',
          sentence:' Engage with interactive elements, quizzes, and assignments to solidify your understanding.' ,),
        Row(
        children: [
         const Expanded(
          child: Column(
           children: [
            CustomAboutUs(
              title: 'Unleash Your Curiosity:',
              sentence:'Explore thousands of courses on a wide range of topics.' ,),
            CustomAboutUs(
              title: 'Learning on the Go:',
              sentence:'learn at your own pace, anytime, anywhere.' ,),
                  ],
                ),
              ),
             Image.asset(ImageAsset.aboutUs , width: Get.size.width/2.1,),
                            ],
                          ),
            const CustomAboutUs(title:'Interactive Learning:',
                      sentence:' Engage with interactive elements, quizzes, and assignments to solidify your understanding.' ,),
          Row(
            children: [
              Image.asset(ImageAsset.aboutUs22 , width: Get.size.width/2,),
              const Expanded(
                child: Column(
                  children: [
                    CustomAboutUs(title: 'Track Your Progress:',
                    sentence:"Monitor your learning journey and celebrate your achievements with clear progress tracking." ,),
                  ],),
              ), 
              ],),
          const SizedBox(height: 20,),
          const Text(
            "Have questions or feedback? We'd love to hear from you!" ,
             textAlign:TextAlign.center,
             style: TextStyle(
             fontSize: 20,
             fontWeight: FontWeight.w600,),),
           Padding(
            padding:  EdgeInsets.symmetric(horizontal: Get.width/4 , vertical: 15),
            child: CustomButton(
              textButton: "Contact Us",
              onTap: (){Get.to(ContactUs() ,transition:Transition.circularReveal, duration: const Duration(seconds:2)  );}),
                )
          ],
        ),
      ),
    );
  }
}
