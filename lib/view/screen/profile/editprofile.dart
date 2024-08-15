import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:learning_managment_system/controller/profile/profilecontroller.dart';
import 'package:learning_managment_system/controller/profile/profilegetdata.dart';
import 'package:learning_managment_system/controller/search.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/view/widget/custom_widget/custom_button.dart';

String? text;

class ProfileUpdateScreen extends StatelessWidget {
  final ProfileControllerImp controller = Get.put(ProfileControllerImp());
  final ProfileUpdteController controllerpro =
      Get.put(ProfileUpdteController());
  final HomeControllerImp homeController = Get.put(HomeControllerImp());

  @override
  Widget build(BuildContext context) {
    controller.fetchProfile();
    final TextEditingController textController =
        TextEditingController(text: controller.student.firstName);

    final TextEditingController textController2 =
        TextEditingController(text: controller.student.lastName);
    final TextEditingController textController3 =
        TextEditingController(text: controller.student.email);

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (controllerpro.isFirstNameModified.value ||
            controllerpro.isLastNameModified.value ||
            controllerpro.isEmailModified.value ||
            controllerpro.isimageModified.value) {
          return await Get.dialog(
                AlertDialog(
                  title: Text('Unsaved Changes'),
                  content: Text(
                      'You have unsaved changes. Do you want to save them?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        //   Get.back();
                        Get.back(result: false); // إلغاء الخروج
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                        Get.back(result: true); // تجاهل التغييرات والخروج
                      },
                      child: Text('Discard'),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                        controllerpro.updatedUser(
                            textController.text,
                            textController2.text,
                            textController3.text,
                            controllerpro.myfile,
                            controllerpro.imageKey);
                        //حفظ التغييرات

                        controller.fetchProfile();
                        Get.back(result: true);
                        // الخروج بعد الحفظ
                      },
                      child: Text('Save'),
                    ),
                  ],
                ),
              ) ??
              false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          title: Text('Edite Profile'),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.grey,

                        spreadRadius: 0,
                        blurRadius: 2,
                        blurStyle: BlurStyle.inner,
                        offset:
                            const Offset(0, 4), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(125),
                        bottomRight: Radius.circular(125)),

                    // color: Colors.deepPurple.shade100, // لون الحواف
                    // width: 2), // عرض الحواف

                    color: AppColor.primaryColor),
                height: 150,
                width: double.infinity,
                // color: AppColor.primaryColor,
              ),
              Positioned(
                bottom: 501,
                left: 129,
                child: CircleAvatar(
                  radius: 73,
                  backgroundColor: AppColor.purple2.withOpacity(0.3),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: GetBuilder<ProfileUpdteController>(
                    builder: (controllerpro) {
                      if ((controller.student.image == null ||
                              controller.student.image!.isEmpty) &&
                          controllerpro.image == null) {
                        return Stack(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 25.0, left: 10),
                              child: CircleAvatar(
                                backgroundColor: AppColor.whiteColor,
                                radius: Get.size.width / 5.5,
                                child: const Icon(
                                  Icons.person,
                                  size: 80,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 110.0, left: 10),
                              child: IconButton(
                                onPressed: () {
                                  controllerpro.galleryorCamera();
                                  // controllerpro.isimageModified.value == true;
                                },
                                icon: Icon(Icons.add_a_photo,
                                    size: 33, color: AppColor.primaryColor),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Stack(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 25.0, left: 10),
                              child: CircleAvatar(
                                radius: Get.size.width / 5.5,
                                backgroundImage: controllerpro.image != null
                                    ? MemoryImage(controllerpro.image!)
                                    : NetworkImage(
                                            '${controller.student.image}')
                                        as ImageProvider,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 110.0, left: 10),
                              child: IconButton(
                                onPressed: () {
                                  controllerpro.galleryorCamera();
                                  // controllerpro.isimageModified.value == true;
                                },
                                icon: Icon(Icons.add_a_photo,
                                    size: 33, color: AppColor.primaryColor),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 240.0, left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FirstName:',
                      style: TextStyle(fontSize: 22),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Obx(
                              () => TextField(
                                style: TextStyle(fontSize: 20),
                                controller: textController,
                                onChanged: (value) {
                                  controllerpro.isFirstNameModified.value =
                                      true;
                                  //  controllerpro.firstNameError.value = null;
                                },
                                decoration: InputDecoration(
                                  errorText: controllerpro.firstNameError.value,
                                  hintText: 'Enter new firstname',
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          controllerpro.firstNameError.value !=
                                                  null
                                              ? Colors.red
                                              : Colors.grey,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          controllerpro.firstNameError.value !=
                                                  null
                                              ? AppColor.primaryColor
                                              : AppColor.purple3,
                                      width: 2.0,
                                    ),
                                  ),
                                  // errorBorder: UnderlineInputBorder(
                                  //   borderSide: BorderSide(
                                  //     color: Colors.red,
                                  //     width: 2.0,
                                  //   ),
                                  // ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30.0),
                            child: Icon(
                              Icons.edit,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      'LastName:',
                      style: TextStyle(fontSize: 22),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Obx(
                            () => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                style: TextStyle(fontSize: 20),
                                controller: textController2,
                                onChanged: (value) {
                                  controllerpro.isLastNameModified.value = true;
                                },
                                decoration: InputDecoration(
                                  errorText: controllerpro.lastNameError.value,
                                  hintText: 'Enter new lastname',
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          controllerpro.lastNameError.value !=
                                                  null
                                              ? Colors.red
                                              : Colors.grey,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          controllerpro.lastNameError.value !=
                                                  null
                                              ? AppColor.primaryColor
                                              : AppColor.purple3,
                                      width: 2.0,
                                    ),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    Text(
                      'Email:',
                      style: TextStyle(fontSize: 22),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Obx(
                            () => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                style: TextStyle(fontSize: 20),
                                controller: textController3,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  controllerpro.isEmailModified.value = true;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Enter new email',
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          controllerpro.emailError.value != null
                                              ? Colors.red
                                              : Colors.grey,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          controllerpro.emailError.value != null
                                              ? AppColor.primaryColor
                                              : AppColor.purple3,
                                      width: 3.0,
                                    ),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 2.0,
                                    ),
                                  ),
                                  errorText: controllerpro.emailError.value,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 80.0, right: 80, top: 50),
                        child: CustomButton(
                            textButton: 'Save',
                            onTap: () {
                              controllerpro.updatedUser(
                                  textController.text,
                                  textController2.text,
                                  textController3.text,
                                  controllerpro.myfile,
                                  controllerpro.imageKey);
                              controller.fetchProfile();
                            })
                        //  ElevatedButton(
                        //   onPressed: () {
                        //     //controllerpro.firstNameError.isEmpty ==false

                        //     controllerpro.updatedUser(
                        //         textController.text,
                        //         textController2.text,
                        //         textController3.text,
                        //         controllerpro.myfile,
                        //         controllerpro.imageKey);
                        //     controller.fetchProfile();

                        //     //  Get.back();
                        //     // Close the dialog
                        //   },
                        //   child: Center(
                        //       child: Text(
                        //     'Save',
                        //     style: TextStyle(color: Colors.white, fontSize: 20),
                        //   )),
                        //   style: ElevatedButton.styleFrom(
                        //       backgroundColor: Colors.deepPurple),
                        // ),
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
