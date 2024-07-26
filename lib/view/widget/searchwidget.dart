import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../controller/search.dart';
import '../../core/constant/color.dart';

import '../../core/constant/imageasset.dart';
import '../../model/courses/subcoursesmodel.dart';

class ListSubCoursesSearch extends StatelessWidget {
  final List<Subcoursesmodel> listdataModel;
  final HomeControllerImp homeController = Get.put(HomeControllerImp());
  ListSubCoursesSearch({super.key, required this.listdataModel});

  @override
  Widget build(BuildContext context) {
    //Obx(() {
    if (homeController.isloading.isTrue) {
      return Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Lottie.asset(ImageAsset.loadingLottie),
        )),
      );
    } else {
      if (homeController.listdata.isEmpty) {
        return Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Center(
            child: Lottie.asset(
              ImageAsset.searchLottie,
            ),
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: listdataModel.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 15.0, left: 15, bottom: 0),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color.fromARGB(255, 182, 154, 239)
                                      .withOpacity(0.4),
                                  const Color.fromARGB(255, 105, 168, 255),
                                  const Color.fromARGB(255, 171, 129, 255),
                                  const Color.fromARGB(255, 149, 83, 255)
                                      .withOpacity(0.9),
                                  const Color.fromARGB(255, 86, 8, 220)
                                      .withOpacity(0.4),
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
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            color: Colors.deepPurple[50]),
                        //  fromARGB(255, 229, 222, 240)
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Expanded(
                            //    child:

                            //    ),
                            Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 1.0, bottom: 1, left: 0),
                                        child: Text(
                                            ' ${listdataModel[index].categoryName}',
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: AppColor.whiteColor,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                            '${listdataModel[index].name}',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: AppColor.whiteColor,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                    ],
                                  ),
                                ]),
                            Padding(
                                padding: const EdgeInsets.only(
                                    right: 20.0, left: 20),

                                // if (listdataModel[index].image!.isEmpty) {
                                //   return
                                child: Image.asset(
                                  ImageAsset.logoImage,
                                  height: 100,
                                  width: 80,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        );
      }
    }

    //  });
  }
}
