import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/core/class/darkmode.dart';
import 'package:learning_managment_system/services/services.dart';


class DarkModeController extends GetxController{
  bool  isDarkMode () {update();
    return Get.isDarkMode;}
  
  ThemeData? theme;
  MyServices myServices=Get.find();
  changeTheme(bool dark)
  {
    myServices.sharedPreferences.setBool('darkMode', !dark);
    if (dark)
    {Get.changeTheme(Themes.CustomLight);}
    else
    {Get.changeTheme(Themes.CustomDark);}
    update();
  }

  @override
  void onInit() {
    bool?  darkMode=myServices.sharedPreferences.getBool('darkMode');
    if(darkMode==false)
    {theme=Themes.CustomLight;}
    else  if(darkMode==true)
    {theme=Themes.CustomDark;}
    else
     {darkMode=false;
      theme=Themes.CustomLight;}
    super.onInit();
  }
  void updateMode(){update();}
}