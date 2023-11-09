import 'package:base/config/routes/routes_name.dart';
import 'package:base/view/details/detail_view.dart';
import 'package:base/view/home/home_view.dart';
import 'package:get/get.dart';

class RoutesPage {
  final pages = [
    GetPage(
      name: RoutesName.home,
      page: () => HomeView(),
    ),
  ];
}
