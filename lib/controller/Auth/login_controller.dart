import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:learning_managment_system/core/class/statusrequest.dart';
import 'package:learning_managment_system/core/constant/routes.dart';
import 'package:learning_managment_system/core/constant/url.dart';
import 'package:learning_managment_system/core/functions/checkinternet.dart';
import 'package:learning_managment_system/core/functions/handlingdata.dart';
import 'package:learning_managment_system/data/datasource/remote/auth/logindata.dart';
import 'package:learning_managment_system/services/services.dart';

abstract class LoginController extends GetxController
    with GetTickerProviderStateMixin {
  login();
  showPassword();
  toggleAnimation();
  logout();
}

class LoginControllerImp extends LoginController {
  AnimationController? animationController;
  LoginData loginData = LoginData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;
  bool isShowPassword = true;
  IconData suffixIconAuth = Icons.visibility_off_outlined;
  final isPlaying = false.obs;

  String? deviceToken;



  @override
  void onInit() async{
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    animationController?.repeat();


    email=TextEditingController();
    password=TextEditingController();

    await initNotifications();
    super.onInit();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    animationController?.dispose();
    super.onClose();
  }

  @override
  void toggleAnimation() {
    isPlaying.toggle();
    isPlaying.value
        ? animationController?.forward()
        : animationController?.stop();
  }

  final _firebaseMessaging=FirebaseMessaging.instance;
  Future <void> initNotifications()async{
    await _firebaseMessaging.requestPermission();
    final fCMtoken=await _firebaseMessaging.getToken();
    deviceToken=fCMtoken;
    print('Device Token :'+fCMtoken.toString());
    print('deviceTooooooooken $deviceToken');
  }
  
  @override
  login() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      try {
        if(deviceToken.isNull){deviceToken='koko';}
      print('deviceTooooooooken loooooogIn $deviceToken');
        var response = await loginData.postData( email.text, password.text , deviceToken!);
         statusRequest = handlingData(response);
        if (statusRequest == StatusRequest.success) 
        {
          if (response['message'] == 'Student logged in successfully.')
           {
             String accessToken=response['access_token'];
             String userName=response['Student']['first_name'];
             String fullName=response['Student']['first_name'] +' '+response['Student']['last_name'] ;
              print('access_tokeeeeeeen login $accessToken');
              print('first_nameeeeeeeeeee login $userName');
               print('full_nameeeeeeeeeee login $fullName');
               myServices.sharedPreferences.setString('access_token' , accessToken );
               myServices.sharedPreferences.setString('user name' , userName );
               myServices.sharedPreferences.setString('full name' ,fullName );
              Get.defaultDialog(title: 'Welcome', content: Text(response['message']));
              Future.delayed(const Duration(seconds:2), () {
            if (Get.isDialogOpen ?? false) {
           Get.back();
            }  });
           Future.delayed(const Duration(seconds:2), () {
            myServices.sharedPreferences.setBool('canGoToHome', true);
             Get.offAllNamed(AppRoute.navbar);
          });
           }
           else if (response['message'] == 'Validation error') {
            String errorMessages = '';
            if (response['errors'] != null) {
              response['errors'].forEach((key, value) {
                errorMessages += value.join('\n') + '\n';
              });
            }
            Get.defaultDialog(
                title: response['message'],
                content: Text(errorMessages.isNotEmpty
                    ? errorMessages
                    : 'An error occurred.'));
            statusRequest = StatusRequest.failure;
          } else {
            Get.defaultDialog(
                title: 'Warning',
                content: Text(response['message'] ?? 'An error occurred.'));
            statusRequest = StatusRequest.failure;
          }
        }
      } catch (e) {
        statusRequest = StatusRequest.failure;
        Get.defaultDialog(
            title: 'Error', content: Text('An error occurred: $e'));
      }
      update();
    }
  }

  @override
  showPassword() {
    if (isShowPassword == true) {
      isShowPassword = false;
      suffixIconAuth = Icons.visibility_outlined;
      update();
    } else if (isShowPassword == false) {
      isShowPassword = true;
      suffixIconAuth = Icons.visibility_off_outlined;
      update();
    }
  }

  @override
  logout() async {
    statusRequest = StatusRequest.loading;
    update();
    String? token = myServices.sharedPreferences.getString('access_token');
    try {
      if (await checkInternet()) {
        Map<String, String> headers = {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        };
        Uri url = Uri.parse(AppUrl.logOutUrl);
        http.Response response = await http.get(url, headers: headers);
        Map responseBody = jsonDecode(response.body);
        print(responseBody);
        statusRequest = handlingData(response);
        if (statusRequest == StatusRequest.success) {
          Get.defaultDialog(title: responseBody['message'], content: Text(''));
          myServices.sharedPreferences.clear();
          Future.delayed(const Duration(seconds: 2), () {
            if (Get.isDialogOpen ?? false) {
              Get.back();
            }
          });
          Future.delayed(const Duration(seconds: 2), () {
            //Get.offAllNamed(AppRoute.onboarding);
           Get.toNamed(AppRoute.login);
          });
        }
      } else {
        StatusRequest.offlineFailure;
        update();
      }
    } catch (e) {
      // ignore: avoid_print
      print('error when getting data logout $e');
    }
  }
}
