import 'dart:developer';

import 'package:farm_flow_sales/Common/custom_button_curve.dart';
import 'package:farm_flow_sales/Utils/base_manager.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/view_models/farmer/ConnectFarmerAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:farm_flow_sales/common/limit_range.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class Connectfarmer extends StatefulWidget {
  const Connectfarmer({super.key});

  @override
  State<Connectfarmer> createState() => _ConnectfarmerState();
}

class _ConnectfarmerState extends State<Connectfarmer> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController connectCode = TextEditingController();

  _codecheck(BuildContext context) async {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      await FirebaseAnalytics.instance.logEvent(
        name: 'farmer_connect_attempt',
        parameters: {
          'connect_code': connectCode.text,
        },
      );

      Map<String, String> updata = {
        "connect_code": connectCode.text,
      };
      final resp = await ConnectFarmerAPI(updata).connectFarmerApi();
      if (resp.status == ResponseStatus.SUCCESS) {
        await FirebaseAnalytics.instance.logEvent(
          name: 'farmer_connect_success',
          parameters: {
            'connect_code': connectCode.text,
          },
        );
        connectCode.clear();
        utils.showToast("Request Send Succesfully");
      } else if (resp.status == ResponseStatus.PRIVATE) {
        await FirebaseAnalytics.instance.logEvent(
          name: 'farmer_connect_error',
          parameters: {
            'error_type': 'private',
            'connect_code': connectCode.text,
          },
        );
        var message = resp.data;
        if (message.toString().contains("Already Connected to this farmer")) {
          utils.showToast(message["data"]);
        } else {
          utils.showToast(message["data"]["connect_code"][0]);
        }
      } else {
        await FirebaseAnalytics.instance.logEvent(
          name: 'farmer_connect_error',
          parameters: {
            'error_type': 'general',
            'connect_code': connectCode.text,
          },
        );
        utils.showToast(resp.data);
        utils.showToast("Error");
      }
    }
  }

//5IKQ5mQYVy
  buildconnectfarmer(context) {
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 1), () {
            //  connectCode.text = "";
            log("CALLING THIS");
            Get.back();
          });
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AlertDialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                backgroundColor:
                    Get.isDarkMode ? Colors.black : const Color(0XFFFFFFFF),
                contentPadding: EdgeInsets.fromLTRB(31.w, 50.h, 31.w, 52.h),
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
                    //sizedBoxHeight(46.h),
                    Align(
                      alignment: Alignment.center,
                      child: Text("Request Send Succesfully",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 22.sp,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    sizedBoxHeight(23.h),
                    Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        "assets/images/connectcheck.svg",
                        width: 87.w,
                        height: 87.h,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // appBar: AppBar(
      //   title: customAppBar(text: "Connect To Farmer"),
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      //   titleSpacing: 0,
      //   backgroundColor: AppColors.white,
      // ),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Connect To Farmer",
                          style: TextStyle(
                            color: const Color(0XFF141414),
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  sizedBoxHeight(13.h),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sizedBoxHeight(42.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Enter The Code To Connect To \nA Farmer",
                                // textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff141414)),
                              ),
                            ],
                          ),
                          sizedBoxHeight(59.h),
                          Align(
                            alignment: Alignment.center,
                            child: Text("Connection Code!",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff141414))),
                          ),
                          sizedBoxHeight(14.h),
                          TextFormField(
                            controller: connectCode,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            readOnly: false,
                            // autovalidateMode:
                            //     AutovalidateMode.onUserInteraction,
                            cursorColor: AppColors.buttoncolour,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(fontSize: 16.sp),
                              contentPadding: EdgeInsets.all(17.h),
                              filled: true,
                              fillColor: const Color(0xFFF1F1F1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                    color:
                                        const Color(0xFF707070).withOpacity(0),
                                    width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                    color:
                                        const Color(0xFF707070).withOpacity(0),
                                    width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                    color:
                                        const Color(0xFF707070).withOpacity(0),
                                    width: 1),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 1),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 1),
                              ),
                              hintStyle: TextStyle(
                                  color: AppColors.buttoncolour,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                  fontSize: 16.sp),
                              hintText: "Enter Code",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Connection code is required';
                              }
                              return null;
                            },
                          ),
                          sizedBoxHeight(55.h),
                          customButtonCurve(
                              text: "Connect To Farmer",
                              onTap: () {
                                _codecheck(context);
                              })
                        ],
                      ),
                    ),
                  ))
                ],
              ))),
    );
  }
}
