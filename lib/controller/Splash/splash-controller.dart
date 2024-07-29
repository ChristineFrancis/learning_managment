import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:learning_managment_system/core/constant/routes.dart';
import 'package:learning_managment_system/services/services.dart';

class SplashController extends GetxController {
   MyServices myServices=Get.find();


  @override
  void onInit() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 6) ,
     (){
      String? token = myServices.sharedPreferences.getString('access_token');
      if(token !=null)
       {Get.offNamed(AppRoute.navbar);}
       else{
        Get.offNamed(AppRoute.onboarding);
       }
       }
     );
  
    
    super.onInit();
  }

  @override
  void onClose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual ,overlays: SystemUiOverlay.values );
    super.onClose();
  }
}