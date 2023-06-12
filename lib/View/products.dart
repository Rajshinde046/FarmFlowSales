import 'package:farm_flow_sales/Common/custom_appbar.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Productspage extends StatefulWidget {
  const Productspage({super.key});

  @override
  State<Productspage> createState() => _ProductspageState();
}

class _ProductspageState extends State<Productspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // appBar: AppBar(
      //   backgroundColor: AppColors.white,
      //   title: customAppBar(text: "Products"),
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      //   titleSpacing: 0,
      // ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Products",
                  style: TextStyle(
                    color: const Color(0XFF141414),
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  sizedBoxHeight(31.h),
                  redcard(),
                  sizedBoxHeight(19.h),
                  yellowcard(),
                  sizedBoxHeight(19.h),
                  SizedBox(
                    width: 358.w,
                    child: Card(
                      elevation: 2,
                      color: Color(0xffF1F1F1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 22.w, right: 16.w, top: 8.h, bottom: 13.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pre-Calver Gain Gold",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff141414),
                                      fontFamily: "Poppins"),
                                ),
                                sizedBoxHeight(3.h),
                                Text(
                                  "€ 500",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff141414),
                                      fontFamily: "Poppins"),
                                ),
                                sizedBoxHeight(3.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      child: Text("5 Lbs",
                                          style: GoogleFonts.poppins(
                                            fontSize: 14.sp,
                                            color: Color(0xff4D4D4D),
                                          )),
                                    ),
                                    sizedBoxWidth(64.w),
                                    Text(
                                      "Quantity : 800",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16.sp,
                                          color: Color(0xff0E5F02),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            sizedBoxWidth(30.w),
                            Image.asset(
                              "assets/images/orderwhite.png",
                              width: 49.w,
                              height: 87.h,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  sizedBoxHeight(19.h),
                  redcard(),
                  sizedBoxHeight(19.h),
                  yellowcard(),
                  sizedBoxHeight(19.h),
                ],
              ),
            ),
          ))
        ],
      )),
    );
  }

  Widget redcard() {
    return SizedBox(
      width: 358.w,
      child: Card(
        elevation: 2,
        color: Color(0xffF1F1F1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding:
              EdgeInsets.only(left: 22.w, right: 16.w, top: 8.h, bottom: 13.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pre-Calver Gain Gold",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff141414),
                        fontFamily: "Poppins"),
                  ),
                  sizedBoxHeight(3.h),
                  Text(
                    "€ 500",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff141414),
                        fontFamily: "Poppins"),
                  ),
                  sizedBoxHeight(3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 50,
                        child: Text("5 Lbs",
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: Color(0xff4D4D4D),
                            )),
                      ),
                      sizedBoxWidth(64.w),
                      Text(
                        "Quantity : 1000",
                        style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            color: Color(0xff0E5F02),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              sizedBoxWidth(30.w),
              Image.asset(
                "assets/images/orderred.png",
                width: 49.w,
                height: 87.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget yellowcard() {
    return SizedBox(
      width: 358.w,
      child: Card(
        elevation: 2,
        color: Color(0xffF1F1F1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding:
              EdgeInsets.only(left: 22.w, right: 16.w, top: 8.h, bottom: 13.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Agrofeed Ruminant Feed",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff141414),
                        fontFamily: "Poppins"),
                  ),
                  sizedBoxHeight(3.h),
                  Text(
                    "€ 500",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff141414),
                        fontFamily: "Poppins"),
                  ),
                  sizedBoxHeight(3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 50,
                        child: Text("5 Lbs",
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: Color(0xff4D4D4D),
                            )),
                      ),
                      sizedBoxWidth(64.w),
                      Text(
                        "Quantity : 1200",
                        style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            color: Color(0xff0E5F02),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              sizedBoxWidth(30.w),
              Image.asset(
                "assets/images/orderyellow.png",
                // "assets/images/mail.png",
                width: 49.w,
                height: 87.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
