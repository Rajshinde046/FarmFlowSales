import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/View/Side%20Menu/Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../Model/ProfileModel/profile_info_model.dart';
import '../../Utils/api_urls.dart';
import '../../Utils/colors.dart';
import '../../controller/dashboard_controller.dart';
import '../../controller/profile_controller.dart';
import '../../view_models/profileApi/ProfileAPI.dart';
import 'Profile/personalinfo.dart';

class SideBar extends StatefulWidget {
  const SideBar({
    super.key,
    // required this.press, required this.currentIndex
  });

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  ProfileController profileController = Get.put(ProfileController());

  final ProfileImageController editProfileImage =
      Get.put(ProfileImageController());
  RxBool isLoading = false.obs;

  List sideBarData = [
    {
      "icon": Image.asset(
        "assets/images/contact-info.png",
        height: 30.h,
        width: 30.h,
        color: Colors.white,
      ),
      "text": "Contacts",
      "route": "/contact"
    },
    {
      "icon": Image.asset(
        "assets/images/faq.png",
        height: 30.h,
        width: 30.h,
      ),
      "text": "FAQ",
      "route": "/faq"
    },
    {
      "icon": Image.asset(
        "assets/images/feedback.png",
        height: 30.h,
        width: 30.h,
      ),
      "text": "Feedback",
      "route": "/feedBack"
    },
    {
      "icon": Image.asset(
        "assets/images/contactus.png",
        height: 30.h,
        width: 30.h,
      ),
      "text": "Contact Us",
      "route": "/contactus"
    },
  ];

  @override
  void initState() {
    isLoading.value = true;
    ProfileAPI().getProfileInfo().then((value) {
      profileController.profileInfoModel.value =
          ProfileInfoModel.fromJson(value.data);
      isLoading.value = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DashboardController dashboardController = Get.put(DashboardController());
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 300.w,
          decoration: const BoxDecoration(color: Color(0xff0E5F02)),
          child: DefaultTextStyle(
            style: const TextStyle(color: Colors.white),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 10.h, 45.w, 10.h),
              child: Column(
                children: [
                  sizedBoxHeight(80.h),
                  InkWell(
                    onTap: () {
                      Get.to(() => const Profile());
                    },
                    child: Row(
                      children: [
                        SizedBox(
                            height: 65.w,
                            width: 65.w,
                            child: Obx(
                              () => isLoading.value
                                  ? const SizedBox()
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
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
                                                  "assets/default_image.jpg")
                                              : CachedNetworkImage(
                                                  memCacheHeight: 97,
                                                  maxHeightDiskCache: 97,
                                                  maxWidthDiskCache: 85,
                                                  memCacheWidth: 85,
                                                  imageUrl:
                                                      "${ApiUrls.baseImageUrl}/${profileController.profileInfoModel.value.data!.profilePhoto}",
                                                  placeholder: (context, url) =>
                                                      const CircularProgressIndicator(
                                                    color:
                                                        AppColors.buttoncolour,
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                    ),
                            )),
                        sizedBoxWidth(15.w),
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                child: Obx(
                                  () => Text(
                                    dashboardController.userName.value,
                                    style: TextStyle(fontSize: 18.sp),
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                              sizedBoxHeight(4.h),
                              Text(
                                profileController
                                    .profileInfoModel.value.data!.phoneNumber!,
                                style: TextStyle(fontSize: 16.sp),
                              )
                            ],
                          ),
                        ),
                        const Gap(39),
                        const Icon(
                          Icons.edit,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  sizedBoxHeight(60.h),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: sideBarData.length,
                      itemBuilder: (_, index) {
                        return SideBarTile(
                          icon: sideBarData[index]["icon"],
                          text: sideBarData[index]["text"],
                          onTap: () {
                            // if (index == 4) {
                            //   buildprofilelogoutdialog(context);
                            // } else {
                            Get.toNamed(sideBarData[index]["route"]);
                            // }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SideBarTile extends StatelessWidget {
  Widget icon;
  String text;
  void Function()? onTap;

  SideBarTile({
    required this.icon,
    required this.text,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              children: [
                icon,
                SizedBox(
                  width: 22.w,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 16.sp),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
