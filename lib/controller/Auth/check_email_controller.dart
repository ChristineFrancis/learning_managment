
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/core/class/statusrequest.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/routes.dart';
import 'package:learning_managment_system/core/constant/url.dart';
import 'package:learning_managment_system/core/functions/handlingdata.dart';
import 'package:learning_managment_system/data/datasource/remote/auth/check_email_data.dart';
import 'package:learning_managment_system/services/services.dart';


abstract class CheckEmailController extends GetxController with GetTickerProviderStateMixin
 { 
  toggleAnimation();
  checkEmail (String verificationCode);
  resend();
 }

 class CheckEmailControllerImp extends CheckEmailController{
  AnimationController? animationController;
  final isPlaying = false.obs;
  RxBool isFinised=false.obs;
  CheckEmailData checkEmailData=CheckEmailData(Get.find());
  MyServices myServices=Get.find();
  StatusRequest statusRequest=StatusRequest.none;
  String url='url';
  String? preRoute;
  @override
  void onInit() {
    isFinised.value=false;
    animationController = AnimationController(
       vsync: this, duration: const Duration(milliseconds: 1000));
    animationController?.repeat();

     preRoute= Get.previousRoute;
    print('previousRoute $preRoute');
    if (preRoute == AppRoute.signup) {
      url = AppUrl.checkEmailRegister;
    } 

    else if (preRoute == AppRoute.forgetPassword){ 
      url = AppUrl.checkEmailForget;}
    print('urllllllllllll $url');

    print(Get.routing.current);
    print("'''''''''''''''''''");
    print(Get.routing.previous);
    super.onInit();
  }

  

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
  
  @override
  void toggleAnimation() {
    isPlaying.toggle();
    isPlaying.value ? animationController?.forward() : animationController?.stop();
  }

   @override
  void onClose() {
    animationController?.dispose();
    super.onClose();
  }
  
  @override
  checkEmail(String verificationCode)async {

    statusRequest = StatusRequest.loading;
    update();


      try {
        
        print('url $url');
        print('previousRoute $preRoute');
        var response = await checkEmailData.postData(verificationCode ,url! );

         statusRequest = handlingData(response);
        if (statusRequest == StatusRequest.success) 
        {
          if (response['message'] == 'Code has been confirmed')
           {
            
              Get.defaultDialog(title:  response['message'],
               content:Text('') , 
              titleStyle: const TextStyle(color: AppColor.primaryColor, fontSize: 25));
            Future.delayed(const Duration(seconds:1), () {
            if(preRoute==AppRoute.signup)
              {
                myServices.sharedPreferences.setBool('canGoToHome', true);
                Get.offAllNamed(AppRoute.navbar);
                }
            else if (preRoute==AppRoute.forgetPassword)
           {Get.toNamed(AppRoute.resetPassword);}
          });
           }
           else if (response['message'] == 'Validation error') {
            String errorMessages = '';
            if (response['errors'] != null) {
              response['errors'].forEach((key, value) {
                errorMessages += value.join('\n') + '\n';
              });
            }
            Get.defaultDialog(title: response['message'], content: Text(errorMessages.isNotEmpty ? errorMessages : 'An error occurred.'));
            statusRequest = StatusRequest.failure;
          } else {
            Get.defaultDialog(title: 'Warning', content: Text(response['message'] ?? 'An error occurred.'));
            statusRequest = StatusRequest.failure;
          }
        }
      } catch (e) {
        statusRequest = StatusRequest.failure;
        print(' An errooooooooooooooooooooooooooor occurred: $e');
      
      }
      update();



  }
  
  @override
  resend() async{
    statusRequest = StatusRequest.loading;
      update();

      try {
         String? token= myServices.sharedPreferences.getString('access_token');
         print('toooken $token');
        var response = await checkEmailData.resendcode(token);
         statusRequest = handlingData(response);
        if (statusRequest == StatusRequest.success) 
        {
          if (response['message'] == 'Code has been resent')
           {
            Get.snackbar('DONE', 'your request has been received',
             snackPosition: SnackPosition.BOTTOM, backgroundColor: AppColor.primaryColor, colorText: AppColor.whiteColor);
           }       
          else {
            Get.snackbar( 'Warning', response['message'] ?? 'An error occurred.');
            statusRequest = StatusRequest.failure;
          }
        } 
      
      } catch (e) {
        statusRequest = StatusRequest.failure;
        print(' An errooooooooooooooooooooooooooor occurred: $e');
       
      }
      update();


    
  }


 
}
