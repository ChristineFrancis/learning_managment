import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:learning_managment_system/core/constant/url.dart';
import 'package:learning_managment_system/model/home/latestmodel.dart';

import 'package:http/http.dart' as http;
import 'package:learning_managment_system/services/services.dart';

class LatestController extends GetxController {
  var alllatest = <Latest>[].obs;
  var displayLatest = <Latest>[].obs;
  int itemsDisplayed = 3;
 
  final String url = AppUrl.latest;

MyServices myServices=Get.find();
  @override
  void onInit() {
    fetchLatest();
    super.onInit();
  }

  void fetchLatest() async {
    String? token = myServices.sharedPreferences.getString('access_token');
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
    print("yeslllllllll");
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("truellllll");
      final Map<String, dynamic> parsed = json.decode(response.body);
      final List<dynamic> courseslistl = parsed['latest'];

      alllatest.value =
          courseslistl.map((json) => Latest.fromJson(json)).toList();

      addmorelatest();
    } else {
      print("false");
      throw Exception("failed");
    }
  }

  void addmorelatest() {
    if (itemsDisplayed >= alllatest.length) {
      displayLatest.value = List.from(alllatest);
    } else {
      displayLatest.value = List.from(alllatest.take(itemsDisplayed));
    }
  }

  void showMore() {
    itemsDisplayed += 5;
    addmorelatest();
  }
}
