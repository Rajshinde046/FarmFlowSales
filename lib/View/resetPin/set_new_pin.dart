import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:farm_flow_sales/common/limit_range.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Common/custom_button_curve.dart';
import '../../Utils/colors.dart';
import '../../Utils/sized_box.dart';
import '../../Utils/texts.dart';
import '../../controller/profile_controller.dart';
import '../../view_models/SecurityApi/security_api.dart';

class SetNewPinScreen extends StatefulWidget {
  const SetNewPinScreen({super.key});

  @override
  State<SetNewPinScreen> createState() => _SetNewPinScreenState();
}

class _SetNewPinScreenState extends State<SetNewPinScreen> {
  TextEditingController pincontroller = TextEditingController();
  TextEditingController confirmpincontroller = TextEditingController();
  ProfileController profileController = Get.find();
  final GlobalKey<FormState> _pin = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.buttoncolour,
            elevation: 0,
            title: textWhite16("Reset Pin"),
          ),
          body: SingleChildScrollView(
            child: Container(
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
                                  } else if (value != null &&
                                      value.length < 4) {
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
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
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
                              SecurityApi()
                                  .changePinApi(
                                      profileController
                                          .profileInfoModel.value.data!.id!,
                                      int.parse(pincontroller.text))
                                  .then((value) async {
                                utils.showToast(value.data["message"]);
                                Get.offAndToNamed("/sideMenu");
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
            ),
          )),
    );
  }
}
