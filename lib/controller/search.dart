import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:learning_managment_system/core/constant/url.dart';
import 'package:learning_managment_system/model/courses/subcoursesmodel.dart';
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
  var isloading = false.obs;
  var searchData = <Subcoursesmodel>[].obs;

  List<Subcoursesmodel> listdata = [];
  final String url = AppUrl.baseUrl;

  checkSearch(value) {
    if (value == "") {
      issearch.value = false;
    }
    update();
  }

  onSearchCourse() {
    issearch.value = true;
    searchCourse(search);
    update();
  }

  @override
  void onInit() {
    search = TextEditingController();
    searchCourse;

    HomeControllerImp();
    super.onInit();
    update();
  }

  searchCourse(search) async {
    try {
      isloading(true);

      issearch.value = true;
      String? token = myServices.sharedPreferences.getString('access_token');
      final response = await http
          .get(Uri.parse("$url/courses?search=${search!.text}"), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      print(response.statusCode);
      if (response.statusCode == 200) {
        print('searchtrue');

        listdata.clear();
        update();
        var jsonResponse = jsonDecode(response.body);
        //  update();
        listdata = List<Subcoursesmodel>.from(jsonResponse['courses']
            .map((model) => Subcoursesmodel.fromJson(model)));
        print(jsonResponse);
        update();
      } else {
        print('searchfalse');
        return CircleAvatar();
      }
    } finally {
      isloading(false);
      update();
    }
  }
}
