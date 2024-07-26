import 'dart:ui';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/Courses/coursecontroller.dart';
import 'package:learning_managment_system/controller/search.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/view/screen/curved_NavigationBar.dart';
import 'package:learning_managment_system/view/screen/homepage.dart';
import 'package:learning_managment_system/view/widget/courses/coursewidget.dart';
import 'package:learning_managment_system/view/widget/courses/customapp.dart';

import '../../widget/searchwidget.dart';

class CoursesScreen extends StatelessWidget {
  final int courseId;
  final CourseCountrollerImp controller = Get.put(CourseCountrollerImp());

  final HomeControllerImp homeController = Get.put(HomeControllerImp());
  @override
  CoursesScreen({
    super.key,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseCountrollerImp>(
      builder: (controller) => Scaffold(
          body: Stack(
        children: [
          AnimatedBackground(
              vsync: controller,
              behaviour: RandomParticleBehaviour(
                  options: const ParticleOptions(
                      spawnMaxRadius: 50,
                      spawnMinSpeed: 15,
                      spawnMaxSpeed: 40,
                      particleCount: 30,
                      baseColor: AppColor.primaryColor)),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 2.0),
                  child: const CustomScrollView(
                    slivers: [],
                  ),
                ),
              )),
          SafeArea(
            child: GetBuilder<HomeControllerImp>(
              builder: (homeController) => ListView(children: [
                SizedBox(
                  child: CustomAppBar(
                    onpressed: () {
                      Get.to(() => Curved_NB());
                    },
                    text: 'Choose what \n you like!',
                    mycontroller: homeController.search!,
                    onPressedSearch: () {
                      homeController.onSearchCourse();
                    },
                    onChanged: (seachC) {
                      homeController.checkSearch(seachC);
                    },
                  ),
                ),
                !homeController.issearch.value
                    ? Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 12, right: 4),
                        child: Column(children: [
                          SizedBox(
                              height: 500,
                              child: Obx(() {
                                if (controller.coursesList.isEmpty) {
                                  return const CircleAvatar();
                                } else {
                                  return CourseWidget(
                                    courseId: courseId,
                                  );
                                }
                              }))
                        ]))
                    : ListSubCoursesSearch(
                        listdataModel: homeController.listdata,
                        //  )
                      )
              ]),
            ),
          ),
        ],
      )),
    );
  }
}
