import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:learning_managment_system/controller/onboarding_controller.dart';


class CustombuttonOnboarding extends GetView<OnBoardingControllerImp> {
  final String textButton;

  const CustombuttonOnboarding({
    super.key,
    required this.textButton,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.next();
      },
      child: Container(
        height: 60,
        width: 220,
        decoration: const BoxDecoration(
            color: Colors.white,
            // AppColor.primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        child: Center(
          child: Text(
            textButton,
            style: const TextStyle(
              color: Color(0xff8D6DFE),
              fontWeight: FontWeight.w500,
              fontSize: 25,
              fontFamily: 'Exo2',
            ),
          ),
        ),
      ),
    );
  }
}