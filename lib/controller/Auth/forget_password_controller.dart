
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/core/class/statusrequest.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/routes.dart';
import 'package:learning_managment_system/core/functions/handlingdata.dart';
import 'package:learning_managment_system/data/datasource/remote/auth/forget_password_data.dart';

abstract class ForgetPasswordController extends GetxController with GetTickerProviderStateMixin
 { 
  forgetPassword();
  toggleAnimation();
 }

 class ForgetPasswordControllerImp extends ForgetPasswordController{
  AnimationController? animationController;
  ForgetPasswordData forgetPasswordData=ForgetPasswordData(Get.find());
   StatusRequest statusRequest=StatusRequest.none;

   GlobalKey<FormState> formState=GlobalKey<FormState>();
  
   late TextEditingController email;
   //late TextEditingController fullName;
  
  final isPlaying = false.obs;



  @override
  void onInit() {
    animationController = AnimationController(
       vsync: this, duration: const Duration(milliseconds: 1000));
    animationController?.repeat();
    email=TextEditingController();
   // fullName=TextEditingController();
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
  forgetPassword() async{
     var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      try {
        var response = await forgetPasswordData.postData(email.text);

         statusRequest = handlingData(response);
        if (statusRequest == StatusRequest.success) 
        {
          if (response['message'] == 'Code has been sent.')
           {
              Get.defaultDialog(title: response['message'],content: Text(''), titleStyle: const TextStyle(color: AppColor.primaryColor, fontSize: 25));
              

              Future.delayed(const Duration(seconds:2), () {
            if (Get.isDialogOpen ?? false) {
           Get.back();
            }  });
            Future.delayed(const Duration(seconds:2), () {
            Get.toNamed(AppRoute.checkEmail);
          });
           }
           else if (response['message'] == 'Validation error') {
            String errorMessages = '';
            if (response['errors'] != null) {
              response['errors'].forEach((key, value) {
                errorMessages += value.join('\n') + '\n';
              });
            }
            Get.defaultDialog(title: response['message'], content: Text(errorMessages.isNotEmpty ? errorMessages : 'An error occurred.'), titleStyle: const TextStyle(color: AppColor.primaryColor, fontSize: 25));
            statusRequest = StatusRequest.failure;
          } else {
            Get.defaultDialog(title: 'Warning', content: Text(response['message'] ?? 'An error occurred.'),titleStyle: const TextStyle(color: AppColor.primaryColor, fontSize: 25));
            statusRequest = StatusRequest.failure;
          }
        } 
        // else 
        //   Get.defaultDialog(title: 'Error', content: Text('Failed to sign up. Please try again.'));
        
      } catch (e) {
        statusRequest = StatusRequest.failure;
        print(' An errooooooooooooooooooooooooooor occurred: $e');
       // Get.defaultDialog(title: 'Error', content: Text('An error occurred: $e'));
      }
      update();
    }
  }
}
