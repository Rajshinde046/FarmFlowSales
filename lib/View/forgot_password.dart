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

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  NetworkApiServices networkApiServices = NetworkApiServices();
  _forgotcheck() async {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      Map<String, String> updata = {
        "phone_number": phoneController.text,
      };
      final resp = await ForgotPasswordAPI(updata).forgotpasswordApi();
      if (resp.status == ResponseStatus.SUCCESS) {
        int? id = resp.data['data']['id'];
        Get.toNamed('/verifyNumber',
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
        title: customAppBar(text: "Forgot Password"),

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
                        texttype: TextInputType.phone,
                        textEditingController: phoneController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter a Phone Number";
                          } else if (!RegExp(
                                  r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                              .hasMatch(value)) {
                            return "Please Enter a Valid Phone Number";
                          }
                          return null;
                        },
                        hintText: "Enter your Phone Number",
                        validatorText: "Enter your Phone Number"),
                    // Spacer(),

                    sizedBoxHeight(180.h),
                    customButtonCurve(
                        text: "Next",
                        onTap: () {
                          _forgotcheck();
                          // final isValid = _form.currentState?.validate();
                          // if (isValid!) {
                          //   Get.toNamed("/verifyNumber",
                          //       arguments: phoneController.text);
                          // }
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
