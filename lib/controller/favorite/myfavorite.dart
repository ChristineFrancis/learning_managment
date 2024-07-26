import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:learning_managment_system/core/constant/url.dart';
import 'package:learning_managment_system/model/favouritemodel.dart';
import 'package:learning_managment_system/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/courses/subcoursesmodel.dart';

class MyFavoriteController extends GetxController {
  List<FavoriteModel> data = [];
  var favorite = <FavoriteModel>[].obs;
  var subcoursesList = <Subcoursesmodel>[].obs;
  MyServices myServices = Get.find();

  final String url = AppUrl.favorite;

  SharedPreferences? prefs;
  @override
  void onInit() {
    fetchfavoritedata();
    super.onInit();
    update();
  }

  fetchfavoritedata() async {
    //  favorite.clear();
    String? token = myServices.sharedPreferences.getString('access_token');
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
    favorite.refresh;
    print("yesFavo");
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("...............$response");
      print("true");
      var jsonData = jsonDecode(response.body);
      favorite.value = List<FavoriteModel>.from(
          jsonData['favorites'].map((model) => FavoriteModel.fromJson(model)));
      // final Map<String, dynamic> parsed = json.decode(response.body);
      // final List<dynamic> favoritelist = parsed['favorites'];

      print(favorite);
      update();
    }
  }

}
