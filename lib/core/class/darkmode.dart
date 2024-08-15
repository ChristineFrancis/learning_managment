import 'package:flutter/material.dart';
import 'package:learning_managment_system/core/constant/color.dart';


class Themes{
  // ignore: non_constant_identifier_names
  static ThemeData CustomDark=ThemeData.dark().copyWith(
    textTheme: TextTheme(displayLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w400 , color: AppColor.whiteColor),
   
    ) ,
     scaffoldBackgroundColor: AppColor.darkDarkModeColor ,
   // bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: AppColor.whiteColor, unselectedItemColor: AppColor.whiteColor,selectedItemColor: AppColor.primaryLightColor  ),
    appBarTheme: AppBarTheme(
      // color: AppColor.darkModeColor , 
      // titleTextStyle: TextStyle(color: AppColor.primaryLightColor ),
      // iconTheme:IconThemeData(color:AppColor.primaryLightColor  ) ),
      // colorScheme: ColorScheme(
      //   brightness: Brightness.dark, primary: AppColor.primaryLightColor,
      //   onPrimary:AppColor.darkModeColor , secondary: AppColor.primaryDarkColor, 
      //   onSecondary: AppColor.darkModeColor, error: AppColor.darkModeColor, 
      //   onError: AppColor.darkModeColor, surface: AppColor.primaryLightColor, 
      //   onSurface: AppColor.primaryLightColor,primaryContainer:AppColor.darkModeColor , 
      //   onSecondaryContainer:AppColor.darkModeColor, background: AppColor.backgroundHomeColor, 
      //   onBackground:AppColor.backgroundHomeColor 
        ),
      
    //iconTheme: IconThemeData(color: AppColor.primaryLightColor),

    );

// ignore: non_constant_identifier_names
static ThemeData CustomLight=ThemeData.light().copyWith(
    textTheme: TextTheme(displayLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w400,
   //  color: AppColor.blackColor
     ),
     bodyLarge: TextStyle(color: Colors.black), // Set text color to black
    bodyMedium: TextStyle(color: Colors.black),
    ),
    // bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: AppColor.searchColor,unselectedItemColor:AppColor.blackColor ,  selectedItemColor: AppColor.primaryDarkColor  ),
    // scaffoldBackgroundColor: AppColor.whiteColor,
    // appBarTheme: AppBarTheme(color: AppColor.backgroundAppbarColor),
    // colorScheme: ColorScheme(brightness: Brightness.light, primary: AppColor.primaryLightColor, 
    // onPrimary:AppColor.searchColor , secondary: AppColor.primaryDarkColor, onSecondary: AppColor.whiteColor, 
    // error: AppColor.searchColor, onError: AppColor.searchColor, surface:Colors.black, 
    // onSurface: Colors.black,primaryContainer:AppColor.primaryLightColor, onSecondaryContainer:AppColor.whiteColor, 
    // background: AppColor.blackColor, onBackground: AppColor.backgroundAppbarColor    ),
    );


}