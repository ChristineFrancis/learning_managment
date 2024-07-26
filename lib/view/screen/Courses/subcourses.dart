import 'dart:ui';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:learning_managment_system/controller/Courses/coursecontroller.dart';
import 'package:learning_managment_system/controller/Courses/subcoursescontroller.dart';
import 'package:learning_managment_system/controller/search.dart';
import 'package:learning_managment_system/controller/favorite/favoritecontroller.dart';
import 'package:learning_managment_system/model/courses/subcoursesmodel.dart';
import 'package:learning_managment_system/model/home/searchmodel.dart';
import 'package:learning_managment_system/view/screen/Courses/courses.dart';
import 'package:learning_managment_system/view/screen/favoritepage.dart';
import 'package:learning_managment_system/view/widget/courses/coursewidget.dart';
import 'package:learning_managment_system/view/widget/courses/subcoursewidjet.dart';
import 'package:learning_managment_system/view/widget/home/customappbar.dart';

import '../../../core/constant/color.dart';
import '../../widget/courses/customapp.dart';
import '../../widget/searchwidget.dart';

class SubCourseScreen extends StatelessWidget {
  final int subcourseInd;
  final SubCourseConImp controller = Get.put(SubCourseConImp());
  final FavouriteController controllerfav = Get.put(FavouriteController());
  final HomeControllerImp homeController = Get.put(HomeControllerImp());
  @override
  SubCourseScreen({
    super.key,
    required this.subcourseInd,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(FavouriteController());
    controller.fetchCourses(subcourseInd);
    return GetBuilder<CourseCountrollerImp>(
        builder: (controller) => Scaffold(
                body: Stack(children: [
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
                    builder: (homeController) => ListView(
                          children: [
                            SizedBox(
                              child: CustomAppBar(
                                onpressed: () {
                                  Get.to(() => CoursesScreen(courseId: 0));
                                },
                                text: 'Choose your\n course',
                                mycontroller: homeController.search!,
                                onPressedSearch: () {
                                  homeController.onSearchCourse();
                                },
                                onChanged: (seachC) {
                                  homeController.checkSearch(seachC);
                                },
                                icon1: Icons.star_border_purple500,
                                iconpressed: () {
                                  Get.to(() => FavoriteScreen());
                                },
                              ),
                            ),
                            !homeController.issearch.value
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20,
                                        left: 12,
                                        right: 4,
                                        bottom: 10),
                                    child: Column(
                                      children: [
                                        // Padding(
                                        //   padding: const EdgeInsets.only(
                                        //       left: 270.0),
                                        //   child: IconButton(
                                        //       onPressed: () {},
                                        //       icon: Icon(
                                        //         Icons.star_border_purple500,
                                        //         size: 40,
                                        //         color: Colors.amber,
                                        //       )),
                                        // ),
                                        SizedBox(
                                            height: 700,
                                            child: SubCourseWidget(
                                              subcourseInd: subcourseInd,
                                            )),
                                      ],
                                    ),
                                  )
                                : ListSubCoursesSearch(
                                    listdataModel: homeController.listdata,
                                  )
                          ],
                        )),
              )
            ])));
  }
}
