import 'package:base/config/routes/routes_name.dart';
import 'package:base/view/onboarding/onboarding_view.dart';
import 'package:get/get.dart';

class RoutesPage {
  final pages = [
    GetPage(
      name: RoutesName.onboarding,
      page: () => const OnboardingView(),
    ),
  ];
}
