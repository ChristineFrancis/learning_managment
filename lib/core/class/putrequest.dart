// import 'dart:convert';

// import 'package:dartz/dartz.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:learning_managment_system/core/class/statusrequest.dart';
// import 'package:learning_managment_system/core/constant/url.dart';
// import 'package:learning_managment_system/core/functions/checkinternet.dart';
// import 'package:learning_managment_system/services/services.dart';

// class PutRequest {
//   var url = AppUrl.favourite;
//   MyServices myServices = Get.find();
//   final http.Client client = http.Client();
//   var jsonData;
//   Future<Either<StatusRequest, Map>> putRequestApi(
//       String url, String token) async {
//     String? token = myServices.sharedPreferences.getString('access_token');
//   if (await checkInternet()) 
//     { 
//       Map<String,String> headers ={'':''};
//       if (token==null)
//       {
//         headers={ 'Content-Type': 'application/json', };

//       }
//       else 
//       {
//         headers= {'Accept': 'application/json',
//         'Authorization': 'Bearer $token'
//        };
//       }
//       print('heeeaders $headers');
      
//       var response = await http.put(Uri.parse(url), headers: headers);
//       //print('response from crud ${response.body}');
//       Map responseBody = jsonDecode(response.body);
//       print('response from crud jsonDecode ${response.body}');
      
//       return Right(responseBody);
//     } 
//     else
//      {
//       return const Left(StatusRequest.offlineFailure);
//     }
//   }
// }
