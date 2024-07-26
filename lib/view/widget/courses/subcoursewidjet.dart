import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/Courses/subcoursescontroller.dart';
import 'package:learning_managment_system/controller/favorite/favoritecontroller.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/imageasset.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SubCourseWidget extends StatelessWidget {
  var duration = 2000;
  final int subcourseInd;

  final SubCourseConImp controller = Get.put(SubCourseConImp());
  final FavouriteController controllerfav = Get.put(FavouriteController());
  SubCourseWidget({super.key, required this.subcourseInd});

  @override
  Widget build(BuildContext context) {
    Get.put(FavouriteController());
    controller.fetchCourses(subcourseInd);
    return Obx(
      () => ListView.builder(
          itemCount: controller.subcoursesList.length,
          itemBuilder: (context, index) {
            if (index >= 0 && index < controller.subcoursesList.length) {
              controllerfav.isFavourite[controller.subcoursesList[index].id] =
                  controller.subcoursesList[index].isFavorite;
              return Obx(
                () => InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 15.0, left: 4, bottom: 20),
                      child: Container(
                        width: 100,
                        height: 150,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.primaryColor.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                          color: AppColor.whiteColor.withOpacity(0.7),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30.0, left: 10),
                                  child: Text(
                                      controller.subcoursesList[index].name!,
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 10),
                                  child: Text(
                                      'Teacher name:${controller.subcoursesList[index].teacher!.firstName!}',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                ),
                                GetBuilder<FavouriteController>(
                                    builder: (controller1) {
                                  return IconButton(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 25),
                                      onPressed: () {
                                        if (controller1.isFavourite[controller
                                                .subcoursesList[index].id] ==
                                            true) {
                                          controller1.setFavourite(
                                              controller
                                                  .subcoursesList[index].id,
                                              0);
                                          controllerfav.removeFavorite(
                                              controller
                                                  .subcoursesList[index].id!,
                                              '1');
                                        } else {
                                          controller1.setFavourite(
                                              controller
                                                  .subcoursesList[index].id,
                                              1);
                                          controllerfav.addFavorite(
                                              controller
                                                  .subcoursesList[index].id!,
                                              '1');
                                        }
                                      },
                                      iconSize: 30,
                                      icon: Icon(
                                        controller1.isFavourite[controller
                                                    .subcoursesList[index]
                                                    .id] ==
                                                true
                                            ? Icons.star
                                            : Icons.star_border_outlined,
                                        color: Colors.amber,
                                        size: 40,
                                      ));
                                })
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Obx(() {
                                  if (controller.subcoursesList[index]
                                          .studentHasEnrolled ==
                                      1) {
                                    return CircularPercentIndicator(
                                      radius: 45,
                                      lineWidth: 12,
                                      backgroundColor: AppColor.purple5,
                                      progressColor: AppColor.primaryColor,
                                      animation: true,
                                      animationDuration: duration,
                                      percent: controller
                                          .subcoursesList[index].progress
                                          .toDouble(),
                                      center: Text(
                                          '${controller.subcoursesList[index].progress}%'),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                })),
                          ],
                        ),
                      ),
                    )),
              );
            } else {
              return Image.asset(ImageAsset.loadingLottie);

              
            }
          }),
    );
  }
}
