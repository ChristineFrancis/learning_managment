// import 'dart:io';

// import 'package:learning_managment_system/core/class/postRequest.dart';
// import 'package:learning_managment_system/core/class/postprofileapi.dart';
// import 'package:learning_managment_system/core/constant/url.dart';

// class ProfileData{

//    ApiProfile apiProfile;
//   ProfileData(this.apiProfile);

//   postData(String firstName , String lastName ,String email , File? imageFile )async
//   {
//     var response=await apiProfile.postRequestWithImage(
//       AppUrl.profile,
//       {'first_name':firstName,
//       'last_name':lastName,
//       'email':email,
//   },
//        imageFile,
//        'image',
//         null
//       );
//      return response.fold(
//       (ifLeft) =>ifLeft,
//       (ifRight) => ifRight,
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:learning_managment_system/core/constant/url.dart';
import 'package:learning_managment_system/services/services.dart';

MyServices myServices = Get.find();

String? token = myServices.sharedPreferences.getString('access_token');

class ApiService {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  static updateProfile({
    required String firstName,
    required String lastName,
    required String email,
    //File? profilePicture,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(AppUrl.updateprofile),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $token', // Include token if authentication is required
        },
        body: json.encode({
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
        }),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        // Handle successful response
        print('Profile updated successfully');
        Get.snackbar('Success', 'Profile updated successfully');
      } else {
        // Handle error response
        print('Failed to update profile');
        Get.snackbar('Error', 'Failed to update profile');
      }
    } catch (e) {
      // Handle any exceptions
      print('Exception: $e');
      Get.snackbar('Error', 'An error occurred while updating profile');
    }
  }
}
    
  