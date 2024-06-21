import 'dart:ui';
import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/Auth/login_controller.dart';
import 'package:learning_managment_system/core/class/handlinigdataview.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/routes.dart';
import 'package:learning_managment_system/core/functions/validinput.dart';
import 'package:learning_managment_system/view/widget/auth/customtextformfield.dart';
import 'package:learning_managment_system/view/widget/custom_widget/custom_button.dart';


// ignore: use_key_in_widget_constructors
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());
    return Scaffold(
     body:GetBuilder<LoginControllerImp>(builder: (controller)=>
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
                      const Text( 'Log In' ,style: TextStyle( color: AppColor.primaryColor , fontSize: 35 , fontWeight: FontWeight.w700 ,),),
                      Image.asset('assets/images/idea_8343952.png' , height: 240 ),                 
                       CustomTextFormFieldAuth(hintTextAuth: 'Enter your email',labelTextAuth: 'Email' , suffixIconAuth: Icons.email_outlined, controllerAuth:controller.email,isNum: false,
                        valid:(val){return validInput(val!, 2, 50, 'email');} ),
                       CustomTextFormFieldAuth(hintTextAuth: 'Enter your password',labelTextAuth: 'Password' , suffixIconAuth: controller.suffixIconAuth, controllerAuth:controller.password,isNum: false,
                        valid:(val){return validInput(val!, 8, 30, 'password'  );} , obscureText: controller.isShowPassword,onTap: () {controller.showPassword(); },),
                       SizedBox(height: 30,),
                        InkWell(
                           onTap: () { Get.toNamed(AppRoute.forgetPassword); },
                          child: Text("Forgot password?" ,style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500 , color: AppColor.primaryColor))),
                       Padding(
                         padding: const EdgeInsets.only(right:70 ,left: 70, top: 10, bottom:15),
                         child: CustomButton(textButton: 'Log In',onTap: () { controller.login();},),),
                       Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         const Text("Don't have an account?" ,style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500 , color: AppColor.primaryColor)),
                         InkWell(
                           onTap: () { Get.toNamed(AppRoute.signup); },
                           child: Container(margin: const EdgeInsets.only(left: 5),
                             decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColor.secondaryColor , width: 2))),
                             child: const Text('Sign Up' ,style: TextStyle(fontSize:19 , fontWeight: FontWeight.w500 , color:AppColor.secondaryColor) ,),),
                         ),
                          ] ),


                          Padding(
                         padding: const EdgeInsets.only(right:70 ,left: 70, top: 10, bottom:15),
                         child: CustomButton(textButton: 'Log Out',onTap: () { controller.logout();},),),

                         // const Expanded(flex: 2, child: SizedBox()),
                           ] ),
                          ),
                     ),
               ),
             ),),],
           ),
             ),
           )
        ),))
    );
  }
}