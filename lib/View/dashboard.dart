
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/Utils/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  bool lowFeed = true;
  bool saved = false;

  int selectedCurrentFeed = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(75.w, 10.h, 16.w, 10.h),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textBlack20W7000Mon("Dashboard"),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    height: 42.h,
                    width: 42.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.h),
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 5.h,
                          spreadRadius: 2.h,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed("/notification");
                          },
                          child: SvgPicture.asset(
                            "assets/images/notification_bell.svg",
                            height: 28.h,
                            width: 28.h,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  sizedBoxWidth(10.w),
                  Container(
                    height: 42.h,
                    width: 42.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.h),
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 5.h,
                          spreadRadius: 2.h,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed("/settings");
                            // Get.toNamed("/settings");
                          },
                          child: SvgPicture.asset(
                            "assets/images/Settings.svg",
                            height: 28.h,
                            width: 28.h,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(27.h),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 10,
                              spreadRadius: 2,
                            )
                          ],
                          color: AppColors.pistaE3FFE9,
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Lottie.asset(
                                    "assets/lotties/cloud2.json",
                                    height: 156.h,
                                    width: 156.w,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      20.w, 15.h, 36.w, 20.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Stack(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  textBlack20W7000Mon(
                                                      "Welcome Back Kevin"),
                                                  sizedBoxHeight(15.h),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/images/locationconnect.svg",
                                                        color: AppColors.black,
                                                        height: 20.h,
                                                        width: 20.h,
                                                      ),
                                                      sizedBoxWidth(5.w),
                                                      textBlack18W5000(
                                                          "Ireland")
                                                    ],
                                                  ),
                                                  textGreen50Bold("22° C"),
                                                  textBlack18W5000(
                                                      "Sat, 3 Nov -12.32PM"),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      sizedBoxHeight(15.h),
                      Visibility(
                        visible: lowFeed,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.h),
                                color: AppColors.redFCDADA,
                                border: Border.all(
                                    color: AppColors.redFA5658, width: 1.h),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  )
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 10.h),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 18.h,
                                      backgroundColor: AppColors.redFA5658,
                                      child: CircleAvatar(
                                        radius: 13.h,
                                        backgroundColor: AppColors.white,
                                        child: Icon(
                                          Icons.warning_amber_rounded,
                                          size: 16.h,
                                          color: AppColors.redFA5658,
                                        ),
                                      ),
                                    ),
                                    sizedBoxWidth(20.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        textblack14M("Loreum Ipsum Is"),
                                        sizedBoxHeight(5.h),
                                        textGrey12L(
                                            "Loreum Ipsum Is Simple Dummy text")
                                      ],
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          lowFeed = false;
                                        });
                                      },
                                      child: CircleAvatar(
                                        radius: 13.h,
                                        backgroundColor: AppColors.white,
                                        child: Icon(
                                          Icons.close,
                                          size: 15.h,
                                          color: AppColors.grey4D4D4D,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            sizedBoxHeight(15.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                5,
                                (index) => Container(
                                  decoration: BoxDecoration(
                                      color: index == 2
                                          ? AppColors.buttoncolour
                                          : const Color(0xffE1E1E1),
                                      borderRadius:
                                          BorderRadius.circular(25.r)),
                                  height: 7.h,
                                  width: index == 2 ? 30.h : 7.h,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 3.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 10.h),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(24.w, 15.h, 24.w, 0),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(19.h)),
                              color: AppColors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x48B9B9BE),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                )
                              ]),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textBlack20W7000("Start Delivery"),
                                  Lottie.asset(
                                      "assets/lotties/delivery_track.json",
                                      height: 120.h,
                                      width: 137.w)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      sizedBoxHeight(10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          bottomContainer('In Progress Delivery', '03'),
                          bottomContainer('Pending Delivery', '19'),
                        ],
                      ),
                      sizedBoxHeight(20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          bottomContainer('Reschedule Delivery', '05'),
                          bottomContainer('Complete Delivery', '153'),
                        ],
                      ),
                      sizedBoxHeight(20.h),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.h),
                          color: AppColors.redFCDADA,
                          border: Border.all(
                              color: AppColors.redFA5658, width: 1.h),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 10,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 10.h),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/images/Settings.svg'),
                              sizedBoxWidth(20.w),
                              textGrey4D4D4D_16('Cancelled Delivery'),
                              const Spacer(),
                              Text(
                                '02',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      sizedBoxHeight(20.h),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomContainer(String txt, String number) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 26.w,
      height: 128.h,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff0E5F02), width: 0.2.h),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
        color: AppColors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(8.h),
                height: 41.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: const Color(0xffB1E8A9),
                ),
                width: 45.w,
                child: Center(
                  child: SvgPicture.asset('assets/images/Settings.svg'),
                ),
              ),
              Flexible(child: textBlack16(txt))
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              sizedBoxWidth(5.w),
              textGreen50R(number),
              const Spacer(),
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: const Color(0xffB1E8A9).withOpacity(0.32),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
