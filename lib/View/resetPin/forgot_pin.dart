import 'package:farm_flow_sales/Common/CommonTextFormField.dart';
import 'package:farm_flow_sales/Common/custom_appbar.dart';
import 'package:farm_flow_sales/Common/custom_button_curve.dart';
import 'package:farm_flow_sales/Utils/base_manager.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/Utils/texts.dart';
import 'package:farm_flow_sales/data/network/network_api_services.dart';
import 'package:farm_flow_sales/view_models/onBoarding/ForgotPasswordAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:farm_flow_sales/common/limit_range.dart';

import 'forgot_pin_verify_no.dart';

class ForgotPin extends StatefulWidget {
  const ForgotPin({super.key});

  @override
  State<ForgotPin> createState() => _ForgotPinState();
}

class _ForgotPinState extends State<ForgotPin> {
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  NetworkApiServices networkApiServices = NetworkApiServices();
  _forgotcheck() async {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      Map<String, String> updata = {
        "phone_number": phoneController.text,
      };
      final resp = await ForgotPasswordAPI(updata).forgotpinApi();
      if (resp.status == ResponseStatus.SUCCESS) {
        int? id = resp.data['data']['id'];
        Get.to(() => const ForogotPinVerifyNumber(),
            arguments: {'id': id, 'phonenumber': phoneController.text});
      } else if (resp.status == ResponseStatus.PRIVATE) {
        String? message = resp.data['data']['phone_number'].first;
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
        title: customAppBar(text: "Forgot Pin"),

        // backgroundColor: Color(0xFFF5F8FA),
        elevation: 0,
        // shadowColor: Colors.black,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Form(
                key: _form,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Lottie.asset(
                      "assets/lotties/forgotPassword.json",
                      width: 200.w,
                      height: 200.w,
                    ),
                    SizedBox(
                      width: 270.w,
                      child: textBlack16W5000(
                        "Please enter your phone number to receive a verification code.",
                      ),
                    ),
                    sizedBoxHeight(35.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: textBlack16W5000("Phone Number"),
                    ),
                    sizedBoxHeight(8.h),
                    CustomTextFormField(
                      textEditingController: phoneController,
                      texttype: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(9),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      leadingIcon: Text(
                        "+353",
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                      hintText: "",
                      validator: (value) {
                        if (value == value.isEmpty) {
                          return 'Mobile number is required';
                        } else if (!value.toString().startsWith("8")) {
                          return 'Enter a valid mobile number starting with 8';
                        } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{9}$)')
                            .hasMatch(value)) {
                          return 'Enter valid mobile number';
                        }
                        // v3 = true;
                        return null;
                      },
                      validatorText: "",
                      isInputPassword: false,
                    ),
                    sizedBoxHeight(180.h),
                    customButtonCurve(
                        text: "Next",
                        onTap: () {
                          _forgotcheck();
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
