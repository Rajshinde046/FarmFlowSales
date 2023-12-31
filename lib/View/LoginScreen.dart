import 'package:farm_flow_sales/Common/CommonTextFormField.dart';
import 'package:farm_flow_sales/Utils/base_manager.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/custom_button.dart';
import 'package:farm_flow_sales/Utils/global.dart';
import 'package:farm_flow_sales/Utils/texts.dart';
import 'package:farm_flow_sales/view_models/onBoarding/LoginAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:farm_flow_sales/common/limit_range.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

ScrollController? controller;
ScrollController? _scrollviewcontroller;

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  _logincheck() async {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      Map<String, String> updata = {
        "email": tecEmail.text,
        "password": tecPassword.text
      };
      final resp = await LoginAPI(updata).loginApi();
      if (resp.status == ResponseStatus.SUCCESS) {
        print("reslo ${resp.data}");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        // print("token " + jsonResp["data"]["accessToken"]);
        await prefs.setString('accessToken', resp.data["data"]["access_token"]);

        token = resp.data["data"]["access_token"];
        Get.toNamed('/sideMenu');
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
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: _form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 250.h,
                color: const Color(0xFF0E5F02),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      //  alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          left: -12 * fem,
                          top: -18 * fem,
                          child: SvgPicture.asset(
                            "assets/grass.svg",
                            // fit: BoxFit.fill,
                            // width: MediaQuery.of(context).size.width,
                            width: 430.w,
                          ),
                        ),
                        Positioned(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 25.h,
                              ),
                              Center(
                                child: Image.asset(
                                  "assets/logo.png",
                                  height: 200.h,
                                ),
                              ),
                              SizedBox(
                                height: 25.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: const Color(0xFF0E5F02),
                child: Container(
                  // height: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        textBlack25W600Mon("Let's sign you in"),
                        SizedBox(
                          height: 35.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textBlack16W5000("Email Address"),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomTextFormField(
                              textEditingController: tecEmail,
                              leadingIcon:
                                  SvgPicture.asset("assets/images/mail.svg"),

                              hintText: "",
                              // validator: ,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Your Email";
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid Email';
                                }
                                return null;
                              },
                              validatorText: "",
                              //  isInputPassword: true,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textBlack16W5000("Password"),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomTextFormField(
                              textEditingController: tecPassword,
                              leadingIcon: SvgPicture.asset(
                                  "assets/images/password.svg"),
                              hintText: "",
                              validatorText: "",
                              isInputPassword: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Password";
                                }
                                if (value.length < 8) {
                                  return 'Password must be at least 8 characters';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed("/forgotPassword");
                              },
                              child: Text(
                                "Forgot Password?",
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
                        SizedBox(
                          height: 55.h,
                        ),
                        CustomButton(
                            text: "Login",
                            onTap: () {
                              _logincheck();
                              // final isValid = _form.currentState?.validate();
                              // if (isValid!) {
                              //   Get.toNamed("/sideMenu");
                              // }
                            }),
                        SizedBox(
                          height: 15.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
