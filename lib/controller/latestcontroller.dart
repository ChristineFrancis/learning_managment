import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:learning_managment_system/data/model/model/latestmodel.dart';

import 'package:http/http.dart' as http;

class LatestController extends GetxController {
  var alllatest = <Latest>[].obs;
  var displayLatest = <Latest>[].obs;
  int itemsDisplayed = 3;
  final String token = '4|BL5Gs1OPovK0UaiFdfxqr1SFltsddOBmfodtgVMYce9913dc';
  final String url = 'http://192.168.1.4:8000/api/v1/students/home';

  @override
  void onInit() {
    fetchLatest();
    super.onInit();
  }

  void fetchLatest() async {
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
    print("yes");
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("true");
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
