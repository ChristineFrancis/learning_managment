import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learning_managment_system/core/class/statusrequest.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/functions/handlingdata.dart';
import 'package:learning_managment_system/data/datasource/remote/contactUs/contactUs_data.dart';
import 'package:learning_managment_system/services/services.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class ContactUsController extends GetxController
{
  sendMessage();
  goUrl(Uri url);
  
}
class ContactUsControllerImp extends ContactUsController
{
  StatusRequest statusRequest=StatusRequest.none;
   MyServices myServices=Get.find();
   ContactUsData contactUsData=ContactUsData(Get.find());
  GlobalKey<FormState> formState=GlobalKey<FormState>();
  late TextEditingController message;
  final Uri telegramUrl = Uri.parse('https://t.me/ChristineFrancis28');
  final Uri facebookUrl = Uri.parse('https://www.facebook.com/christine.francis.5264?mibextid=ZbWKwL');
  final Uri emailUrl = Uri.parse('https://kokofrancis2003@gmail.com');
  @override
  void onInit() {
    message=TextEditingController();
    super.onInit();
  }
  
  @override
  sendMessage()async 
  {
    var formData = formState.currentState;
    if (formData!.validate()) {
      print(message.text);
      statusRequest = StatusRequest.loading;
      update();
      try {
         String? token= myServices.sharedPreferences.getString('access_token');
        var response = await contactUsData.postMessage( message.text , token);
         statusRequest = handlingData(response);
        if (statusRequest == StatusRequest.success) 
        {
          if (response['message'] == 'Issue sent successfully.')
           {
            Get.snackbar('DONE', 'Your message has been sent successfully.',
             snackPosition: SnackPosition.BOTTOM, backgroundColor: AppColor.primaryColor, colorText: AppColor.whiteColor);
           }
           else {
            print('erooooooor ${response}');
            Get.snackbar( 'Warning', response['errors']['description']?? 'An error occurred.');
            statusRequest = StatusRequest.failure;
          }
        }
      }
      catch (e) {
        statusRequest = StatusRequest.failure;
        Get.defaultDialog(title: 'Error', content: Text('An error occurred: $e'));
      }
      update();
      
      }
    
  }
 // @override
  Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }}
  
  @override
  goUrl(Uri url) {
    _launchUrl(url);
  }
}