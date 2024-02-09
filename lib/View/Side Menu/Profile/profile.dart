import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/Utils/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../Model/ProfileModel/profile_info_model.dart';
import '../../../Utils/api_urls.dart';
import '../../../controller/profile_controller.dart';
import '../../../view_models/profileApi/ProfileAPI.dart';
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
  RxBool isLoading = true.obs;
  final ProfileImageController editProfileImage =
      Get.put(ProfileImageController());
  ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    super.initState();
    ProfileAPI().getProfileInfo().then((value) {
      profileController.profileInfoModel.value =
          ProfileInfoModel.fromJson(value.data);
      isLoading.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Obx(
          () => isLoading.value
              ? Column(
                  children: [
                    Gap(350.h),
                    const Center(
                        child: CircularProgressIndicator(
                      color: AppColors.buttoncolour,
                    )),
                  ],
                )
              : Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
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
                                                image: FileImage(File(
                                                    editProfileImage
                                                        .profilePicPath.value)),
                                                fit: BoxFit.cover,
                                                width: 50.w,
                                                height: 50.h,
                                              )
                                            : profileController
                                                    .profileInfoModel
                                                    .value
                                                    .data!
                                                    .profilePhoto!
                                                    .isEmpty
                                                ? Image.asset(
                                                    "assets/images/profile.png")
                                                : CachedNetworkImage(
                                                    imageUrl:
                                                        "${ApiUrls.baseImageUrl}/${profileController.profileInfoModel.value.data!.profilePhoto}",
                                                    placeholder: (context,
                                                            url) =>
                                                        const CircularProgressIndicator(
                                                      color: AppColors
                                                          .buttoncolour,
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                      ),
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
