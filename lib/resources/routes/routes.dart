import 'package:farm_flow_sales/View/Cart/cartmain.dart';
import 'package:farm_flow_sales/View/Cart/discountpage.dart';
import 'package:farm_flow_sales/View/Cart/placeorder.dart';

import 'package:farm_flow_sales/View/Connectfarmer.dart';
import 'package:farm_flow_sales/View/Farmers/farmer.dart';
import 'package:farm_flow_sales/View/Farmers/farmerdetails.dart';
import 'package:farm_flow_sales/View/LoginScreen.dart';
import 'package:farm_flow_sales/View/Notification.dart';
import 'package:farm_flow_sales/View/Order/orderdetails.dart';
import 'package:farm_flow_sales/View/Order/ordersmain.dart';
import 'package:farm_flow_sales/View/Sales.dart';
import 'package:farm_flow_sales/View/Settings.dart';
import 'package:farm_flow_sales/View/Side%20Menu/Faqs/faqs.dart';
import 'package:farm_flow_sales/View/Side%20Menu/Faqs/insidefaq.dart';
import 'package:farm_flow_sales/View/Side%20Menu/Feedback/feedback.dart';
import 'package:farm_flow_sales/View/Side%20Menu/Feedback/feedbackform.dart';
import 'package:farm_flow_sales/View/Side%20Menu/SideMenu.dart';
import 'package:farm_flow_sales/View/Side%20Menu/Contact/contact.dart';
import 'package:farm_flow_sales/View/Side%20Menu/contactUs.dart';
import 'package:farm_flow_sales/View/Warehouse/warehouse.dart';
import 'package:farm_flow_sales/View/forgot_password.dart';
import 'package:farm_flow_sales/View/products.dart';
import 'package:farm_flow_sales/View/reset_password.dart';

// import 'package:farm_flow_sales/View/select_frequency.dart';
import 'package:farm_flow_sales/View/Cart/selectfarmer.dart';

import 'package:farm_flow_sales/View/Cart/select_frequency.dart';

import 'package:farm_flow_sales/View/search_product_categories.dart';

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
        GetPage(
          name: RouteName.feedBack,
          page: () => const FeedBack(),
        ),
        GetPage(
          name: RouteName.feedBackform,
          page: () => const Feedbackform(),
        ),
        GetPage(
          name: RouteName.contactus,
          page: () => const ContactUs(),
        ),
        GetPage(
          name: RouteName.notification,
          page: () => const Notification(),
        ),
        GetPage(
          name: RouteName.settings,
          page: () => const Settings(),
        ),
        GetPage(
          name: RouteName.warehouse,
          page: () => const Warehouse(),
        ),
        GetPage(
          name: RouteName.products,
          page: () => const Productspage(),
        ),
        GetPage(
          name: RouteName.farmer,
          page: () => const Farmer(),
        ),
        GetPage(
          name: RouteName.farmerdetails,
          page: () => const Farmerdetails(),
        ),
        GetPage(
          name: RouteName.connectfarmer,
          page: () => const Connectfarmer(),
        ),
        GetPage(
          name: RouteName.orderdetails,
          page: () => const Orderdetails(),
        ),
        GetPage(
          name: RouteName.ordermain,
          page: () => const OrderMain(),
        ),
        GetPage(
          name: RouteName.selectfrequency,
          page: () => const selectFrequency(),
        ),
        GetPage(
          name: RouteName.sales,
          page: () => const Sales(),
        ),
        GetPage(
          name: RouteName.cartmain,
          page: () => const Cartmain(),
        ),
        GetPage(
          name: RouteName.placeordermain,
          page: () => const Placedorder(),
        ),
        GetPage(
          name: RouteName.discount,
          page: () => Discount(),
        ),
        GetPage(
          name: RouteName.searchpage,
          page: () => const SearchProductCategories(),
        ),
        GetPage(
          name: RouteName.selectfarmer,
          page: () => const selectFarmer(),
        ),
      ];
}
