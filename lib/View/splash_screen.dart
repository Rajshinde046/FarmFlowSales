import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:farm_flow_sales/View/no_internet_screen.dart';
import 'package:farm_flow_sales/View/secure_login.dart';
import 'package:farm_flow_sales/controller/dashboard_controller.dart';
import 'package:farm_flow_sales/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/ProfileModel/profile_info_model.dart';
import '../Utils/colors.dart';
import '../view_models/profileApi/ProfileAPI.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _connectionStatus;
  Future<void> checkInternet() async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        _connectionStatus = connectivityResult;
      });
    } else {
      setState(() {
        _connectionStatus = connectivityResult;

        //  Navigator.pushReplacementNamed(context, "/noInternet");
      });
    }
  }

  Future<void> _getAuth() async {
    bool? isAuth = false;
    LocalAuthentication authentication = LocalAuthentication();
    try {
      isAuth = await authentication.authenticate(
        localizedReason: 'Use your fingerprint to easily log in!',
        options: const AuthenticationOptions(
            biometricOnly: false, useErrorDialogs: true, stickyAuth: true),
      );

      isAuth
          ? Get.offAndToNamed("/sideMenu")
          : Get.snackbar("Not Recogonized", "Please Try Again",
              margin: const EdgeInsets.all(8),
              snackStyle: SnackStyle.FLOATING,
              snackPosition: SnackPosition.BOTTOM);
      print('is Auth $isAuth');
    } on PlatformException catch (e) {
      print('exception is : $e');
      log("Test");
    }
  }

  ProfileController profileController = Get.put(ProfileController());
  DashboardController dashboardController = Get.put(DashboardController());

  @override
  void initState() {
    super.initState();
    checkInternet();
    Future.delayed(const Duration(seconds: 2), () async {
      if (_connectionStatus == ConnectivityResult.none) {
        var result = await Get.to(NoInternetscreen());
        if (result != null && result) {
          Timer(const Duration(seconds: 6), () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            var token = prefs.getString('token');
            if (token == "" || token == null) {
              Get.offAndToNamed("/loginScreen");
            } else {
              ProfileAPI().getProfileInfo().then((value) async {
                profileController.profileInfoModel.value =
                    ProfileInfoModel.fromJson(value.data);
                dashboardController.userName.value =
                    profileController.profileInfoModel.value.data!.userName!;
                await prefs.setBool(
                    "pin", profileController.profileInfoModel.value.data!.pin!);
              });
              if (profileController.profileInfoModel.value.data!.pin != null) {
                if (profileController.profileInfoModel.value.data!.pin!) {
                  Get.off(const SecureLogin());
                }
              } else {
                if (token == "" || token == null) {
                  Get.offAndToNamed("/loginScreen");
                } else {
                  Get.offAndToNamed("/sideMenu");
                }
              }
            }
          });
        }
      } else {
        Timer(const Duration(seconds: 6), () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var token = prefs.getString('token');
          if (token == "" || token == null) {
            Get.offAndToNamed("/loginScreen");
          } else {
            ProfileAPI().getProfileInfo().then((value) async {
              profileController.profileInfoModel.value =
                  ProfileInfoModel.fromJson(value.data);
              dashboardController.userName.value =
                  profileController.profileInfoModel.value.data!.userName!;
              await prefs.setBool(
                  "pin", profileController.profileInfoModel.value.data!.pin!);
            });
            if (profileController.profileInfoModel.value.data!.pin != null) {
              if (profileController.profileInfoModel.value.data!.pin!) {
                Get.off(const SecureLogin());
              }
            } else {
              if (token == "" || token == null) {
                Get.offAndToNamed("/loginScreen");
              } else {
                Get.offAndToNamed("/sideMenu");
              }
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Image.asset(
          "assets/images/farmFlow.png",
          width: Get.width,
          height: 200.h,
        ),
      ),
    );
  }
}
