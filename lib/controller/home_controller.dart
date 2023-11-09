import 'package:base/model/product.dart';
import 'package:base/model/productItem.dart';
import 'package:get/get.dart';

enum HomeState { normal, cart }

class HomeController extends GetxController {
  HomeState homestate = HomeState.normal;
  List<ProductItemI> cart = [];

  void changeHomeState(HomeState state) {
    homestate = state;
    update();
  }

  void productAdd(Product product) {
    for (ProductItemI item in cart) {
      if (item.product!.title == product.title) {
        item.increment();
        update();
        return;
      }
    }
    cart.add(ProductItemI(product: product));
    update();
  }

  int totalCartItems() => cart.fold(
      0, (previousValue, element) => previousValue + element.quantity);

  int totalMoneyCartItems() => cart.fold(
      0,
      (previousValue, element) =>
          previousValue + int.parse(element.product!.price));
}
