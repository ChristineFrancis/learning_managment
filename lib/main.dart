import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:learning_managment_system/core/class/postRequest.dart';
import 'package:learning_managment_system/core/constant/routes.dart';
import 'package:learning_managment_system/routes.dart';
import 'package:learning_managment_system/services/services.dart';
import 'package:learning_managment_system/view/screen/Auth/login.dart';
import 'package:learning_managment_system/view/screen/aboutUs/aboutUs.dart';
import 'package:learning_managment_system/view/widget/Quiz/quest.dart';

void main() async{
   Get.put(ApiPostRequest());
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Exo2', 
        useMaterial3: true,
      ),
      //home: QuizPage(),
      //home: LoginPage(),
      initialRoute:AppRoute.splash ,
      getPages: routes,
    );
  }
}



