import 'dart:io';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/Utils/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'password_security.dart';
import 'personalinfo.dart';

TextEditingController nameController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController datecontroller = TextEditingController();

String? nameValue;
String? dateValue;
String? phoneValue;
String? emailValue;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ProfileImageController editProfileImage =
      Get.put(ProfileImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
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
                            color: const Color(0XFF141414),
                          ),
                        ),
                      ),
                    ),
                  ),
                  sizedBoxWidth(15.w),
                  Text(
                    "My Profile",
                    style: TextStyle(
                      color: const Color(0XFF141414),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            sizedBoxHeight(43.h),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => CircleAvatar(
                            backgroundColor: AppColors.buttoncolour,
                            radius: 35.h,
                            child: ClipOval(
                              child: SizedBox.fromSize(
                                  size: Size.fromRadius(33.r),
                                  child: editProfileImage
                                              .profilePicPath.value !=
                                          ''
                                      ? Image(
                                          image: FileImage(File(editProfileImage
                                              .profilePicPath.value)),
                                          // fit: BoxFit.fitHeight,
                                          // width: 200.w,
                                          // height: 200.h,
                                        )
                                      : Image.asset(
                                          "assets/images/person.png")),
                            ),
                          ),
                        ),
                      ],
                    ),
                    sizedBoxHeight(36.w),
                    profRow('Personal Information', () {
                      Get.to(() => const PersonalInfo());
                    }),
                    sizedBoxHeight(15.h),
                    profRow('Select Login Method', () {
                      Get.to(() => const PasswordSecurity());
                    }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget profRow(String txt, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.greyF1F1F1,
            borderRadius: BorderRadius.circular(10.r)),
        height: 50.h,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            sizedBoxWidth(15.w),
            textGrey4D4D4D_16W500(txt),
          ],
        ),
      ),
    );
  }
}
