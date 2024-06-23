import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:learning_managment_system/core/constant/url.dart';
import 'package:learning_managment_system/model/home/searchmodel.dart';
import 'package:learning_managment_system/services/services.dart';

class HomeController extends GetxController {
  var tabIndex = 0.obs;
  
 

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}

@override
void onInit() {
  HomeControllerImp();
  onInit();
}

MyServices myServices = Get.find();



class HomeControllerImp extends HomeController {
  

  String? name = myServices.sharedPreferences.getString('user name');

  TextEditingController? search;

  RxBool issearch = false.obs;

  var searchData = <SearchModel>[].obs;

  final String url = AppUrl.home;
  Future<void> searchCourse(String searchC) async {
    if (searchC.isEmpty) {
      searchData.clear();
      return;
    }
    issearch.value = true;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print('mmm');
      Iterable jsonResponse = jsonDecode(response.body);
      searchData.value =
          jsonResponse.map((model) => SearchModel.fromJson(model)).toList();
    } else {
      print('object');
      searchData.value = [];
    }
    issearch.value = false;
  }

  checkSearch(value) {
    if (value == "") {
      issearch.value = false;
    }
    update();
  }

  onSearchCourse() {
    issearch.value = true;
    update();
  }

  @override
  void onInit() {
    search = TextEditingController();
    searchCourse;

    super.onInit();
  }
}
