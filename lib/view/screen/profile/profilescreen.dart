import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/profile/profilecontroller.dart';
import 'package:learning_managment_system/controller/profile/profilegetdata.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/imageasset.dart';
import 'package:learning_managment_system/view/widget/profile/profilewidget.dart';

import '../../widget/profile/showdialog.dart';

class ProfilePage extends StatelessWidget {
  final ProfileControllerImp controller = Get.put(ProfileControllerImp());
  final ProfileUpdteController controllerpro =
      Get.put(ProfileUpdteController());

  String? F;
  String? L;
  String? E;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
        body: SingleChildScrollView(
            child: Column(
      children: [
        SizedBox(
          height: 0,
        ),
        Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 75, 5, 250).withOpacity(0.6),
                        Color.fromARGB(255, 50, 98, 255).withOpacity(0.6),
                        Color.fromARGB(255, 53, 6, 223).withOpacity(0.6),
                        Color.fromARGB(255, 137, 71, 251).withOpacity(0.6),
                        Color.fromARGB(255, 55, 117, 252).withOpacity(0.6),
                      ]),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.grey2,
                      spreadRadius: 2,
                      blurRadius: 10,
                      blurStyle: BlurStyle.inner,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100)),
                  color: Colors.deepPurple[50]),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 320.0, top: 40),
                    child: IconButton(
                      onPressed: () {
                        
                        _showCustomMenu(context);
                      },
                      icon: Icon(Icons.more_vert_outlined),
                      iconSize: 30,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GetBuilder<ProfileUpdteController>(
                        builder: (controllerpro) {
                          if ((controller.student.image == null ||
                                  controller.student.image!.isEmpty) &&
                              controllerpro.image == null) {
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 25.0, left: 10),
                                  child: CircleAvatar(
                                    backgroundColor: AppColor.whiteColor,
                                    radius: Get.size.width / 6,
                                    child: const Icon(
                                      Icons.person,
                                      size: 80,
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       top: 110.0, left: 10),
                                //   child: IconButton(
                                //     onPressed: () {
                                //       controllerpro.galleryorCamera();
                                //     },
                                //     icon: Icon(Icons.add_a_photo,
                                //         size: 33, color: AppColor.primaryColor),
                                //   ),
                                // ),
                              ],
                            );
                          } else {
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 25.0, left: 10),
                                  child: CircleAvatar(
                                    radius: Get.size.width / 6,
                                    backgroundImage: controllerpro.image != null
                                        ? MemoryImage(controllerpro.image!)
                                        : NetworkImage(
                                                '${controller.student.image}')
                                            as ImageProvider,
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 190,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GetBuilder(
                                builder: (ProfileControllerImp controller) {
                                  return Text(
                                    maxLines: 1, // تحديد عدد الأسطر القصوى
                                    overflow: TextOverflow.ellipsis,

                                    softWrap: true,
                                    "${controller.student?.firstName}  ${controller.student?.lastName}",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: AppColor.whiteColor),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GetBuilder(
                              builder: (ProfileControllerImp controller) {
                                return Container(
                                  width: 190,
                                  child: Text(
                                    maxLines: 1, // تحديد عدد الأسطر القصوى
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    "${controller.student?.email}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: AppColor.whiteColor),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )),
        SizedBox(height: 20),
        ProfilePage2(),
        const SizedBox(
          height: 5,
        ),
        ListView.builder(
            //  scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: controller.enrolled.length + 1,
            itemBuilder: (context, index) {
              if (controller.enrolled.isEmpty) {
                return SizedBox();
              } else {
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Padding(
                    padding: EdgeInsets.only(right: 280.0),
                    child: Text(
                      "Courses :",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
                return InkWell(
                  onTap: () {},
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 15.0, left: 4, bottom: 8),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15.0, bottom: 8),
                                      child: Obx(() => Text(
                                          controller
                                              .enrolled[index].categoryName!,
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
                                        controller.enrolled[index].name!,
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
                                              '${controller.enrolled[index].totalLikes}  Likes',
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: AppColor.whiteColor,
                                                  fontWeight: FontWeight.w500)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Obx(() {
                              if (controller.enrolled[index].image!.isEmpty) {
                                return Image.asset(
                                  ImageAsset.logoImage,
                                  height: 150,
                                  width: 100,
                                );
                              } else {
                                return Image.network(
                                  controller.enrolled[index].image!,
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
              }
            })
      ],
    )));
  }
}

_showCustomMenu(BuildContext context) async {
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;
  final RenderBox button = context.findRenderObject() as RenderBox;
  final Size buttonSize = button.size;
  final Offset buttonOffset = button.localToGlobal(Offset.zero);

  await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(
      buttonOffset.dx + buttonSize.width - 100, // Position from the right
      buttonOffset.dy - buttonSize.height, // Position from the bottom
      buttonOffset.dx +
          buttonSize.width, // Position from the right (end of menu)
      buttonOffset.dy +
          buttonSize.height -
          100, // Position from the bottom (start of menu)
    ),
    items: [
      PopupMenuItem(
        value: 'Option1',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Language',
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 75.0),
              child: Icon(Icons.language),
            )
          ],
        ),
      ),
      PopupMenuItem(
        value: 'Option2',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Text(
                themeController.isDarkMode.value ? 'Light mode' : 'Dark mode',
                style: TextStyle(fontSize: 20),
              ),
            ),
            IconButton(
                icon: Obx(() => Icon(themeController.isDarkMode.value
                    ? Icons.wb_sunny
                    : Icons.dark_mode_sharp)),
                onPressed: () {
                  themeController.toggleTheme();
                }),
            // Switch(
            //     value: themeController.isDarkMode.value,
            //     onChanged: (value) {
            //       themeController.toggleTheme();
            //     }),
          ],
        ),
      ),
      PopupMenuItem(
        value: 'Option3',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Delete Account',
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Icon(Icons.account_box_outlined),
            )
          ],
        ),
      ),
    ],
    elevation: 8.0,
  ).then((value) {
    if (value != null) {
      _handleMenuSelection(value, context);
    }
  });
}

_handleMenuSelection(String value, BuildContext context) {
  switch (value) {
    case 'Option1':
      // Show a Snackbar
      showCustomDialoglanguage(context);
      break;
    case 'Option2':
      // Navigate to a new screen
      //  showCustomDialogDark(context);
      break;
    case 'Option3':
      // Display a dialog
      // Get.defaultDialog(
      //   title: "Option 3",
      //   content: Text("You selected Option 3"),
      //   confirm: ElevatedButton(
      //     onPressed: () => Get.back(),
      //     child: Text("OK"),
      //   ),
      // );
      showCustomDialog(context);
      break;
  }
}
