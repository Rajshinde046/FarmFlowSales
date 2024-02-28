import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:farm_flow_sales/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Utils/colors.dart';
import 'Utils/global.dart';
import 'View/no_internet_screen.dart';
import 'resources/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  OneSignal.shared.setAppId("19cd37f3-7bd7-4b1d-8c59-b3cce2386c9e");
  OneSignal.shared.promptUserForPushNotificationPermission();

  final status = await OneSignal.shared.getDeviceState();
  final String? osUserID = status?.userId;
  log(osUserID!);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('playerId', osUserID);
  token = prefs.getString('token');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late StreamSubscription<ConnectivityResult> subscription;
  Connectivity connectivity = Connectivity();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    connectivity = Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        setState(() {
          Get.back();
        });
      } else {
        setState(() {
          Get.to(() => const NoInternetscreen());
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);

    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(390, 844),
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              canvasColor: Colors.transparent,
              fontFamily: "Poppins",
              scaffoldBackgroundColor: AppColors.white,
              primarySwatch: Colors.blue,
            ),
            initialRoute: '/',
            getPages: AppRoutes.appRoutes(),
          );
        });
  }
}
