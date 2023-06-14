import 'package:farm_flow_sales/Common/custom_button_curve.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class TouchId extends StatefulWidget {
  const TouchId({super.key});

  @override
  State<TouchId> createState() => _TouchIdState();
}

class _TouchIdState extends State<TouchId> {
  bool? _hasBiometricSensor;

  LocalAuthentication authentication = LocalAuthentication();

  Future<void> _checkBio() async {
    try {
      _hasBiometricSensor = await authentication.canCheckBiometrics;
      print('boimetric available in this device : $_hasBiometricSensor');
      if (_hasBiometricSensor!) {
        _getAuth();
      }
    } on PlatformException catch (e) {
      print('error');
      print(e);
    }
  }

  Future<void> _getAuth() async {
    bool? isAuth = false;
    try {
      isAuth = await authentication.authenticate(
        localizedReason: 'Use your fingerprint to easily log in!',
        options: const AuthenticationOptions(
            biometricOnly: false, useErrorDialogs: true, stickyAuth: true),
      );

      isAuth
          ? Get.back()
          : Get.snackbar("Not Recogonized", "Please Try Again",
              margin: const EdgeInsets.all(8),
              snackStyle: SnackStyle.FLOATING,
              snackPosition: SnackPosition.BOTTOM);
      print('is Auth $isAuth');
    } on PlatformException catch (e) {
      print('exception is : $e');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 100.h),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Set-up Touch Id",
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 70.h),
                SizedBox(
                  width: 286.w,
                  height: 286.h,
                  child: SvgPicture.asset(
                    'assets/images/setuptouch.svg',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 70.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: customButtonCurve(
                    text: "Set up Now!",
                    onTap: () {
                      Get.snackbar("Verify Your Biometric",
                          "Please Touch Your Finger print",
                          margin: const EdgeInsets.all(8),
                          duration: const Duration(seconds: 1),
                          snackStyle: SnackStyle.FLOATING,
                          snackPosition: SnackPosition.BOTTOM);
                      _checkBio();
                    },
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    'will do it later',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.sp,
                      color: const Color(0xFF585858),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
