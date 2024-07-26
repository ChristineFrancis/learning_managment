import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/Auth/signup_controller.dart';
import 'package:learning_managment_system/controller/search.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/imageasset.dart';

class CustomAppBar extends StatelessWidget {
  final void Function()? onPressedSearch;
  final void Function()? onpressed;
  final void Function()? iconpressed;
  IconData? icon1;
  final Function(String)? onChanged;
  final text;
  final TextEditingController mycontroller;

  CustomAppBar(
      {super.key,
      this.onPressedSearch,
      this.onChanged,
      required this.mycontroller,
      required this.text,
      this.onpressed,
      this.iconpressed,
      this.icon1});
  final SignUpControllerImp controller = Get.put(SignUpControllerImp());
  final HomeControllerImp homeController = Get.put(HomeControllerImp());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 0, left: 0, bottom: 10),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColor.grey2,
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: AppColor.primaryColor,
          borderRadius:
              const BorderRadius.only(bottomRight: Radius.circular(70))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: AppColor.whiteColor,
                  onPressed: onpressed),
              Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 0),
                child: Image.asset(
                  ImageAsset.logoImage,
                  width: 90,
                ),
              ),
            ],
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          // IconButton(
          //     icon: Icon(Icons.arrow_back),
          //     color: AppColor.whiteColor,
          //     onPressed: onpressed),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: IconButton(
          //       onPressed: iconpressed,
          //       icon: Icon(
          //         icon1,
          //         size: 40,
          //         color: Colors.amber,
          //       )),
          // ),
          //   ],
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      text,
                      textStyle: const TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: AppColor.whiteColor),
                      speed: const Duration(milliseconds: 200),
                    ),
                  ],
                  totalRepeatCount: 1,
                  pause: const Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 50, top: 15),
            child: TextFormField(
              controller: mycontroller,
              onChanged: onChanged,
              decoration: InputDecoration(
                  hoverColor: AppColor.grey,
                  focusColor: AppColor.lightGreyColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  hintText: "Search here",
                  hintStyle: const TextStyle(color: AppColor.whiteColor),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                  suffixIcon: IconButton(
                      onPressed: onPressedSearch,
                      icon: const Icon(
                        Icons.search,
                        color: AppColor.whiteColor,
                      ))),
            ),
          ),
        ],
      ),
    );
  }
}
