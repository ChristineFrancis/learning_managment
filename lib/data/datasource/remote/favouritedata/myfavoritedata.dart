// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'package:get/get.dart';
// import 'package:learning_managment_system/core/constant/url.dart';
// import 'package:learning_managment_system/data/model/favouritemodel.dart';
// import 'package:learning_managment_system/services/services.dart';

// class MyfavoriteData {
//   var favorite = <FavoriteModel>[].obs;

//   MyServices myServices = Get.find();

//   final String url = AppUrl.favorite;

//   onInit() {
//     fetchfavoritedata();
//     onInit();
    
//   }

//   fetchfavoritedata() async {
//     String? token = myServices.sharedPreferences.getString('access_token');
//     final response = await http.get(Uri.parse(url), headers: {
//       'Authorization': 'Bearer $token',
//       'Accept': 'application/json',
//     });
//     print("yesFavo");
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       print("true");
//       final Map<String, dynamic> parsed = json.decode(response.body);
//       final List<dynamic> favoritelist = parsed['favorites'];

//       favorite.value =
//           favoritelist.map((json) => FavoriteModel.fromJson(json)).toList();

//       } else {
//         print("false");
//         throw Exception("failed");
//     }
    
//   }

// }
