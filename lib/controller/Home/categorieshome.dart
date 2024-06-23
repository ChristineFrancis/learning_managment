import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:learning_managment_system/core/constant/url.dart';
import 'package:learning_managment_system/data/model/home/categoriesmodle.dart';
import 'package:learning_managment_system/services/services.dart';

class CategoriesHomeController extends GetxController {
  final http.Client client = http.Client();
 
  final String url = AppUrl.categories;
  var categories = <Categories>[].obs;

MyServices myServices=Get.find();
  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  void fetchCategories() async {
    String? token = myServices.sharedPreferences.getString('access_token');
    final response = await client.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
    print("yes");
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("true");
      var jsonData = jsonDecode(response.body);
      categories.value = List<Categories>.from(
          jsonData['categories'].map((model) => Categories.fromJson(model)));
    } else {
      print("false");
    }
  }

  @override
  void onClose() {
    client.close();
    super.onClose();
  }
}
