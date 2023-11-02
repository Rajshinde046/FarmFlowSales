import 'package:dotted_line/dotted_line.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Orderdetails extends StatefulWidget {
  const Orderdetails({super.key});

  @override
  State<Orderdetails> createState() => _OrderdetailsState();
}

class _OrderdetailsState extends State<Orderdetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 16.w),
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
                    "Order Details",
                    style: TextStyle(
                      color: const Color(0XFF141414),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            sizedBoxHeight(9.h),
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Text(
                "Order Id : 54545645465",
                style: TextStyle(
                  fontSize: 18.sp,
                  color: const Color(0XFF141414),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins",
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedBoxHeight(10.h),
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/locationconnect.svg",
                                      width: 13.w,
                                      height: 17.h,
                                    ),
                                    sizedBoxWidth(6.w),
                                    Text(
                                      "Delivering To",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w300,
                                          color: const Color(0xff4D4D4D),
                                          fontFamily: "Poppins"),
                                    ),
                                  ],
                                ),
                                sizedBoxHeight(1.h),
                                Text(
                                  "22b baker street St, Marylebone, \nIreland",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: const Color(0XFF141414),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Text(
                              "Edit",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: const Color(0XFF0E5F02),
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    sizedBoxHeight(17.h),
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 82.w,
                            height: 88.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.h),
                                border: Border.all(
                                  color: const Color(0xff918E8E),
                                ),
                                color: AppColors.white),
                            child: Image.asset(
                              "assets/images/redorder.png",
                              width: 76.w,
                              height: 71.h,
                            ),
                          ),
                          sizedBoxWidth(15.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Elite Dairy 15% BULK",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: const Color(0XFF141414),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins"),
                              ),
                              sizedBoxHeight(2.h),
                              Text(
                                "Quantity : 5",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w300,
                                    color: const Color(0XFF4D4D4D),
                                    fontFamily: "Poppins"),
                              ),
                              sizedBoxHeight(2.h),
                              Text(
                                "€ 500",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0XFF141414),
                                    fontFamily: "Poppins"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    sizedBoxHeight(9.h),
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 82.w,
                            height: 88.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.h),
                                border: Border.all(
                                  color: const Color(0XFF918E8E),
                                ),
                                color: AppColors.white),
                            child: Image.asset(
                              "assets/images/yelloworder.png",
                              width: 76.w,
                              height: 71.h,
                            ),
                          ),
                          sizedBoxWidth(15.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Agrofeed Ruminant Feed",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: const Color(0XFF141414),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins"),
                              ),
                              sizedBoxHeight(2.h),
                              Text(
                                "Quantity : 5",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: const Color(0XFF4D4D4D),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Poppins"),
                              ),
                              sizedBoxHeight(2.h),
                              Text(
                                "€ 500",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: const Color(0XFF141414),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    sizedBoxHeight(9.h),
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 82.w,
                            height: 88.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.h),
                                border: Border.all(
                                  color: const Color(0XFF918E8E),
                                ),
                                color: AppColors.white),
                            child: Image.asset(
                              "assets/images/brownorder.png",
                              width: 76.w,
                              height: 71.h,
                            ),
                          ),
                          sizedBoxWidth(15.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Agrofeed Ruminant Feed",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: const Color(0XFF141414),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins"),
                              ),
                              sizedBoxHeight(2.h),
                              Text(
                                "Quantity : 5",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: const Color(0XFF4D4D4D),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Poppins"),
                              ),
                              sizedBoxHeight(2.h),
                              Text(
                                "€ 500",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: const Color(0XFF141414),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    sizedBoxHeight(26.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: const Color(0XFF4D4D4D),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Cow Feed",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: const Color(0xff141414),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    sizedBoxHeight(14.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Amount",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: const Color(0XFF4D4D4D),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            "€ 5000",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: const Color(0XFF141414),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500),
                          ),
                          sizedBoxWidth(11.h),
                          Padding(
                            padding: EdgeInsets.only(top: 2.h),
                            child: Text(
                              "(3 Items)",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0XFF4D4D4D),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    sizedBoxHeight(13.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Container(
                        width: 358.w,
                        height: 35.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0XFF918E8E),
                          ),
                          color: AppColors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/download.svg",
                              // width: 12.w,
                              // height: 13.h,
                            ),
                            sizedBoxWidth(10.w),
                            Text(
                              "Download Invoice",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "Poppins",
                                  color: const Color(0XFF0E5F02),
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    sizedBoxHeight(22.h),
                    Padding(
                      padding: EdgeInsets.only(left: 51.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              sizedBoxHeight(8.h),
                              status(),
                              const DottedLine(
                                direction: Axis.vertical,
                                lineLength: 47,
                                lineThickness: 2.0,
                                dashLength: 4.0,
                                dashColor: Color(0XFF0E5F02),
                              ),
                              status(),
                              const Dash(
                                  direction: Axis.vertical,
                                  length: 25,
                                  dashLength: 49,
                                  dashGap: 0,
                                  dashColor: Color(0XFF0E5F02)),
                              status(),
                              const Dash(
                                  direction: Axis.vertical,
                                  length: 25,
                                  dashLength: 39,
                                  dashGap: 0,
                                  dashColor: Color(0XFF0E5F02)),
                              status(),
                            ],
                          ),
                          sizedBoxWidth(18.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              sizedBoxHeight(3.h),
                              Text(
                                "Delivered",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff141414),
                                    fontFamily: "Poppins"),
                              ),
                              Text(
                                "Pending",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff4D4D4D),
                                    fontFamily: "Poppins"),
                              ),
                              sizedBoxHeight(22.h),
                              Text(
                                "Out For Delivery",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff141414),
                                    fontFamily: "Poppins"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tuesday",
                                    style: TextStyle(
                                        color: const Color(0xff4D4D4D),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins"),
                                  ),
                                  sizedBoxWidth(3.w),
                                  SvgPicture.asset(
                                    "assets/images/Ellipse 780.svg",
                                    width: 4.w,
                                    height: 4.h,
                                  ),
                                  sizedBoxWidth(5.w),
                                  Text(
                                    "Jan 30, 10.12 PM",
                                    style: TextStyle(
                                        color: const Color(0xff4D4D4D),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins"),
                                  ),
                                ],
                              ),
                              sizedBoxHeight(25.h),
                              Text(
                                "Packed & Ready",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff141414),
                                    fontFamily: "Poppins"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Wednesday",
                                    style: TextStyle(
                                        color: const Color(0xff4D4D4D),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins"),
                                  ),
                                  sizedBoxWidth(3.w),
                                  SvgPicture.asset(
                                    "assets/images/Ellipse 780.svg",
                                    width: 4.w,
                                    height: 4.h,
                                  ),
                                  sizedBoxWidth(5.w),
                                  Text(
                                    "Jan 30, 10.12 PM",
                                    style: TextStyle(
                                        color: const Color(0xff4D4D4D),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins"),
                                  ),
                                ],
                              ),
                              sizedBoxHeight(15.h),
                              Text(
                                "Ordered",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff141414),
                                    fontFamily: "Poppins"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Friday",
                                    style: TextStyle(
                                        color: const Color(0xff4D4D4D),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins"),
                                  ),
                                  sizedBoxWidth(3.w),
                                  SvgPicture.asset(
                                    "assets/images/Ellipse 780.svg",
                                    width: 4.w,
                                    height: 4.h,
                                  ),
                                  sizedBoxWidth(5.w),
                                  Text(
                                    "Jan 30, 10.12 PM",
                                    style: TextStyle(
                                        color: const Color(0xff4D4D4D),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        fontFamily: "Poppins"),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    sizedBoxHeight(20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: 50.h,
                          width: 358.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.h),
                              color: AppColors.buttoncolour),
                          child: Center(
                            child: Text(
                              "Call Delivery Agent",
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ),
                    sizedBoxHeight(26.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Container(
                        width: 358.w,
                        // height: 115.h,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color(0xffF1F1F1),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF00000029),
                                  blurRadius: 6.0,
                                  spreadRadius: 0)
                            ]),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w, top: 5.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 5.h),
                                child: SvgPicture.asset(
                                  "assets/images/list.svg",
                                  width: 53.w,
                                  height: 53.h,
                                ),
                              ),
                              sizedBoxWidth(10.w),
                              Padding(
                                padding: EdgeInsets.only(top: 14.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Order Summary",
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: const Color(0xff141414),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Poppins"),
                                    ),
                                    sizedBoxHeight(8.h),
                                    Text(
                                      "Order g: 408-0073624-7437935",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: const Color(0XFF141414),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Poppins"),
                                    ),
                                    sizedBoxHeight(7.h),
                                    Text(
                                      "Ordered February 5, 2023 8:01 pm",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: const Color(0XFF141414),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Poppins"),
                                    ),
                                    sizedBoxHeight(18.h),
                                  ],
                                ),
                              ),
                              //)
                            ],
                          ),
                        ),
                      ),
                    ),
                    sizedBoxHeight(20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget status() {
    return CircleAvatar(
      backgroundColor: AppColors.buttoncolour,
      radius: 6.h,
    );
  }
}
