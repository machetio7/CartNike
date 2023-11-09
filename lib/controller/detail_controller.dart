import 'package:get/get.dart';

class DetailController extends GetxController {
  late String image;
  late String title;
  String cartTag = "";

  updateCartTag() {
    cartTag = '_tag';
    update();
  }
}
