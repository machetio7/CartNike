import 'package:base/config/theme/theme.dart';
import 'package:base/controller/home_controller.dart';
import 'package:base/model/product.dart';
import 'package:base/model/productItem.dart';
import 'package:base/view/details/detail_view.dart';
import 'package:base/view/home/components/cart_detailsview_card.dart';
import 'package:base/view/home/components/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/header.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: Container(
            color: const Color(0xFFEAEAEA),
            child: AnimatedBuilder(
                animation: controller,
                builder: (context, snapshot) {
                  return LayoutBuilder(
                      builder: (context, BoxConstraints constraints) {
                    return Stack(
                      children: [
                        HeaderStack(
                          controller: controller,
                        ),
                        BodyStack(
                          controller: controller,
                          constraints: constraints,
                        ),
                        BottomStack(
                          controller: controller,
                          constraints: constraints,
                        ),
                      ],
                    );
                  });
                }),
          ),
        ),
      );
    });
  }
}

class BottomStack extends StatelessWidget {
  const BottomStack(
      {super.key, required this.controller, required this.constraints});
  final HomeController controller;
  final BoxConstraints constraints;

  void _onVerticalGesture(DragUpdateDetails details) {
    if (details.primaryDelta! < -0.7) {
      controller.changeHomeState(HomeState.cart);
    } else if (details.primaryDelta! > 12) {
      controller.changeHomeState(HomeState.normal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: panelTransition,
      bottom: 0,
      left: 0,
      right: 0,
      height: controller.homestate == HomeState.normal
          ? cartBarHeight
          : (constraints.maxHeight - cartBarHeight),
      child: GestureDetector(
        onVerticalDragUpdate: _onVerticalGesture,
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          color: const Color(0XFFEAEAEA),
          alignment: Alignment.topCenter,
          child: AnimatedSwitcher(
            duration: panelTransition,
            child: controller.homestate == HomeState.normal
                ? CardShortView(controller: controller)
                : CartDetailsView(
                    controller: controller,
                  ),
          ),
        ),
      ),
    );
  }
}

class CartDetailsView extends StatelessWidget {
  const CartDetailsView({super.key, required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text('Cart detail',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          ...List.generate(
            controller.cart.length,
            (index) {
              return CartDetailsViewCard(
                productItem: controller.cart[index],
              );
            },
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          SizedBox(
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
              onPressed: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Go to Pay',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    ' \$${controller.totalMoneyCartItems()}.00',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: DefaultColor.primaryColor),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardShortView extends StatelessWidget {
  const CardShortView({super.key, required this.controller});
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Items',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(
          width: defaultPadding,
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                controller.cart.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: defaultPadding / 2),
                  child: Hero(
                    tag: "${controller.cart[index].product!.title!}_tag",
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage:
                          AssetImage(controller.cart[index].product!.image!),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(
            controller.totalCartItems().toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: DefaultColor.primaryColor),
          ),
        )
      ],
    );
  }
}

class BodyStack extends StatelessWidget {
  const BodyStack({
    super.key,
    required this.controller,
    required this.constraints,
  });

  final HomeController controller;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: panelTransition,
      top: controller.homestate == HomeState.normal
          ? headerHeight
          : -(constraints.maxHeight - cartBarHeight * 2 - headerHeight),
      left: 0,
      right: 0,
      height: constraints.maxHeight - headerHeight - cartBarHeight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(defaultPadding * 1.5),
            bottomRight: Radius.circular(defaultPadding * 1.5),
          ),
        ),
        child: GridView.builder(
          itemCount: productsList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            mainAxisSpacing: defaultPadding,
            crossAxisSpacing: defaultPadding,
          ),
          itemBuilder: (context, index) => ProductCard(
            product: productsList[index],
            press: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  reverseTransitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FadeTransition(
                    opacity: animation,
                    child: DetailView(
                      product: productsList[index],
                      onProductAdd: () {
                        controller.productAdd(productsList[index]);
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class HeaderStack extends StatelessWidget {
  const HeaderStack({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: panelTransition,
      top: controller.homestate == HomeState.normal ? 0 : -headerHeight,
      left: 0,
      right: 0,
      height: headerHeight,
      child: const HomeHeader(),
    );
  }
}
