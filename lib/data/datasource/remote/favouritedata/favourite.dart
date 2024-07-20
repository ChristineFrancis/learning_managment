import 'dart:convert';

import 'package:get/get.dart';
import 'package:learning_managment_system/core/constant/url.dart';
import 'package:http/http.dart' as http;
import 'package:learning_managment_system/services/services.dart';

final baseurl = AppUrl.baseUrl;

MyServices myServices = Get.find();

class FavouriteData {
  Future<void> updateFavoriteStatus(
    int subcourseIndex,
    bool isFavourite,
  ) async {
    String? token = myServices.sharedPreferences.getString('access_token');
    final url = '$baseurl/courses?categoryId=$subcourseIndex';
    final response = await http.put(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      body: {
        'is_favorite': isFavourite ? '1' : '0',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      print(data['message']);
    } else {
      throw Exception('Failed to update favorite status');
    }
  }
}
