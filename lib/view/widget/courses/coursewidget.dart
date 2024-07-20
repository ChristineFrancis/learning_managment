import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/Courses/coursecontroller.dart';
import 'package:learning_managment_system/controller/Courses/subcoursescontroller.dart';
import 'package:learning_managment_system/core/constant/color.dart';

import 'package:learning_managment_system/view/screen/Courses/subcourses.dart';

import '../../../core/constant/imageasset.dart';

class CourseWidget extends StatelessWidget {
  final int courseId;
  final CourseCountrollerImp controller = Get.put(CourseCountrollerImp());

  final SubCourseConImp controllerSub = Get.put(SubCourseConImp());

  CourseWidget({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: controller.coursesList.length + 1,
        itemBuilder: (context, index) {
          if (index >= 0 && index < controller.coursesList.length) {
            var course = controller.coursesList[index];

            return InkWell(
                onTap: () {
                  Get.to(() => SubCourseScreen(subcourseInd: course.id!));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 15.0, left: 4, bottom: 20),
                  child: Container(
                    width: 100,
                    height: 130,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.primaryColor.withOpacity(0.15),
                            spreadRadius: 4,
                            blurRadius: 3,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: AppColor.whiteColor.withOpacity(0.7)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 25.0, left: 10, right: 50),
                          child: Text(controller.coursesList[index].name!,
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w500)),
                        ),
                        Obx(() {
                          if (controller.coursesList[index].image!.isEmpty) {
                            return Image.asset(
                              ImageAsset.logoImage,
                              height: 100,
                            );
                          } else {
                            return Image.network(
                              '${controller.coursesList[index].image}',
                              height: 90,
                              alignment: Alignment.topCenter, //  width: 190,
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                ));
          } else {
            print('${controller.coursesList.length + 1}length');
          }
        });
  }
}
