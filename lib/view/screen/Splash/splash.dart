import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/Splash/splash-controller.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/imageasset.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return  Scaffold(
     // backgroundColor: AppColor.whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Welcome To \nFEKRA' , 
          textAlign:TextAlign.center ,
    style: TextStyle
    (
      color: AppColor.primaryColor ,
       //fontFamily: 'KronaOne' ,
        fontSize: 45 ,
         fontWeight: FontWeight.bold
    ),).animate().fade(begin: .1 , end: 1 , delay:1000.ms ).then(duration: 1500.ms).scale().then(duration: 320.ms).shimmer(duration: 1900.ms),

Lottie.asset(ImageAsset.splashLottie),
        ],
      ),
    );
  }
}//Animation - 1712183306578