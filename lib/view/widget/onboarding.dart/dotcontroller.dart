import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:learning_managment_system/controller/onboarding_controller.dart';
import 'package:learning_managment_system/data/datasource/static/static.dart';

class CustomDotControllerOnboarding extends StatelessWidget {
  const CustomDotControllerOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingControllerImp>(
      builder: (controller) => 
      Column(
        
        
      children:[ Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
              onBoardingList.length,
              (index) => AnimatedContainer(
                    margin: const EdgeInsets.only(left: 6, top: 10),
                    duration: const Duration(milliseconds: 900),
                    width: controller.currentpage == index ? 20 : 6,
                    height: 7,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                  ))
        ],
      )]
      
     ,)
    );
  }
}
