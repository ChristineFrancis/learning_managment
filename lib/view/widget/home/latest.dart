import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/Home/latestcontroller.dart';
import 'package:learning_managment_system/controller/Home/recomendedcontroller.dart';
import 'package:learning_managment_system/controller/Quiz/quiz_videos_controller.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/model/course_details/courseDetails_model.dart';
import 'package:learning_managment_system/view/screen/CourseDetails/courseDetails.dart';

import '../../../core/constant/imageasset.dart';

class LatestHome extends StatelessWidget {
  LatestHome();

  final LatestController controller = Get.put(LatestController());
  final RecomendeController controller1 = Get.put(RecomendeController());
  final QuizVideosControllerImp videosControllerImp = Get.put(QuizVideosControllerImp());

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.displayLatest.length + 1,
        itemBuilder: (context, index) {
          if (index == controller.displayLatest.length) {
            return controller.itemsDisplayed < controller.alllatest.length
                ? IconButton(
                    style: ButtonStyle(),
                    onPressed: controller.showMore,
                    icon: Icon(Icons.navigate_next),
                  )
                : const SizedBox.shrink();
          }
          return InkWell(
            onTap: () async{
              print('laaaaaaaaaaaaaatest ');
              await videosControllerImp.getCourseDetails(controller.alllatest[index].id!); 
              print(controller.alllatest[index].id!);
               Get.to(CourseDetailsPage());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 4, bottom: 8),
              child: Container(
                height: 100,
                width: 320,
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 8),
                          child: Obx(() => Text(
                              controller.alllatest[index].categoryName!,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: AppColor.whiteColor,
                                  fontWeight: FontWeight.w500))),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(() => Text(controller.alllatest[index].name!,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: AppColor.whiteColor,
                                    fontWeight: FontWeight.w600))),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(
                              () => Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: TextButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.star,
                                    size: 20,
                                    color: Colors.amber,
                                  ),
                                  label: Text(
                                      '${controller.alllatest[index].totalLikes}  Likes',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: AppColor.whiteColor,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(
                              () => Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom: 15),
                                child: Text(
                                    '${controller.alllatest[index].createdFrom}  ',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: AppColor.whiteColor,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Obx(() {
                        if (controller.alllatest[index].image!.isEmpty) {
                          return Image.asset(
                            ImageAsset.logoImage,
                            height: 150,
                            width: 100,
                          );
                        } else {
                          return Image.network(
                            controller.alllatest[index].image!,
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
  }
}
