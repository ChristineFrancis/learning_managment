import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:learning_managment_system/controller/onboarding_controller.dart';
import 'package:learning_managment_system/view/widget/onboarding.dart/custombutton.dart';
import 'package:learning_managment_system/view/widget/onboarding.dart/dotcontroller.dart';
import 'package:learning_managment_system/view/widget/onboarding.dart/slider.dart';


class OnBoarding extends StatelessWidget {
  OnBoarding();

  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingControllerImp());

    return Scaffold(
        backgroundColor: const Color(0xff8D6DFE),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            Stack(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.8,
                    decoration: const BoxDecoration(color: Color(0xff8D6DFE)),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [],
                    )),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.522,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(100))),
                    child: const Center(
                        child: CustomSliderOnboarding()) //here slids

                    )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.909,
                decoration: const BoxDecoration(color: Colors.white),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.907,
                decoration: const BoxDecoration(
                    color: Color(0xff8D6DFE),
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(100))),
                child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomDotControllerOnboarding(),

                      //here dotontroller
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: CustombuttonOnboarding(
                          textButton: "Continue",
                        ), //here custom button
                      ),
                      SizedBox(
                        height: 60,
                      ),
                    ]),
              ),
            ),
          ]),
        ));
  }
}
