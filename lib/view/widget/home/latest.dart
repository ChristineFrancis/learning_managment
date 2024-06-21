import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/latestcontroller.dart';
import 'package:learning_managment_system/controller/recomendedcontroller.dart';


class LatestHome extends StatelessWidget {
  LatestHome();

  final LatestController controller = Get.put(LatestController());
  final RecomendeController controller1 = Get.put(RecomendeController());

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
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 4, bottom: 8),
              child: Container(
                height: 100,
                width: 300,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xff8D6DFE),
                          Colors.deepOrange.shade300,
                          //Color(0xff8D6DFE),
                          Colors.white.withOpacity(0.9),
                        ]),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Obx(() {
                        if (controller.alllatest[index].image!.isEmpty) {
                          return Image.asset(
                            'assets/images/logo.png',
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 8),
                          child: Obx(() => Text(
                              controller.alllatest[index].categoryName!,
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontFamily: "Exo 2",
                                  fontWeight: FontWeight.w500))),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(() => Text(controller.alllatest[index].name!,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Exo 2",
                                    fontWeight: FontWeight.w500))),
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
                                  icon: Icon(
                                    Icons.favorite,
                                    size: 18,
                                    color: Colors.red.shade700,
                                  ),
                                  label: Text(
                                      '${controller.alllatest[index].totalLikes}  Likes',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontFamily: "Exo 2",
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
                                        color: Colors.black,
                                        fontFamily: "Exo 2",
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
