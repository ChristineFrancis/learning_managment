import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/bottom_navigation_controller.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/functions/alertexit.dart';
import 'package:learning_managment_system/view/screen/chatAi/ebefore_chat.dart';
import 'package:learning_managment_system/view/screen/favoritepage.dart';
import 'package:learning_managment_system/view/screen/homepage.dart';
import 'package:learning_managment_system/view/screen/quiz/course_details.dart';


// ignore: must_be_immutable, camel_case_types
class Curved_NB extends StatelessWidget {
   Curved_NB({super.key});
  int page = 0;
  BottomNavigationController bottomNavigationController = Get.put(BottomNavigationController());

  final screens = [
    
   HomePage(),
   Icon(Icons.home),
  //CourseDetails(),
  FavoriteScreen(),
  BeforeChatAi(),
  Icon(Icons.home),
    
  ];
  final items= const [
    Icon(
      Icons.home,
      size: 25,
      color: Colors.white,
    ),
    Icon(
      Icons.add,
      size: 25,
      color: Colors.white,
    ),
    Icon(
      Icons.favorite,
      size: 25,
      color: Colors.white,
    ),
    Icon(
      Icons.message_outlined,
      size: 25,
      color: Colors.white,
    ),
    Icon(
      Icons.person,
      size: 25,
      color: Colors.white,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: alertExit,
      child: Scaffold(
        body: Obx(
          () => IndexedStack(
            children: screens,
            index: bottomNavigationController.page_Index.value,
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: AppColor.primaryColor,
          color: AppColor.primaryColor,
          animationDuration:const Duration(milliseconds: 500),
          items: items,
          index: 0,
          onTap: (index) => {
            bottomNavigationController.changeIndex(index)
          },
        ),
      ),
    );
  }
}
