import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/search.dart';
import 'package:learning_managment_system/controller/favorite/myfavorite.dart';
import 'package:learning_managment_system/view/widget/courses/customapp.dart';
import 'package:learning_managment_system/view/widget/favoritewidget.dart';
import 'package:learning_managment_system/view/widget/home/customappbar.dart';

import '../../controller/Courses/coursecontroller.dart';
import '../widget/searchwidget.dart';

class FavoriteScreen extends StatelessWidget {
  MyFavoriteController myFavoriteController = Get.put(MyFavoriteController());
  final HomeControllerImp homeController = Get.put(HomeControllerImp());
  FavoriteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(MyFavoriteController());
    // myFavoriteController.fetchfavoritedata();
    Get.put(CourseCountrollerImp());
    Get.put(HomeControllerImp());
    myFavoriteController.fetchfavoritedata();
    return Scaffold(
        body: Stack(children: [
      SafeArea(
        child: GetBuilder<HomeControllerImp>(
            builder: (homeController) => ListView(
                  children: [
                    SizedBox(
                      child: CustomAppBar(
                        mycontroller: homeController.search!,
                        onPressedSearch: () {
                          homeController.onSearchCourse();
                        },
                        onChanged: (seachC) {
                          homeController.checkSearch(seachC);
                        },
                        text: 'Your Favourite Courses',
                      ),
                    ),
                    !homeController.issearch.value
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 12, right: 4, bottom: 10),
                            child: Column(
                              children: [
                                SizedBox(height: 700, child: FavoriteWidget()),
                              ],
                            ),
                          )
                        : ListSubCoursesSearch(
                            listdataModel: homeController.listdata,
                          )
                  ],
                )),
      )
    ]));
  }
}
