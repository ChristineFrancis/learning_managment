import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:learning_managment_system/controller/Auth/signup_controller.dart';
import 'package:learning_managment_system/controller/Quiz/quiz_controller.dart';
import 'package:learning_managment_system/controller/Quiz/quiz_videos_controller.dart';
import 'package:learning_managment_system/core/class/postRequest.dart';
import 'package:learning_managment_system/core/constant/routes.dart';
import 'package:learning_managment_system/firebase/firebase_api.dart';
import 'package:learning_managment_system/firebase_options.dart';
import 'package:learning_managment_system/routes.dart';
import 'package:learning_managment_system/services/services.dart';

void main() async {
  Get.put(ApiPostRequest());
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  await SignUpControllerImp().initNotifications();
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
      initialRoute:AppRoute.splash ,
      getPages: routes,
    );
  }
}
