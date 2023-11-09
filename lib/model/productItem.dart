import 'package:base/model/product.dart';

class ProductItemI {
  int quantity;
  final Product? product;

  ProductItemI({this.quantity = 1, required this.product});

  void increment() {}
}
