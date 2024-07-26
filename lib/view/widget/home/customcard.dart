import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/Courses/coursecontroller.dart';
import 'package:learning_managment_system/controller/Home/categorieshome.dart';

import 'package:learning_managment_system/view/screen/Courses/courses.dart';

import '../../../core/constant/imageasset.dart';

class CustomCardHome extends GetView<CategoriesHomeController> {
  final CategoriesHomeController categoriesController =
      Get.put(CategoriesHomeController());
  final List<Map<String, dynamic>> categoriesid = [
    {'id': 1, 'name': ''},
    {'id': 2, 'name': ''},
    {'id': 3, 'name': ''}
  ];

  @override
  CustomCardHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    CourseCountrollerImp courseCountrollerImp = Get.put(CourseCountrollerImp());

    return Obx(() => GridView.builder(
          scrollDirection: Axis.vertical,
          itemCount: categoriesController.categories.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 2.5,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                int id = categoriesid[index]['id'];
                courseCountrollerImp.fetchCourses(id);
                Get.to(() => CoursesScreen(courseId: id));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 5.0, right: 5, bottom: 10, top: 2),
                child: SizedBox(
                  height: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 112, 116, 250)
                                .withOpacity(0.5)
                                .withOpacity(0.9),

                            spreadRadius: 5,
                            blurRadius: 6,
                            blurStyle: BlurStyle.outer,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),

                        // color: Colors.deepPurple.shade100, // لون الحواف
                        // width: 2), // عرض الحواف

                        color: Colors.white.withOpacity(0.5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(categoriesController.categories[index].name!,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                        Obx(() {
                          if (categoriesController
                              .categories[index].image!.isEmpty) {
                            return Image.asset(
                              ImageAsset.logoImage,
                              height: 110,
                            );
                          } else {
                            return Image.network(
                              categoriesController.categories[index].image!,
                              alignment: Alignment.topCenter,
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
