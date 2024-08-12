import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/Auth/signup_controller.dart';
import 'package:learning_managment_system/controller/profile/profilecontroller.dart';
import 'package:learning_managment_system/controller/profile/profilegetdata.dart';
import 'package:learning_managment_system/controller/search.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/imageasset.dart';

class CustomAppBarHome extends StatelessWidget {
  final void Function()? onPressedSearch;
  final Function(String)? onChanged;
  final TextEditingController mycontroller;

  CustomAppBarHome(
      {super.key,
      this.onPressedSearch,
      this.onChanged,
      required this.mycontroller});
  final SignUpControllerImp controller = Get.put(SignUpControllerImp());
  final HomeControllerImp homeController = Get.put(HomeControllerImp());
  final ProfileControllerImp controllerpro = Get.put(ProfileControllerImp());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 0, left: 5, bottom: 15),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child:
                    GetBuilder<ProfileControllerImp>(builder: (controllerpro) {
                  return Text(
                    "Hi ${controllerpro.student.firstName}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w600),
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  ImageAsset.logoImage,
                  width: 100,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 50, top: 10),
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
