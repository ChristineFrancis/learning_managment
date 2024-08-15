import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:learning_managment_system/core/constant/url.dart';
import 'package:learning_managment_system/model/courses/coursemodel.dart';
import 'package:learning_managment_system/model/home/categoriesmodle.dart';
import 'package:learning_managment_system/services/services.dart';

class CategoriesHomeController extends GetxController {
  final http.Client client = http.Client();
  // goToCourses(List categoriescourse,int selectedCat);
  final String url = AppUrl.categories;
  var categories = <Categories>[].obs;
//List categories = [];
  //int? selectedCat;
  CoursesModel? courses;
  var selectedCat = 1.obs;
  MyServices myServices = Get.find();
  // void updateCat(int parentId) {
  //   selectedCat.value = parentId;
  //   fetchCategories();
  // }

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
    //categories.value = response;
    print("yes");
    print(response.statusCode);
    if (response.statusCode == 200) {
      // selectedCat.value = categories[0].id!;
      print(response);

      print("true44444");
      print(token);
      var jsonData = jsonDecode(response.body);

      categories.value = List<Categories>.from(
          jsonData['categories'].map((model) => Categories.fromJson(model)));
    } else {
      print("false");
    }
    update();
  }

  @override
  void onClose() {
    client.close();
    super.onClose();
  }

  // goToCourses( ) {
  //  Get.toNamed( AppRoute.category,
  //Get.to(()=>CoursesScreen(),
  //  arguments: {
  // "categories": categories,
  //"selectedcat": selectedCat
  //}
  //   );
  // }
}
