import 'dart:ui';
import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/Auth/check_email_controller.dart';
import 'package:learning_managment_system/core/class/handlinigdataview.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/view/widget/custom_widget/custom_button.dart';
import 'package:timer_count_down/timer_count_down.dart';


class CheckEmailPage extends StatelessWidget {
  const CheckEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CheckEmailControllerImp());
  return Scaffold(
   body:GetBuilder<CheckEmailControllerImp>(builder: (controller)=>
      HandinigDataRequest(statusRequest: controller.statusRequest, widget:
      AnimatedBackground(
      vsync:controller ,
      behaviour:RandomParticleBehaviour(
      options: 
      const ParticleOptions(
       spawnMaxRadius: 50,
        spawnMinSpeed: 15,
        spawnMaxSpeed: 30,
        particleCount: 20,
        baseColor: AppColor.primaryColor
        )) ,
      child: ClipRect(
       child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child:
        CustomScrollView(
         slivers: [
         SliverFillRemaining(
          hasScrollBody: false,
          child: SafeArea(
          child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 15 ,vertical: 10),
           child: Column(
            children: [
            const Center(
              child:Text( 'Check Your Email' ,style: TextStyle( color: AppColor.primaryColor , fontSize: 35 , fontWeight: FontWeight.w700 ,),)),
            const SizedBox(height: 20,),
            const Padding(
             padding: EdgeInsets.symmetric(horizontal:0),
             child: Text('We texted you a code,please Enter it below:' ,
                           textAlign:TextAlign.start ,
                           style: TextStyle(fontSize: 20, color:AppColor.secondaryColor ),) ),
             const SizedBox(height: 30,),
             OtpTextField(
            fieldWidth: 50,
            fieldHeight: 100,
            focusedBorderColor: AppColor.primaryColor ,
            borderRadius: BorderRadius.circular(80),
            numberOfFields:6,
            enabledBorderColor:AppColor.primaryColor ,
            showFieldAsBox: true, 
            onCodeChanged: (String code) { },
            onSubmit: (String verificationCode){
              int code = int.parse(verificationCode);
               print('verificationCoooooooooooooooode $verificationCode');
               controller.checkEmail(verificationCode);
                // showDialog(
                //     context: context,
                //     builder: (context){
                //     return AlertDialog(
                //         title: Text('Verification Code' ),
                //         content: Text('Code entered is $verificationCode'),
                //     );
                //     }
                // );
                          }, // end onSubmit
                        ),
                         
            Countdown(
             seconds: 20,
             build: (BuildContext context, double time) =>
              Padding(
               padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Text("If you don't receive the code , we can send it after:  ${time.toString()}", style: const TextStyle(fontSize: 20 , color:AppColor.secondaryColor ),),),
                      interval: Duration(milliseconds: 100),
                      onFinished: () {
                        print('Timer is done!');  
                        controller.update();
                        controller.isFinised.value=true ;
                      },
                    ),
                    controller.isFinised.value ? const Padding(
                      padding: EdgeInsets.only(top:20),
                      child: Text('Now we can resend the code' ,textAlign:TextAlign.start , style: TextStyle(fontSize: 20 , color:AppColor.secondaryColor  ,),),
                    ) : const Text(''),
                    Padding(
                       padding: const EdgeInsets.only(right:70 ,left: 70, top: 20, bottom:15),
                       child: CustomButton(textButton: 'Resend',
                       onTap: () {if(controller.isFinised.value) 
                       {controller.resend();}
                       },),),
                        ],),
              ),
               
             ),),],
           ),
             ),
           )
        ),))
    );
  }
}