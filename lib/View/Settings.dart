import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/global.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool state = false;
  bool fingerstate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 18.w, top: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: CircleAvatar(
                          radius: 20.h,
                          backgroundColor: const Color(0XFFF1F1F1),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 25.h,
                                color: const Color(0xFF141414),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Text(
                      "Settings",
                      style: TextStyle(
                          color: const Color(0xFF141414),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      "Set Up Alert Notification",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.h),
                  color: Color(0xffF1F1F1),
                ),
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomListTile(
                  title: "Order Details And Alerts",
                  statecontroller: state,
                ),
              ),
              sizedBoxHeight(29.h),
              GestureDetector(
                onTap: () {
                  buildprofiledeletedialog(context);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "Request Deletion Of Account",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: const Color(0XFF0E5F02),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              sizedBoxHeight(12.h),
              GestureDetector(
                onTap: () {
                  buildprofilelogoutdialog(context);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: const Color(0XFF0E5F02),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildprofiledeletedialog(context) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            backgroundColor:
                Get.isDarkMode ? Colors.black : const Color(0XFFFFFFFF),
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              side: BorderSide(
                  color:
                      Get.isDarkMode ? Colors.grey : const Color(0XFFFFFFFF)),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/images/sendmail.svg",
                    width: 35.w,
                    height: 34.h,
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Are you sure you want to request co-op to delete your account?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                    ),
                  ),
                ),
                sizedBoxHeight(21.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                        buildprofiledelete2dialog(context);
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.buttoncolour),
                        child: Center(
                          child: Text(
                            "Yes",
                            style: TextStyle(
                                color: AppColors.white, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                    sizedBoxWidth(28.w),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0XFF0E5F02)),
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.white),
                        child: Center(
                          child: Text(
                            "No",
                            style: TextStyle(
                                color: AppColors.buttoncolour, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildprofiledelete2dialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pop(true);
          });
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AlertDialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                backgroundColor:
                    Get.isDarkMode ? Colors.black : const Color(0XFFFFFFFF),
                contentPadding: EdgeInsets.fromLTRB(57.w, 46.h, 57.w, 21.h),
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  side: BorderSide(
                      color: Get.isDarkMode
                          ? Colors.grey
                          : const Color(0XFFFFFFFF)),
                ),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset("assets/images/sendmail.svg"),
                    ),
                    sizedBoxHeight(21.h),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Request Send To Co-Op",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.sp,
                        ),
                      ),
                    ),
                    sizedBoxHeight(40.h),
                  ],
                ),
              ),
            ],
          );
        });
  }

  buildprofilelogoutdialog(context) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            backgroundColor:
                Get.isDarkMode ? Colors.black : const Color(0XFFFFFFFF),
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              side: BorderSide(
                  color:
                      Get.isDarkMode ? Colors.grey : const Color(0XFFFFFFFF)),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/logoutsettings.png",
                    width: 40.w,
                    height: 50.h,
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Are you sure you want to Logout?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                    ),
                  ),
                ),
                sizedBoxHeight(21.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString('accessToken', "");
                        await prefs.setString('token', "");
                        token = null;
                        Get.offAllNamed("/loginScreen");
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.buttoncolour),
                        child: Center(
                          child: Text(
                            "Yes",
                            style: TextStyle(
                                color: AppColors.white, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                    sizedBoxWidth(28.w),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0XFF0E5F02)),
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.white),
                        child: Center(
                          child: Text(
                            "No",
                            style: TextStyle(
                                color: AppColors.buttoncolour, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomListTile extends StatefulWidget {
  CustomListTile({
    Key? key,
    required this.title,
    required this.statecontroller,
    this.addVideoPage = false,
  }) : super(key: key);

  final String? title;
  bool statecontroller;
  bool addVideoPage;

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: widget.addVideoPage ? 0 : 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title!,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400,
                  color: Color(0xff4D4D4D)),
            ),
            const Spacer(),
            FlutterSwitch(
              switchBorder: Border.all(
                strokeAlign: BorderSide.strokeAlignCenter,
                style: BorderStyle.solid,
                width: 1,
                color: const Color(0xffCCCCCC),
              ),
              padding: 0,
              width: 50.0,
              height: 25.0,
              toggleColor: const Color(0xFF0E5F02),
              activeColor: AppColors.white,
              inactiveColor: Colors.white,
              inactiveToggleColor: const Color(0xff686868),
              value: widget.statecontroller,
              onToggle: (val) {
                setState(() {
                  widget.statecontroller = val;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
