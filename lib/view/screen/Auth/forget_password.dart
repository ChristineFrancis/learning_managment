import 'dart:ui';
import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/Auth/forget_password_controller.dart';
import 'package:learning_managment_system/core/class/handlinigdataview.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/functions/validinput.dart';
import 'package:learning_managment_system/view/widget/auth/customtextformfield.dart';
import 'package:learning_managment_system/view/widget/custom_widget/custom_button.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ForgetPasswordControllerImp());
    return Scaffold(
     body:GetBuilder<ForgetPasswordControllerImp>(builder: (controller)=>
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
           child: CustomScrollView(
            slivers: [
               SliverFillRemaining(
            hasScrollBody: false,
             child: SafeArea(
               child: Form(
                key: controller.formState,
                 child: Container(
                 // margin: EdgeInsets.symmetric(horizontal: 20 , vertical:45),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius:  BorderRadius.circular(20)),
                  child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20 ,vertical: 10),
                   child: Column(
                     children: [
                      const Text( 'Forgot Password?',textAlign:TextAlign.center , style: TextStyle( color: AppColor.primaryColor , fontSize: 35 , fontWeight: FontWeight.w700 ,),),
                      const SizedBox(height: 40,),
                      const Text("Enter your email below to reset your password" ,style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500 , color: AppColor.secondaryColor)),                           
                       CustomTextFormFieldAuth(hintTextAuth: 'Enter your email',labelTextAuth: 'Email' , suffixIconAuth: Icons.email_outlined, controllerAuth:controller.email,isNum: false,
                        valid:(val){return validInput(val!, 2, 50, 'email');} ),
                        //  CustomTextFormFieldAuth(hintTextAuth: 'Enter your name',labelTextAuth: 'Full Name' , suffixIconAuth: Icons.person_2_outlined, controllerAuth:controller.fullName,isNum: false,
                        // valid:(val){return validInput(val!, 2, 40, 'userrname');} ,),
                       
                       Padding(
                         padding: const EdgeInsets.only(right:70 ,left: 70, top: 45, bottom:15),
                         child: CustomButton(textButton: 'Submit',onTap: () {controller.forgetPassword(); },),),
        
                         // const Expanded(flex: 2, child: SizedBox()),
                           ] ),
                          ),
                     ),
               ),
             ),),],
           ),
             ),
           )
        )),)
    );
  }
}