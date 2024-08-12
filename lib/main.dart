import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:learning_managment_system/controller/Courses/coursecontroller.dart';
import 'package:learning_managment_system/controller/favorite/favoritecontroller.dart';
import 'package:learning_managment_system/controller/profile/profilegetdata.dart';
import 'package:learning_managment_system/core/class/postRequest.dart';
import 'package:learning_managment_system/core/constant/routes.dart';
import 'package:learning_managment_system/routes.dart';
import 'package:learning_managment_system/services/services.dart';
import 'package:learning_managment_system/view/screen/Auth/login.dart';
import 'package:learning_managment_system/view/screen/Splash/splash.dart';
import 'package:learning_managment_system/view/screen/aboutUs/aboutUs.dart';
import 'package:learning_managment_system/view/widget/Quiz/quest.dart';

void main() async {
  Get.put(ApiPostRequest());

  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ProfileControllerImp themeController = Get.put(ProfileControllerImp());
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      //  theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode:
          themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        fontFamily: 'Exo2',
        useMaterial3: true,
      ),
      initialRoute: AppRoute.splash,
      getPages: routes,
    );
  }
}
