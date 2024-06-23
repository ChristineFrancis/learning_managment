import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:learning_managment_system/core/constant/url.dart';
import 'package:learning_managment_system/data/model/home/recommendemodel.dart';
import 'package:learning_managment_system/services/services.dart';

class RecomendeController extends GetxController {
  
  var isVisible1 = true.obs;
  var isVisible2 = false.obs;

  void showSecond() {
    isVisible1.value = false;
    isVisible2.value = true;
  }

  var allrecommendedCourses = <Recommended>[].obs;
  var displayRecommended = <Recommended>[].obs;

  int itemsDisplayed = 3;

  MyServices myServices = Get.find();
  
  // final String token = '4|BL5Gs1OPovK0UaiFdfxqr1SFltsddOBmfodtgVMYce9913dc';
  final String url = AppUrl.recommended;


  @override
  void onInit() {
    fetchRecommendedCourses();
    super.onInit();
  }

  void fetchRecommendedCourses() async {
    String? token = myServices.sharedPreferences.getString('access_token');
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
    print("yes");
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("true");
      final Map<String, dynamic> parsed = json.decode(response.body);
      final List<dynamic> courseslist = parsed['recommended'];

      allrecommendedCourses.value =
          courseslist.map((json) => Recommended.fromJson(json)).toList();

      addmoreRecommended();
    } else {
      print("false");
      throw Exception("failed");
    }
  }

  void addmoreRecommended() {
    if (itemsDisplayed >= allrecommendedCourses.length) {
      displayRecommended.value = List.from(allrecommendedCourses);
    } else {
      displayRecommended.value =
          List.from(allrecommendedCourses.take(itemsDisplayed));
    }
  }

  void showMore() {
    itemsDisplayed += 5;
    addmoreRecommended();
  }
}
