import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/imageasset.dart';
import 'package:learning_managment_system/view/screen/chatAi/chat.dart';
import 'package:learning_managment_system/view/widget/custom_widget/custom_button.dart';


class BeforeChatAi extends StatelessWidget {
  const BeforeChatAi({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child:Text( 'YOU CAN CHAT WITH \nGEMINI' ,textAlign: TextAlign.center,
                style: TextStyle( color: AppColor.primaryColor , fontSize: 35 , fontWeight: FontWeight.w700 ,),)),
            ),
            Image.asset(ImageAsset.robot5Image,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60 , vertical: 20),
                child: CustomButton(textButton: "Try it", onTap: (){Get.to(Chat());}),
              )
          ],
        ),
      ),
    );
  }
}