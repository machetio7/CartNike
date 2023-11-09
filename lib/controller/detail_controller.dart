import 'package:get/get.dart';

class DetailController extends GetxController {
  late String image;
  late String title;
  String carTag = "";

  updateCartTag() {
    carTag = '_tag';
    update();
  }
}
