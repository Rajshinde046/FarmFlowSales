import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'Utils/colors.dart';
import 'resources/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
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
            initialRoute: '/selectfrequency',
            getPages: AppRoutes.appRoutes(),
          );
        });
  }
}
