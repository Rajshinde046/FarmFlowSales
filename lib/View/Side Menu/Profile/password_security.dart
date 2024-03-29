import 'dart:developer';

import 'package:farm_flow_sales/Common/custom_button_curve.dart';
import 'package:farm_flow_sales/Common/limit_range.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/controller/profile_controller.dart';
import 'package:farm_flow_sales/view_models/SecurityApi/security_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'TouchId.dart';

class PasswordSecurity extends StatefulWidget {
  const PasswordSecurity({super.key});

  @override
  State<PasswordSecurity> createState() => _PasswordSecurityState();
}

class _PasswordSecurityState extends State<PasswordSecurity> {
  final GlobalKey<FormState> _pin = GlobalKey<FormState>();

  String gender = "security-first";

  TextEditingController pincontroller = TextEditingController();
  TextEditingController confirmpincontroller = TextEditingController();
  ProfileController profileController = Get.find();

  @override
  void initState() {
    getLoginData();
    super.initState();
  }

  Future<void> getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('fingerprint') != null) {
      if (prefs.getBool('fingerprint')!) {
        profileController.onclickoftouchid = true;
        setState(() {});
      }
    }
    if (prefs.getBool('pin') != null) {
      if (prefs.getBool('pin')!) {
        profileController.onclickofpin = true;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                            color: const Color(0XFF141414),
                          ),
                        ),
                      ),
                    ),
                  ),
                  sizedBoxWidth(15.w),
                  Text(
                    "Security First",
                    style: TextStyle(
                      color: const Color(0XFF141414),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              sizedBoxHeight(20.h),
              Text(
                "Select to login Method",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),
              ),
              sizedBoxHeight(20.h),
              widgetDigitPin(),
              // sizedBoxHeight(15.h),
              // widgetTouch()
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetTouch() {
    return GestureDetector(
      onTap: () {
        Get.to(() => const TouchId());
      },
      child: Container(
        height: 100.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: profileController.onclickoftouchid
              ? AppColors.buttoncolour
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.buttoncolour, width: 1),
        ),
        alignment: const Alignment(50, 0),
        padding: const EdgeInsets.all(5),
        child: ListTile(
          onTap: () {
            profileController.onclickoftouchid
                ? Get.to(() => const TouchId())
                : null;
          },
          trailing: SvgPicture.asset(
              profileController.onclickoftouchid
                  ? "assets/images/touch-white.svg"
                  : "assets/images/touch-black.svg",
              color: profileController.onclickoftouchid
                  ? Colors.white
                  : AppColors.buttoncolour),
          title: Text(
            "Touch Id",
            style: TextStyle(
                color: profileController.onclickoftouchid
                    ? Colors.white
                    : Colors.black,
                fontFamily: 'Poppins',
                fontSize: 18),
          ),
          leading: Transform.scale(
            scale: 1.5,
            child: Radio(
                fillColor: MaterialStateColor.resolveWith((states) =>
                    profileController.onclickoftouchid
                        ? Colors.white
                        : AppColors.buttoncolour),
                activeColor: (Colors.white),
                value: "Touch Id",
                groupValue: gender,
                onChanged: (value) {
                  setState(() {
                    Get.to(() => const TouchId());
                  });
                }),
          ),
        ),
      ),
    );
  }

  Widget widgetDigitPin() {
    return Container(
      height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: profileController.onclickofpin
            ? AppColors.buttoncolour
            : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.buttoncolour, width: 1),
      ),
      alignment: const Alignment(50, 0),
      padding: const EdgeInsets.all(5),
      child: ListTile(
        trailing: SvgPicture.asset(
          profileController.onclickofpin
              ? "assets/images/four-dg-white.svg"
              : "assets/images/four-dg-black.svg",
          color: profileController.onclickofpin
              ? Colors.white
              : AppColors.buttoncolour,
        ),
        onTap: () {
          build4digitpin();
        },
        title: Text(
          "4 Digit PIN",
          style: TextStyle(
            color: profileController.onclickofpin ? Colors.white : Colors.black,
            fontSize: 18,
            fontFamily: 'Poppins',
          ),
        ),
        leading: Transform.scale(
          scale: 1.5,
          child: Radio(
              fillColor: MaterialStateColor.resolveWith((states) =>
                  profileController.onclickofpin
                      ? Colors.white
                      : AppColors.buttoncolour),
              activeColor: (Colors.white),
              value: "4 Digit PIN",
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  build4digitpin();
                });
              }),
        ),
      ),
    );
  }

  build4digitpin() {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 24),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: _pin,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Let's set your 4 Digit Pin",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  sizedBoxHeight(10.h),
                  const Divider(thickness: 2),
                  sizedBoxHeight(50.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 60.w,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Choose a PIN of Your choice",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff4D4D4D)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return "Please Enter 4 Digit PIN";
                              } else if (value != null && value.length < 4) {
                                return "PIN length should be atleast 4";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            controller: pincontroller,
                            textAlign: TextAlign.center,
                            // cursorHeight: 10,
                            decoration: const InputDecoration(
                              helperText: "",
                              // hintText: "Choose a PIN of Your choice",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: Color(0xFF707070)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Color(0xFF707070),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60.w),
                    child: Column(
                      children: [
                        Text(
                          "Please Re-Enter the PIN",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff4D4D4D)),
                        ),
                        TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(4),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'PIN is Empty';
                            }
                            if (val != pincontroller.text) {
                              return 'Password Not Matched';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          controller: confirmpincontroller,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            helperText: "",
                            // hintText: "Please Re-Enter the PIN",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFF707070),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFF707070),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    height: 50,
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: customButtonCurve(
                      onTap: () {
                        final isValid = _pin.currentState?.validate();
                        if (isValid!) {
                          log(profileController.profileInfoModel.value.data!.id!
                              .toString());
                          SecurityApi()
                              .changePinApi(
                                  profileController
                                      .profileInfoModel.value.data!.id!,
                                  int.parse(pincontroller.text))
                              .then((value) async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            pincontroller.clear();
                            confirmpincontroller.clear();
                            Get.back();
                            profileController.onclickofpin = true;

                            setState(() {});
                            await prefs.setBool('pin', true);
                            utils.showToast(value.data["message"]);
                          });
                        }
                      },
                      text: 'Submit',
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
