import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/Home/homecontroller.dart';
import 'package:learning_managment_system/controller/Home/recomendedcontroller.dart';
import 'package:learning_managment_system/model/home/searchmodel.dart';
import 'package:learning_managment_system/view/widget/home/customappbar.dart';
import 'package:learning_managment_system/view/widget/home/customcard.dart';
import 'package:learning_managment_system/view/widget/home/recomende.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});
  final RecomendeController recomendeController =
      Get.put(RecomendeController());
  final HomeControllerImp homeController = Get.put(HomeControllerImp());
  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
    return Scaffold(
      body: ListView(children: [
        CustomAppBarHome(
          mycontroller: homeController.search!,
          onPressedSearch: () {
            homeController.onSearchCourse();
          },
          onChanged: (seachC) {
            homeController.checkSearch(seachC);
          },
        ),
        //  RecomendedHome(),
        Obx(() => !homeController.issearch.value
            ? Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  children: [
                    SizedBox(height: 230, child: RecomendedHome()),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Courses",
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              fontFamily: " Exo 2"),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 229, 222, 240),
                      thickness: 3,
                      indent: 40,
                      endIndent: 40,
                      height: 15,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomCardHome()
                  ],
                ),
              )
            : ListView.builder(
                itemCount: homeController.searchData.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  SearchModel result = homeController.searchData[index];
                  return ListTile(
                    title: Text('${result.categoryName}'),
                  );
                }))
      ]),
    );
  }
}
