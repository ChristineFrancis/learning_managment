import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_managment_system/core/class/statusrequest.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:learning_managment_system/core/constant/routes.dart';
import 'package:learning_managment_system/core/functions/handlingdata.dart';
import 'package:learning_managment_system/data/datasource/remote/auth/signupdata.dart';
import 'package:learning_managment_system/services/services.dart';

abstract class SignUpController extends GetxController with GetTickerProviderStateMixin
 { 
  signUp();
  showPassword();
  showConfirmPassword();
  toggleAnimation();
  galleryorCamera();
 }

 class SignUpControllerImp extends SignUpController{
  //animation:
  AnimationController? animationController;
  final isPlaying = false.obs;

  //api:
  SignupData signupData=SignupData(Get.find());
  StatusRequest statusRequest=StatusRequest.none;
  MyServices myServices=Get.find();
  
  //fields:
   GlobalKey<FormState> formState=GlobalKey<FormState>();
   late TextEditingController firstName;
   late TextEditingController lastName;
   late TextEditingController email;
   late TextEditingController password;
   late TextEditingController confirmPassword;
  bool isShowPassword=true;
  IconData passwordIconAuth=Icons.visibility_off_outlined;
  bool isShowConfirmPassword=true;
  IconData confirmPasswordIconAuth=Icons.visibility_off_outlined; 
  
  //photo
   Uint8List? image;
   File? myfile;
  
  @override
  void onInit() 
  {
    animationController = AnimationController(
    vsync: this, duration: const Duration(milliseconds: 1000));
    animationController?.repeat();

    email=TextEditingController();
    password=TextEditingController();
    firstName=TextEditingController();
    lastName=TextEditingController();
    confirmPassword=TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  } 
  @override
  void toggleAnimation() {
    isPlaying.toggle();
    isPlaying.value ? animationController?.forward() : animationController?.stop();
  }

  @override
  signUp() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      try {
        var response = await signupData.postData( firstName.text, lastName.text, email.text, password.text, confirmPassword.text, myfile );
         statusRequest = handlingData(response);
        if (statusRequest == StatusRequest.success) 
        {
          if (response['message'] == 'Code has been sent')
           {
             String accessToken=response['access_token'];
              print('access_tokeeeeeeen sign up $accessToken');
               myServices.sharedPreferences.setString('access_token' , accessToken );
               myServices.sharedPreferences.setString('user name' , firstName.text );
              myServices.sharedPreferences.setString('full name' , firstName.text + ''+lastName.text );
              String? fullname=myServices.sharedPreferences.getString('full name');
              String? name=myServices.sharedPreferences.getString('user name');
              print(fullname);
              print(name);
               
              Get.defaultDialog(title: 'Welcome', content: Text(response['message'] ,) , titleStyle: const TextStyle(color: AppColor.primaryColor, fontSize: 25 ) );
            Future.delayed(const Duration(seconds:2), () {
            if (Get.isDialogOpen ?? false) {
           Get.back();
            }  });
           Future.delayed(const Duration(seconds:2), () {
             Get.toNamed(AppRoute.checkEmail);
          });
           }
           else if (response['message'] == 'Validation error') {
            String errorMessages = '';
            if (response['errors'] != null) {
              response['errors'].forEach((key, value) {
                errorMessages += value.join('\n') + '\n';
              });
            }
            Get.defaultDialog(title: response['message'], content: Text(errorMessages.isNotEmpty ? errorMessages : 'An error occurred.'), titleStyle: const TextStyle(color: AppColor.primaryColor, fontSize: 25));
            statusRequest = StatusRequest.failure;
          } else {
            Get.defaultDialog(title: 'Warning', content: Text(response['message'] ?? 'An error occurred.'),titleStyle: const TextStyle(color: AppColor.primaryColor, fontSize: 25));
            statusRequest = StatusRequest.failure;
          }
        } 
        
      } catch (e) {
        statusRequest = StatusRequest.failure;
        // ignore: avoid_print
        print(' An errooooooooooooooooooooooooooor occurred: $e');
      }
      update();
    }
  }

  @override
  showPassword( ) {
    if(isShowPassword==true)
    {
      isShowPassword=false;
       passwordIconAuth=Icons.visibility_outlined;
      update();
    }
    else if(isShowPassword==false)
    {
      isShowPassword=true;
      passwordIconAuth=Icons.visibility_off_outlined;
      update();
    }
  }
  
  @override
  showConfirmPassword() {
     if(isShowConfirmPassword==true)
    {
      isShowConfirmPassword=false;
       confirmPasswordIconAuth=Icons.visibility_outlined;
      update();
    }
    else if(isShowConfirmPassword==false)
    {
      isShowConfirmPassword=true;
      confirmPasswordIconAuth=Icons.visibility_off_outlined;
      update();
    }    
  }
  
  @override
  galleryorCamera() {
    Get.bottomSheet(
  backgroundColor: AppColor.whiteColor,
      SizedBox( 
          width:Get.size.width,
          height:Get.size.height/4 , 
          child: Column(crossAxisAlignment : CrossAxisAlignment.start,
            children: [
               const Padding(
                 padding: EdgeInsets.all(15.0),
                 child: Text('Choose:' , style: TextStyle(fontSize: 30 , fontWeight:FontWeight.bold , color:AppColor.primaryColor  ),),
               ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(onPressed: ()async{
                    XFile? xfile= await ImagePicker().pickImage(source: ImageSource.gallery );
                    if (xfile==null) return;
                     
                      myfile = File(xfile!.path);
                      image=File(xfile.path).readAsBytesSync();
                    update();
                    Get.back();
                    
                  } , 
                  child: const Column(
                    children: [ 
                      Icon(Icons.image_outlined , size: 40, color:AppColor.primaryColor  ),
                      Text('Gallery' , style: TextStyle(fontSize:18 , color:AppColor.primaryColor  ),),
                    ],
                  ),),
                  MaterialButton(onPressed: ()async{
                    XFile? xfile= await ImagePicker().pickImage(source: ImageSource.camera );
                    if (xfile==null) return;
                     
                      myfile = File(xfile.path);
                      image=File(xfile.path).readAsBytesSync();
                   update();
                    // ignore: use_build_context_synchronously
                    Get.back();
                    
                  } , 
                  child: const Column(
                    children: [ 
                      Icon(Icons.camera_alt_outlined , size: 40, color:AppColor.primaryColor ),
                      Text('Camera' , style: TextStyle(fontSize:18  , color:AppColor.primaryColor ),),
                    ],
                  ),),

                  MaterialButton(
                    onPressed: (){
                    image=null;
                     update();
                      Get.back(); } , 
                    child: const Column(
                      children: [ 
                        Icon(Icons.delete_outline , size: 40, color:AppColor.primaryColor ),
                        Text('Remove' , style: TextStyle(fontSize:18  , color:AppColor.primaryColor ),),
                      ],
                    ),),
              ],
            ),
        
          ],),
        ), 
    );
  }




}
