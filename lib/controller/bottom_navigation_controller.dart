import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  // ignore: non_constant_identifier_names
  var page_Index = 0.obs ;
  var textValue = 0.obs;

  void changeIndex(int index){
    page_Index.value = index;
  }

  void increaseValue(){
    textValue.value++;
  }
}
