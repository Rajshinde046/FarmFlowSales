import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/Utils/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'search_product_categories.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  bool lowFeed = true;
  bool saved = false;
  Stream<DateTime>? _clockStream;

  int selectedCurrentFeed = 0;

  @override
  void initState() {
    _clockStream = Stream<DateTime>.periodic(const Duration(seconds: 1), (_) {
      return DateTime.now();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: AppColors.transparent,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 80.h),
        child: FloatingActionButton(
            backgroundColor: AppColors.buttoncolour,
            onPressed: () {
              Get.toNamed('/searchnmain');
              // Get.to(() => const SearchProductCategories());
            },
            //  _incrementCounter,
            tooltip: 'Search',
            child: SvgPicture.asset(
              "assets/images/floatingbutton.svg",
              width: 51.w,
              height: 51.h,
            )
            // Icon(
            //   Icons.add,
            //   color: AppColors.white,
            // ),
            ),
      ),
      // extendBody: true,
      body: Container(
        // color: AppColors.white,
        child: SafeArea(
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
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SvgPicture.asset(
                                                          "assets/images/locationconnect.svg",
                                                          color:
                                                              AppColors.black,
                                                          height: 20.h,
                                                          width: 20.h,
                                                        ),
                                                        sizedBoxWidth(5.w),
                                                        textBlack18W5000(
                                                            "Ireland")
                                                      ],
                                                    ),
                                                    textGreen50Bold("22° C"),
                                                    StreamBuilder<DateTime>(
                                                      stream: _clockStream,
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          String
                                                              formattedDateTime =
                                                              DateFormat(
                                                                      'E, d MMM - hh:mm a')
                                                                  .format(snapshot
                                                                      .data!);

                                                          return Center(
                                                            child:
                                                                textBlack18W5000(
                                                              formattedDateTime,
                                                            ),
                                                          );
                                                        } else {
                                                          return textBlack18W5000(
                                                              'Loading...');
                                                        }
                                                      },
                                                    ),
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
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed("/notification");
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.h),
                                  color: AppColors.redFCDADA,
                                  // border: Border.all(
                                  //     color: AppColors.redFA5658, width: 1.h),
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
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 13.h,
                                            backgroundColor: AppColors.redFA5658
                                                .withOpacity(0.2),
                                            child: Icon(
                                              Icons.warning_amber_rounded,
                                              size: 16.h,
                                              color: AppColors.redFA5658,
                                            ),
                                          ),
                                          sizedBoxWidth(10.w),
                                          textblack14M("Loreum Ipsum Is"),
                                          const Spacer(),
                                          textGreen14("New")
                                        ],
                                      ),
                                      sizedBoxHeight(5.h),
                                      textGrey12L(
                                          "Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry Lorem")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            sizedBoxHeight(15.h),
                          ],
                        ),
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
                              sizedBoxHeight(10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/locationRoad.png",
                                        height: 80.h,
                                        width: 80.h,
                                      ),
                                      // SvgPicture.asset(
                                      //   'assets/images/locationRoad.svg',
                                      //   height: 80.h,
                                      //   width: 80.h,
                                      // ),

                                      sizedBoxHeight(10.h),

                                      textBlack20W7000("Deliveries"),
                                    ],
                                  ),
                                  Lottie.asset(
                                      "assets/lotties/delivery_track.json",
                                      height: 150.h,
                                      width: 160.w),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 7.w, vertical: 16.h),
                                child: Row(
                                  children: [
                                    deliveriesCard("assets/images/timer.png",
                                        "In Progress Deliveries", "3", 0),
                                    sizedBoxWidth(3.w),
                                    deliveriesCard("assets/images/clock.png",
                                        "Pending Deliveries", "19", 1),
                                    sizedBoxWidth(3.w),
                                    deliveriesCard("assets/images/calender.png",
                                        "In Progress Deliveries", "3", 2),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        sizedBoxHeight(20.h),
                        Row(
                          children: [
                            sfwCard(
                                "assets/images/sales.png", "Sales", "/sales"),
                            sizedBoxWidth(15.w),
                            sfwCard("assets/images/farmer.png", "Farmers",
                                "/farmer"),
                            sizedBoxWidth(15.w),
                            sfwCard("assets/images/warehouse.png", "Warehouse",
                                "/warehouse"),
                          ],
                        ),
                        sizedBoxHeight(10.h)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
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

  Widget deliveriesCard(String image, String title, String number, int index) {
    return Expanded(
      child: Container(
        height: 155.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(index == 0 ? 10.h : 0),
              bottomLeft: Radius.circular(index == 0 ? 10.h : 0),
              topRight: Radius.circular(index == 2 ? 10.h : 0),
              bottomRight: Radius.circular(index == 2 ? 10.h : 0)),
          color: AppColors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 5.w),
          child: Column(
            children: [
              Image.asset(
                image,
                // "assets/images/timer.png",
                height: 30.h,
                width: 18.w,
              ),

              sizedBoxHeight(10.h),

              textblack14M(title
                  // "In Progress Delivery"
                  ),

              // sizedBoxHeight(10.h),
              Spacer(),

              textGreen20W7000Mon(number)
            ],
          ),
        ),
      ),
    );
  }

  Widget sfwCard(String image, String title, String onTapnamed) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Get.toNamed(onTapnamed);
        },
        child: Container(
          height: 110.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.h),
            color: AppColors.pistaE3FFE9,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 5.h,
                spreadRadius: 0.5.h,
              )
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 5.w),
            child: Column(
              children: [
                Image.asset(
                  image,
                  // "assets/images/timer.png",
                  height: 46.h,
                  width: 46.h,
                ),

                sizedBoxHeight(10.h),

                textblack14M(title
                    // "In Progress Delivery"
                    ),

                // sizedBoxHeight(10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
