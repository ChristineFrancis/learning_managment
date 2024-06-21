
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/core/class/statusrequest.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/routes.dart';
import 'package:learning_managment_system/core/functions/handlingdata.dart';
import 'package:learning_managment_system/data/datasource/remote/auth/reset_password_data.dart';


abstract class ResetPasswordController extends GetxController with GetTickerProviderStateMixin
 { 
  resetPassword();
  showPassword();
  showConfirmPassword();
  toggleAnimation();
 }

 class ResetPasswordControllerImp extends ResetPasswordController{
  ResetPasswordData resetPasswordData=ResetPasswordData(Get.find());
   StatusRequest statusRequest=StatusRequest.none;


  AnimationController? animationController;

   GlobalKey<FormState> formState=GlobalKey<FormState>();
   late TextEditingController password;
   late TextEditingController confirmPassword;
   late TextEditingController email;
  final isPlaying = false.obs;



  bool isShowPassword=true;
  IconData passwordIconAuth=Icons.visibility_off_outlined;
   bool isShowConfirmPassword=true;
  IconData confirmPasswordIconAuth=Icons.visibility_off_outlined;
  

  @override
  void onInit() {
    animationController = AnimationController(
       vsync: this, duration: const Duration(milliseconds: 1000));
    animationController?.repeat();
    password=TextEditingController();
    confirmPassword=TextEditingController();
    email=TextEditingController();
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
  resetPassword() async{

    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      try {
        var response = await resetPasswordData.postData(  email.text, password.text);

         statusRequest = handlingData(response);
        if (statusRequest == StatusRequest.success) 
        {
          if (response['message'] == 'Your password has been reset !')
           {
              Get.defaultDialog(title: 'Welcome', content: Text(response['message'] ,) , titleStyle: const TextStyle(color: AppColor.primaryColor, fontSize: 25));
            Future.delayed(const Duration(seconds:1), () {
           Get.toNamed(AppRoute.login);
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
       
        
      } catch (e) {
        statusRequest = StatusRequest.failure;
        print(' An errooooooooooooooooooooooooooor occurred: $e');
       
      }
      update();
    }
    
  }

  @override
  showPassword( ) {
    if(isShowPassword==true)
    {
      isShowPassword=false;
       passwordIconAuth=Icons.visibility_outlined;
      update();
    }

    else if(isShowPassword==false)
    {
      isShowPassword=true;
      passwordIconAuth=Icons.visibility_off_outlined;
      update();
    }

  }
  
  @override
  showConfirmPassword() {
     if(isShowConfirmPassword==true)
    {
      isShowConfirmPassword=false;
       confirmPasswordIconAuth=Icons.visibility_outlined;
      update();
    }

    else if(isShowConfirmPassword==false)
    {
      isShowConfirmPassword=true;
      confirmPasswordIconAuth=Icons.visibility_off_outlined;
      update();
    }
    
  }



  
}
