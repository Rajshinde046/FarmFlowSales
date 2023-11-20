import 'package:farm_flow_sales/Common/custom_appbar.dart';
import 'package:farm_flow_sales/Common/custom_button_curve.dart';
import 'package:farm_flow_sales/Utils/base_manager.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/Utils/texts.dart';
import 'package:farm_flow_sales/View/resetPin/set_new_pin.dart';
import 'package:farm_flow_sales/data/network/network_api_services.dart';
import 'package:farm_flow_sales/view_models/onBoarding/VerifyNumberAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:farm_flow_sales/common/limit_range.dart';

class ForogotPinVerifyNumber extends StatefulWidget {
  const ForogotPinVerifyNumber({super.key});

  @override
  State<ForogotPinVerifyNumber> createState() => _ForgotPinVerifyNumberState();
}

class _ForgotPinVerifyNumberState extends State<ForogotPinVerifyNumber> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController pincode = TextEditingController();
  String? phoneNumber;
  int? id;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    phoneNumber = Get.arguments["phonenumber"];
    id = Get.arguments["id"];
  }

  NetworkApiServices networkApiServices = NetworkApiServices();
  _verifycheck() async {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      Map<String, String> updata = {
        "id": id.toString(),
        "otp": pincode.text,
      };
      final resp = await VerifyNumberAPI(updata).verifynumberApi();
      if (resp.status == ResponseStatus.SUCCESS) {
        // int? id = resp.data['data']['id'];

        Get.to(
          const SetNewPinScreen(),
        );
      } else if (resp.status == ResponseStatus.PRIVATE) {
        String? message = resp.data['data'];
        utils.showToast("$message");
      } else {
        utils.showToast(resp.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: customAppBar(text: "Verify Your Number"),
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              children: [
                Lottie.asset("assets/lotties/verifyNumber.json",
                    width: 200.w, height: 200.w),

                SizedBox(
                  width: 270.w,
                  child: textBlack16W5000(
                      "Please enter the 4 digit code sent to $phoneNumber"),
                ),

                sizedBoxHeight(45.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: PinCodeTextField(
                    showCursor: true,
                    cursorColor: const Color(0xFF143C6D),
                    textStyle:
                        TextStyle(fontSize: 18.sp, color: AppColors.black),
                    errorTextSpace: 30.h,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Please Enter verification code";
                      } else if (value != null && value.length < 4) {
                        return "Please Enter 4 digit Otp";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    length: 4,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      selectedFillColor: AppColors.greyF1F1F1,
                      inactiveFillColor: AppColors.greyF1F1F1,
                      inactiveColor: AppColors.greyF1F1F1,
                      activeColor: AppColors.greyF1F1F1,
                      selectedColor: AppColors.greyF1F1F1,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4.h),
                          topRight: Radius.circular(4.h)),
                      fieldHeight: 65.h,
                      fieldWidth: 50.w,
                      activeFillColor: AppColors.greyF1F1F1,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    controller: pincode,
                    onCompleted: (v) {
                      print("Completed");
                    },
                    onChanged: (value) {
                      print(value);
                      setState(() {});
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");

                      return true;
                    },
                    appContext: context,
                  ),
                ),

                sizedBoxHeight(10.h),

                Text(
                  "Resend Code",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 18.sp,
                      color: AppColors.buttoncolour,
                      fontWeight: FontWeight.w500),
                ),

                sizedBoxHeight(120.h),
                // 130
                customButtonCurve(
                    text: "Verify",
                    onTap: () {
                      _verifycheck();
                      // final isValid = _form.currentState?.validate();
                      // if (isValid!) {
                      //   Get.toNamed('/ResetPassword');
                      // }
                      // else {
                      //   Get.snackbar("Error", "Please Enter OTP",
                      //     margin: EdgeInsets.all(8),
                      //     snackStyle: SnackStyle.FLOATING,
                      //     snackPosition: SnackPosition.BOTTOM
                      //   );
                      // }
                      // Get.toNamed("/ResetPassword");
                    }),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
