import 'package:get/get.dart';

class FavoriteController extends GetxController {
  var isFavorited = false.obs;

  void toggleFavorite() {
    isFavorited.value = !isFavorited.value;
  }
}
