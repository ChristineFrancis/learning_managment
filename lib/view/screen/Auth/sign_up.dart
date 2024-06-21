import 'dart:ui';
import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/Auth/signup_controller.dart';
import 'package:learning_managment_system/core/class/handlinigdataview.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/routes.dart';
import 'package:learning_managment_system/core/functions/validinput.dart';
import 'package:learning_managment_system/view/widget/auth/customtextformfield.dart';
import 'package:learning_managment_system/view/widget/custom_widget/custom_button.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
   Get.put(SignUpControllerImp());
   return Scaffold(
    body:GetBuilder<SignUpControllerImp>(builder: (controller)=>
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
         decoration: BoxDecoration(
         color: Colors.white.withOpacity(0.5),
         borderRadius:  BorderRadius.circular(20)),
         child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 20 ,vertical: 10),
          child: Column(
           children: [
           const Center(
            child:Text( 'Sign Up' ,
            style: TextStyle( color: AppColor.primaryColor , fontSize: 35 , fontWeight: FontWeight.w700 ,),)),
            const SizedBox(height: 10,),
           Stack(
            children: [
            controller.image!=null  
            ? CircleAvatar(
            radius: Get.size.width/4,
            backgroundImage: MemoryImage(controller.image!), )
            : CircleAvatar(
              backgroundColor: AppColor.primaryColor,
              radius: Get.size.width/4,
              child:const Padding(padding: EdgeInsets.only(bottom: 0),
               child: Icon(Icons.person , size: 150, color: AppColor.whiteColor,),),),
            Positioned(right: 130, bottom: 130,
           child: IconButton(
            onPressed: (){controller.galleryorCamera();}, 
            icon: const Icon(Icons.add_a_photo_outlined , size: 33,color:Colors.white),))
            ], ),

          CustomTextFormFieldAuth(
          hintTextAuth: 'Enter your first name',
          labelTextAuth: 'First Name' ,
          suffixIconAuth: Icons.person_2_outlined, 
          controllerAuth:controller.firstName,
          isNum: false,
          valid:(val){return validInput(val!, 2, 40, 'userrname');} ,),
          CustomTextFormFieldAuth(
           hintTextAuth: 'Enter your last name',
           labelTextAuth: 'Last Name ' ,
           suffixIconAuth: Icons.person_2_outlined,
           controllerAuth:controller.lastName,
           isNum: false,
           valid:(val){return validInput(val!, 2, 40, 'userrname');} ),
           CustomTextFormFieldAuth(
            hintTextAuth: 'Enter your email',
            labelTextAuth: 'Email' ,
            suffixIconAuth: Icons.email_outlined,
            controllerAuth:controller.email,
            isNum: false,
            valid:(val){return validInput(val!, 2, 50, 'email');} ),
           CustomTextFormFieldAuth(
            hintTextAuth: 'Enter your password',
            labelTextAuth: 'Password' ,
            suffixIconAuth: controller.passwordIconAuth,
            controllerAuth:controller.password,
            isNum: false,
            onTap: () {controller.showPassword(); },
            obscureText: controller.isShowPassword,
            valid:(val){return validInput(val!, 8, 30, 'password');} ),
           CustomTextFormFieldAuth(
            hintTextAuth: 'Enter your password',
            labelTextAuth: 'Confirm Passwprd' ,
            suffixIconAuth: controller.confirmPasswordIconAuth,
            controllerAuth:controller.confirmPassword,
            isNum: false,
            onTap: () {controller.showConfirmPassword(); },
            obscureText: controller.isShowConfirmPassword,
            valid:(val){return isConfirmPassword(controller.password.text, val!);} ),
           Padding(padding: const EdgeInsets.only(right:70 ,left: 70, top: 45, bottom:15),
            child: CustomButton(textButton: 'Sign up',
            onTap: () {controller.signUp(); },),),
           Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
           const Text('Are you already have an account?' ,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500 , color: AppColor.primaryColor)),
           InkWell(
            onTap: () { Get.toNamed(AppRoute.login); },
            child: Container(
              margin: const EdgeInsets.only(left: 5),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.secondaryColor , width: 2))),
              child: const Text('Login' ,style: TextStyle(fontSize:19 , fontWeight: FontWeight.w500 , color:AppColor.secondaryColor) ,),),
                         ),  
                          ] )
                           ] ),
                          ),
                     ),
               ),
             ),),],
           ),
             ),
           )
        ),
     )
        )
    );
  }
}