import 'dart:developer';

import 'package:farm_flow_sales/Common/limit_range.dart';
import 'package:farm_flow_sales/Model/ProfileModel/profile_info_model.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/View/resetPin/forgot_pin.dart';
import 'package:farm_flow_sales/controller/profile_controller.dart';
import 'package:farm_flow_sales/view_models/SecurityApi/security_api.dart';
import 'package:farm_flow_sales/view_models/profileApi/ProfileAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../Common/CommonTextFormField.dart';
import '../Utils/custom_button.dart';
import '../Utils/texts.dart';

class SecureLogin extends StatefulWidget {
  const SecureLogin({super.key});

  @override
  State<SecureLogin> createState() => _SecureLoginState();
}

class _SecureLoginState extends State<SecureLogin> {
  TextEditingController pincontroller = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    ProfileAPI().getProfileInfo().then((value) {
      profileController.profileInfoModel.value =
          ProfileInfoModel.fromJson(value.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.buttoncolour,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: textWhite16("Security Check"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(80.h),
            textBlack16W5000("Enter pin to login"),
            Gap(10.h),
            Form(
              key: _form,
              child: CustomTextFormField(
                texttype: TextInputType.number,
                textEditingController: pincontroller,
                isInputPassword: true,
                leadingIcon: SvgPicture.asset("assets/images/password.svg"),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                hintText: "",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Pin";
                  }

                  return null;
                },
                validatorText: "",
              ),
            ),
            Gap(25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(const ForgotPin());
                  },
                  child: Text(
                    "Forgot Pin?",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.buttoncolour,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
            Gap(25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 220,
                  child: CustomButton(
                      text: "Check Pin",
                      onTap: () {
                        final isValid = _form.currentState?.validate();
                        if (isValid!) {
                          SecurityApi()
                              .checkPinApi(
                                  profileController
                                      .profileInfoModel.value.data!.id!,
                                  int.parse(pincontroller.text))
                              .then((value) {
                            if (value.data['success']) {
                              Get.offAndToNamed("/sideMenu");
                            } else {
                              utils.showToast(value.data['message']);
                            }
                          });
                        }
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
