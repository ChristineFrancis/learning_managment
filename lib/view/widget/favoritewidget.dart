import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/Quiz/quiz_videos_controller.dart';
import 'package:learning_managment_system/controller/favorite/favoritecontroller.dart';
import 'package:learning_managment_system/controller/favorite/myfavorite.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/view/screen/CourseDetails/courseDetails.dart';

import '../../controller/Courses/subcoursescontroller.dart';
import '../../core/constant/imageasset.dart';

class FavoriteWidget extends GetView<MyFavoriteController> {
  final MyFavoriteController myFavoriteController =
      Get.put(MyFavoriteController());
  final SubCourseConImp controllercourse = Get.put(SubCourseConImp());
  final FavouriteController favouriteController =
      Get.put(FavouriteController());
  final QuizVideosControllerImp videosControllerImp =
      Get.put(QuizVideosControllerImp());

  FavoriteWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(MyFavoriteController());
    myFavoriteController.fetchfavoritedata();
    return GetBuilder<MyFavoriteController>(builder: (controller) {
      return ListView.builder(
          itemCount: controller.favorite.length,
          itemBuilder: (context, index) {
            if (index >= 0 && index < controller.favorite.length) {
              return InkWell(
                  onTap: ()
                   async {
                    await videosControllerImp.getCourseDetails(
                        myFavoriteController.favorite[index].id!);

                    Get.to(CourseDetailsPage());
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 20.0, left: 4, bottom: 20),
                    child: Container(
                      width: 80,
                      height: 180,
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
                                padding:
                                    const EdgeInsets.only(top: 30.0, left: 10),
                                child: Text(
                                    myFavoriteController
                                        .favorite[index].categoryName!,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 10, right: 10),
                                child: Text(
                                    myFavoriteController.favorite[index].name!,
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500)),
                              ),
                              IconButton(
                                  onPressed: () {
                                    favouriteController.removeFavorite(
                                        controller.favorite[index].id!, '1');
                                  },
                                  icon: const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 40,
                                  )),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 20),
                            child: Image.asset(
                              ImageAsset.logoImage,
                              height: 200,
                              width: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
            } else {}

            return CircularProgressIndicator();
          });
    });
  }
}
