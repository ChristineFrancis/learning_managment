import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:learning_managment_system/data/model/model/categoriesmodle.dart';


class CategoriesHomeController extends GetxController {
  final http.Client client = http.Client();
  final String token = '4|BL5Gs1OPovK0UaiFdfxqr1SFltsddOBmfodtgVMYce9913dc';
  final String url = 'http://192.168.1.4:8000/api/v1/students/home';
  var categories = <Categories>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  void fetchCategories() async {
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
