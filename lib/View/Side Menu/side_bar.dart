import 'dart:io';

import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/View/Side%20Menu/Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../Model/ProfileModel/profile_info_model.dart';
import '../../Utils/api_urls.dart';
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
    // {
    //   "icon": Image.asset(
    //     "assets/images/logout.png",
    //     height: 30.h,
    //     width: 30.h,
    //   ),
    //   "text": "Log Out",
    //   "route": ""
    // },
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
                                                  "assets/images/profile.png")
                                              : Image.network(
                                                  "${ApiUrls.baseImageUrl}/${profileController.profileInfoModel.value.data!.profilePhoto}"),
                                    ),
                            )),
                        sizedBoxWidth(15.w),
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profileController
                                    .profileInfoModel.value.data!.userName!,
                                style: TextStyle(fontSize: 18.sp),
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

// buildprofilelogoutdialog(context) {
//   return showDialog(
//     context: context,
//     builder: (context) => Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         AlertDialog(
//           insetPadding: const EdgeInsets.symmetric(horizontal: 16),
//           backgroundColor:
//               Get.isDarkMode ? Colors.black : const Color(0XFFFFFFFF),
//           //contentPadding: EdgeInsets.fromLTRB(96, 32, 96, 28),
//           shape: RoundedRectangleBorder(
//             borderRadius: const BorderRadius.all(Radius.circular(20)),
//             side: BorderSide(
//                 color: Get.isDarkMode ? Colors.grey : const Color(0XFFFFFFFF)),
//           ),
//           content: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               //sizedBoxHeight(32.h),
//               Align(
//                 alignment: Alignment.center,
//                 child: Image.asset(
//                   "assets/images/logout (1)@2x.png",
//                   width: 40.w,
//                   height: 50.h,
//                 ),
//               ),
//               SizedBox(
//                 height: 22.h,
//               ),
//               Align(
//                 alignment: Alignment.center,
//                 child: Text(
//                   "Are you sure you want to Logout?",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 22.sp,
//                     //fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),

//               sizedBoxHeight(21.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Get.toNamed("/loginScreen");
//                     },
//                     child: Container(
//                       height: 48.h,
//                       width: 140.w,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.h),
//                           color: AppColors.buttoncolour),
//                       child: Center(
//                         child: Text(
//                           "Yes",
//                           style: TextStyle(
//                               color: AppColors.white, fontSize: 18.sp),
//                         ),
//                       ),
//                     ),
//                   ),
//                   sizedBoxWidth(28.w),
//                   InkWell(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Container(
//                       height: 48.h,
//                       width: 140.w,
//                       decoration: BoxDecoration(
//                           border: Border.all(color: const Color(0XFF0E5F02)),
//                           borderRadius: BorderRadius.circular(10.h),
//                           color: AppColors.white),
//                       child: Center(
//                         child: Text(
//                           "No",
//                           style: TextStyle(
//                               color: AppColors.buttoncolour, fontSize: 18.sp),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

void navigateTo(int index, BuildContext context) {
  switch (index) {
    case 6:
      {
        null;
      }
      break;
    default:
      {
        null;
      }
  }
}

// Future<dynamic> logoutDailog(BuildContext context) {
//   return showModalBottomSheet(
//     isScrollControlled: true,
//     context: context,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(30),
//         topRight: Radius.circular(30),
//       ),
//     ),
//     builder: (context) {
//       return Container(
//         color: Colors.blue,
//         margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 24.w),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(
//               height: 30.h,
//             ),
//             Center(
//               child: Text(
//                 'Are you sure want to log out?',
//                 textAlign: TextAlign.center,
//                 style:
//                     TextStyle(fontSize: 17.sp, color: const Color(0xFF444444)),
//               ),
//             ),
//             SizedBox(
//               height: 37.h,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(
//                 left: 15,
//                 right: 15,
//               ),
//               child: SizedBox(
//                   width: double.infinity,
//                   height: 50.h,
//                   child: const Text('Login')),
//             ),
//             SizedBox(
//               height: 27.h,
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                 left: 15.w,
//                 right: 15.w,
//               ),
//               child: GestureDetector(
//                 onTap: () {
//                   print("going to homepage");
//                   Navigator.pop(context);
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   height: 50.h,
//                   decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(10),
//                     ),
//                     color: Color(0xFFffffff),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey,
//                         blurRadius: 1.0, // soften the shadow
//                         spreadRadius: 0, //extend the shadow
//                         offset: Offset(
//                           0.0, // Move to right 5  horizontally
//                           2.0, // Move to bottom 5 Vertically
//                         ),
//                       )
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       "Cancel",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontFamily: 'Poppins',
//                         fontSize: 18.sp,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

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
