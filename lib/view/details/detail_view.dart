import 'package:base/config/theme/theme.dart';
import 'package:base/controller/detail_controller.dart';
import 'package:base/model/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailView extends StatelessWidget {
  DetailView({super.key, required this.product, required this.onProductAdd});
  final controller = Get.put(DetailController());
  final Product product;
  final VoidCallback onProductAdd;

  @override
  Widget build(BuildContext context) {
    controller.cartTag = "";
    return GetBuilder<DetailController>(builder: (_) {
      return Scaffold(
        body: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.4,
              width: MediaQuery.sizeOf(context).width * 1,
              decoration: const BoxDecoration(
                color: DefaultColor.bgColor,
              ),
              child: Hero(
                tag: product.title + controller.cartTag,
                child: Center(
                  child: Image.asset(product.image),
                ),
              ),
            ),
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                color: DefaultColor.bgColor,
              ),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  height: 75,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                          side: const BorderSide(color: Colors.orange),
                        ),
                      ),
                    ),
                    onPressed: () {
                      onProductAdd();
                      controller.updateCartTag();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      );
    });
  }
}
