import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:learning_managment_system/controller/favorite/myfavorite.dart';
import 'package:learning_managment_system/core/constant/url.dart';
import 'package:learning_managment_system/model/courses/subcoursesmodel.dart';

import '../../services/services.dart';

class FavouriteController extends GetxController {
  Map isFavourite = {};
  var subcoursesList = <Subcoursesmodel>[].obs;

  setFavourite(id, val) {
    bool myval = val != 0;
    isFavourite[id] = myval;

    update();
  }

  MyFavoriteController myFavoriteController = Get.find();

  final baseurl = AppUrl.baseUrl;

  MyServices myServices = Get.find();

  Future addFavorite(int courseid, String isFavorite) async {
    String? token = myServices.sharedPreferences.getString('access_token');
    final url = '$baseurl/courses/$courseid';
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: {'is_favorite': isFavorite = '1'},
      );
      print(courseid);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);
        final data = json.decode(response.body);
        showCustomSnackbar(
            "Notic", 'Add this course to your favourite is done ');
        print(data['message']);
        update();
      } else {
        throw Exception('Failed to update favorite status');
      }
    } catch (e) {
      print('Error occurred: $e');
      Get.rawSnackbar(
        title: "Error",
        message: 'Failed to update favorite status: $e',
      );
    }
    myFavoriteController.fetchfavoritedata();
  }

  Future removeFavorite(int courseid, String isFavorite) async {
    String? token = myServices.sharedPreferences.getString('access_token');
    final url = '$baseurl/courses/$courseid';
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: {'is_favorite': isFavorite = '0'},
      );

      print(response.body);
      print(courseid);
      print(response.statusCode);

      if (response.statusCode == 200) {
        subcoursesList.refresh();
        // var jsonData = jsonDecode(response.body);

        final data = json.decode(response.body);
        showCustomSnackbar(
            "Notic", 'Remove this course from your favourite is done ');
        print(data['message']);
        update();
      } else {
        throw Exception('Failed to update favorite status');
      }
      update();
    } finally {}
    myFavoriteController.fetchfavoritedata();
  }

  void showCustomSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white.withOpacity(0.4),
      colorText: Colors.black,
      duration: Duration(seconds: 3),
    );
  }
}
