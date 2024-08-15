
import 'dart:io';

import 'package:learning_managment_system/core/class/postRequest.dart';
import 'package:learning_managment_system/core/constant/url.dart';

class SignupData{

  ApiPostRequest apiPostRequest;
  SignupData(this.apiPostRequest);

  postData(String firstName , String lastName ,String email , String password , String confirmPassword , File? imageFile , String deviceToken)async
  {
    print('deviceToooooooooooooooooooooooooooooken from postData $deviceToken');
    var response=await apiPostRequest.postRequestWithImage(
      AppUrl.signUpUrl,
      {'first_name':firstName,
      'last_name':lastName,
      'email':email,
      'password':password,
      'password_confirmation':confirmPassword ,
       'deviceToken': deviceToken},
       imageFile,
       'image',
        null
      );
     return response.fold(
      (ifLeft) =>ifLeft,
      (ifRight) => ifRight,
    );
  }
}