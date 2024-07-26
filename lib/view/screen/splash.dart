
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/imageasset.dart';
import 'package:learning_managment_system/services/services.dart';
import 'package:learning_managment_system/view/screen/curved_NavigationBar.dart';
import 'package:learning_managment_system/view/screen/onboarding.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

// ignore: camel_case_types
class Splash_Screen extends StatelessWidget {
  const Splash_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find();
     String? token = myServices.sharedPreferences.getString('access_token');
    return AnimatedSplashScreen(
        splash: Column(
          children: [
            Expanded(
                child: Image.asset(
                  ImageAsset.logoImage,
                width: 200,
                height: 200,), ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'FEKRA',
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            )
          ],
        ),
        splashIconSize: 200,
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: AppColor.primaryColor,
        duration: 3000,
        pageTransitionType: PageTransitionType.bottomToTop,
        nextScreen: token==null ? OnBoarding() : Curved_NB()
        );
  }
}
