import 'dart:ui';
import 'package:base/config/theme/theme.dart';
import 'package:base/controller/onboarding_controller.dart';
import 'package:base/view/onboarding/components/btn_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return GetBuilder<OnboardingController>(builder: (_) {
      return Scaffold(
        body: Stack(
          children: [
            Positioned(
              left: -15,
              top: 200,
              child: Lottie.asset("assets/animation/delivery.json"),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    color: DefaultColor.primaryOpacity,
                  ),
                ),
              ),
            ),
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  const SizedBox(
                    width: 260,
                    child: Column(
                      children: [
                        Text(
                          "Dale sabor a la vida",
                          style: TextStyle(
                            fontSize: 60,
                            fontFamily: "Poppins",
                            height: 1.2,
                            color: DefaultColor.primary,
                          ),
                        ),
                        Text(
                          "Descubre los mejores precios y descuentos.",
                          style: TextStyle(
                            color: DefaultColor.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 7,
                  ),
                  AnimationBtn(
                    btnAnimationController: controller.btnAnimationController,
                    press: () {
                      controller.btnAnimationController.isActive = true;
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      "Todos nuestros proveedores están dispuestos a consentirte.",
                      style: TextStyle(color: DefaultColor.primary),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      );
    });
  }
}
