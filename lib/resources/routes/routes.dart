import 'package:farm_flow_sales/View/LoginScreen.dart';
import 'package:farm_flow_sales/View/Side%20Menu/Faqs/faqs.dart';
import 'package:farm_flow_sales/View/Side%20Menu/Faqs/insidefaq.dart';
import 'package:farm_flow_sales/View/Side%20Menu/SideMenu.dart';
import 'package:farm_flow_sales/View/Side%20Menu/contact.dart';
import 'package:farm_flow_sales/View/forgot_password.dart';
import 'package:farm_flow_sales/View/reset_password.dart';
import 'package:farm_flow_sales/View/splash_screen.dart';
import 'package:farm_flow_sales/View/verify_number.dart';
import 'package:get/get.dart';

import 'route_name.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RouteName.splashScreen,
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: RouteName.loginScreen,
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: RouteName.forgotPassword,
          page: () => const ForgotPassword(),
        ),
        GetPage(
          name: RouteName.verifyNumber,
          page: () => const VerifyNumber(),
        ),
        GetPage(
          name: RouteName.resetPassword,
          page: () => const ResetPassword(),
        ),
        GetPage(
          name: RouteName.sideMenu,
          page: () => const SideMenu(),
        ),
        GetPage(
          name: RouteName.contact,
          page: () => const Contact(),
        ),
        GetPage(
          name: RouteName.faqs,
          page: () => const Faq(),
        ),
        GetPage(
          name: RouteName.faqcontent,
          page: () => const Faqscontent(),
        ),
      ];
}
