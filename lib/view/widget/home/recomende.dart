import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

import 'package:get/get.dart';
import 'package:learning_managment_system/controller/search.dart';
import 'package:learning_managment_system/controller/Home/latestcontroller.dart';
import 'package:learning_managment_system/controller/Home/recomendedcontroller.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/imageasset.dart';
import 'package:learning_managment_system/view/widget/home/latest.dart';

class RecomendedHome extends StatelessWidget {
  RecomendedHome();
  final HomeController homeController = Get.put(HomeControllerImp());
  final RecomendeController controller = Get.put(RecomendeController());

  final LatestController controllerLatest = Get.put(LatestController());

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
        padding: const EdgeInsets.only(left: 2.0, right: 2, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: AnimatedButton(
                height: 40,
                width: 150,
                onPress: () {
                  homeController.changeTabIndex(0);
                },
                text: 'Recommended',
                gradient:
                    LinearGradient(colors: [AppColor.purple, AppColor.blue]),
                selectedGradientColor: LinearGradient(
                    colors: [AppColor.lightblue, AppColor.purple]),
                selectedTextColor: AppColor.whiteColor,
                transitionType: TransitionType.LEFT_BOTTOM_ROUNDER,
                isReverse: true,
                borderColor: AppColor.whiteColor,
                borderRadius: 20,
              ),
            )),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: AnimatedButton(
                  height: 40,
                  width: 150,
                  onPress: () {
                    homeController.changeTabIndex(1);
                  },
                  text: 'Latest',
                  gradient:
                      LinearGradient(colors: [AppColor.purple, AppColor.blue]),
                  selectedGradientColor: LinearGradient(
                      colors: [AppColor.lightblue, AppColor.purple]),
                  selectedTextColor: AppColor.whiteColor,
                  transitionType: TransitionType.LEFT_BOTTOM_ROUNDER,
                  isReverse: true,
                  borderColor: Colors.white,
                  borderRadius: 20,
                ),
              ),
            )
          ],
        ),
      ),
      Expanded(
          child: Stack(children: [
        Obx(() {
          if (homeController.tabIndex.value == 0) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.displayRecommended.length + 1,
                itemBuilder: (context, index) {
                  if (index == controller.displayRecommended.length) {
                    return controller.itemsDisplayed <
                            controller.allrecommendedCourses.length
                        ? IconButton(
                            style: ButtonStyle(),
                            onPressed: controller.showMore,
                            icon: Icon(Icons.navigate_next),
                          )
                        : const SizedBox.shrink();
                  }
                  return InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 15.0, left: 4, bottom: 8),
                      child: Container(
                        width: 330,

                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppColor.purple2,
                                  AppColor.purple3,
                                  AppColor.purple6,
                                  AppColor.primaryColor,
                                  AppColor.purple4,
                                  AppColor.purple5
                                ]),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.grey2,
                                spreadRadius: 2,
                                blurRadius: 20,
                                blurStyle: BlurStyle.inner,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(50),
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            color: Colors.deepPurple[50]),
                        //  fromARGB(255, 229, 222, 240)
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Expanded(
                            //    child:

                            //    ),
                            Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15.0, bottom: 8),
                                        child: Obx(() => Text(
                                            controller
                                                .allrecommendedCourses[index]
                                                .categoryName!,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: AppColor.whiteColor,
                                                fontWeight: FontWeight.w500))),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Obx(() => Text(
                                          controller
                                              .allrecommendedCourses[index]
                                              .name!,
                                          style: const TextStyle(
                                              fontSize: 25,
                                              color: AppColor.whiteColor,
                                              fontWeight: FontWeight.w600))),
                                    ],
                                  ),
                                   
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Obx(
                                        () => Padding(
                                          padding:
                                              const EdgeInsets.only(top: 0.0),
                                          child: TextButton.icon(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.star,
                                              size: 20,
                                              color: Color.fromARGB(
                                                  255, 255, 209, 58),
                                            ),
                                            label: Text(
                                                '${controller.allrecommendedCourses[index].totalLikes}  Likes',
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: AppColor.whiteColor,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Obx(() {
                                if (controller.allrecommendedCourses[index]
                                    .image!.isEmpty) {
                                  return Image.asset(
                                    ImageAsset.logoImage,
                                    height: 150,
                                    width: 100,
                                  );
                                } else {
                                  return Image.network(
                                    controller
                                        .allrecommendedCourses[index].image!,
                                    height: 70,
                                    width: 20,
                                    alignment: Alignment.topCenter,
                                  );
                                }
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return LatestHome();
          }
        })
      ])),
    ]);
  }
}
