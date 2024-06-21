import 'package:get/get.dart';

class FavoriteController extends GetxController {
  Map isFavorite = {};
  setFavorite(id, val) {
    isFavorite[id] = val;
    update();
  }
}
