import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:learning_managment_system/core/class/statusrequest.dart';
import 'package:learning_managment_system/core/constant/url.dart';
import 'package:learning_managment_system/core/functions/checkinternet.dart';
import 'package:learning_managment_system/model/profile/profileupdatemodel.dart';
import 'package:learning_managment_system/model/profile/proflemodel.dart';
import 'package:learning_managment_system/services/services.dart';

// class ApiProfile {
//   //final http.Client client = http.Client();
//   MyServices myServices = Get.find();
//   Future<bool> updateProfile({
//     required String firstName,
//     required String lastName,
//     required String email,
//    // File? profilePicture,
//   }) async {
//     try{ String? token = myServices.sharedPreferences.getString('access_token');
//     var response = await http.post(
//       Uri.parse(AppUrl.profile),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Accept': 'application/json',
//       },
//       res.fields['first_name'] = firstName;
//       request.fields['last_name'] = lastName;
//       request.fields['email'] = email;
//       body: jsonEncode(<String, String>{
//         'FirstName': firstName,
//         'LastName': lastName,
//         'Email': email
//       }),
//     );

//     if (response.statusCode == 200) {
//       // نجاح
//       return true;
//     } else {
//       // فشل
//       return false;
//     }}

//   }
// }
MyServices myServices = Get.find();
String? token = myServices.sharedPreferences.getString('access_token');

class ApiProfile {
  // static Future<UpdateStudent?> updateProfile({
  //   required String firstName,
  //   required String lastName,
  //   required String email,
  //   // Map data, File? imageFile ,String imageKey,
  //   // File? profilePicture,
  // }) async {
  //   //    String? token = myServices.sharedPreferences.getString('access_token');
  //   try {
  //     var uri = Uri.parse(AppUrl.profile);
  //     var request = http.MultipartRequest('POST', uri);
  //     print('doneeeeeeeeeeeeeeeeeeeee');

  //     var response1 = await http.post(
  //       Uri.parse(AppUrl.profile),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Accept': 'application/json',
  //       },
  //     );

  //     //request.headers['Authorization'] = 'Bearer $token';
  //     request.fields['first_name'] = firstName;
  //     request.fields['last_name'] = lastName;
  //     request.fields['email'] = email;

  //     // if (profilePicture != null) {
  //     //   request.files.add(await http.MultipartFile.fromPath(
  //     //     'profile_picture',
  //     //     profilePicture.path,
  //     //     filename: basename(profilePicture.path),
  //     //   ));
  //     // }

  //     //var response1 = await request.send();
  //     print(response1.statusCode);
  //     if (response1.statusCode == 200) {
  //       //  var responseData = await response1.stream.bytesToString();
  //       var jsonData = jsonDecode(response1.body);
  //       return UpdateStudent.fromJson(jsonData['data']);
  //     } else {
  //       print('Failed to update profile: ${response1.reasonPhrase}');
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Error updating profile: $e');
  //     return null;
  //   }
  // }
   Future<Either<StatusRequest, Map>> postRequestWithImage( String url, Map data, File? imageFile ,String imageKey ,  String? token) async {
        if (await checkInternet()) 
    {
   // final url = Uri.parse(url);
    Map<String,String> headers ={'':''};
      if (token==null)
      {
        headers={ 'Content-Type': 'application/json', };

      }
      else 
      {
        headers= {'Accept': 'application/json',
        'Authorization': 'Bearer $token'
       };
      }
      print('heeeaders upload Photo $headers');
    var request = http.MultipartRequest('POST', Uri.parse(url) );
    request.headers;
    print('requesttttttttttt $request');

    data.forEach((key, value) {
      request.fields[key] = value;
    });
    
    if (imageFile != null) 
    {
      request.files.add(await http.MultipartFile.fromPath(imageKey, imageFile.path));
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
     Map responseBody = jsonDecode(response.body);
    print(response.body);
    return Right(responseBody);
     } 
    else
     {
      return const Left(StatusRequest.offlineFailure);
    }
  }

}
