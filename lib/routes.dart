import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:learning_managment_system/core/constant/routes.dart';
import 'package:learning_managment_system/middleware/middleware.dart';
import 'package:learning_managment_system/view/screen/Auth/check_email.dart';
import 'package:learning_managment_system/view/screen/Auth/forget_password.dart';
import 'package:learning_managment_system/view/screen/Auth/login.dart';
import 'package:learning_managment_system/view/screen/Auth/reset_password.dart';
import 'package:learning_managment_system/view/screen/Auth/sign_up.dart';
import 'package:learning_managment_system/view/screen/curved_NavigationBar.dart';
import 'package:learning_managment_system/view/screen/onboarding.dart';
import 'package:learning_managment_system/view/screen/splash.dart';


List<GetPage<dynamic>> routes=
[
  GetPage(name: AppRoute.signup, page:()=> const SignUpPage()),
  GetPage(name: AppRoute.login, page:()=> LoginPage()),
  GetPage(name: AppRoute.checkEmail, page:()=> const CheckEmailPage()),
  GetPage(name: AppRoute.onboarding, page:()=> OnBoarding()),
  GetPage(name: AppRoute.navbar, page:()=> Curved_NB()),
  GetPage(name: AppRoute.forgetPassword, page:()=> const ForgetPasswordPage()),
  GetPage(name: AppRoute.resetPassword, page:()=> ResetPasswordPage()),
  GetPage(name: AppRoute.splash, page:()=> Splash_Screen() ), 
];