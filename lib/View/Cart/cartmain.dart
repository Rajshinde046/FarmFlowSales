import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/custom_button.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Cartmain extends StatefulWidget {
  const Cartmain({
    Key? key,
    this.minValue = 0,
    this.maxValue = 10,
    this.minValue1 = 0,
    this.maxValue1 = 10,
    this.minValue2 = 0,
    this.maxValue2 = 10,

    //  this.onChanged
  }) : super(key: key);
  final int minValue;
  final int maxValue;
  final int minValue1;
  final int maxValue1;
  final int minValue2;
  final int maxValue2;

  @override
  State<Cartmain> createState() => _CartmainState();
}

class _CartmainState extends State<Cartmain> {
  int counter = 0;
  int counter1 = 0;
  int counter2 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(left: 16.w, top: 42.h, right: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Subtotal € 850",
              style: GoogleFonts.montserrat(
                fontSize: 18.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            sizedBoxHeight(11.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 12.h,
                  backgroundColor: AppColors.buttoncolour,
                  child: Center(
                    child: Icon(
                      Icons.check,
                      size: 15.h,
                      color: AppColors.white,
                    ),
                  ),
                ),
                sizedBoxWidth(6.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "your order is eligible for free delivery.",
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        color: AppColors.buttoncolour,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    RichText(
                        text: TextSpan(
                            text: "select this option at checkout.",
                            style: GoogleFonts.montserrat(
                                fontSize: 16.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w400),
                            children: [
                          TextSpan(
                            text: "Details",
                            style: GoogleFonts.montserrat(
                                fontSize: 16.sp,
                                color: AppColors.buttoncolour,
                                fontWeight: FontWeight.w600),
                          )
                        ]))
                  ],
                )
              ],
            ),
            sizedBoxHeight(31.h),
            // CustomButton(text: "Proceed To Buy (3 Items)", onTap: () {}),
            InkWell(
              onTap: () {
                Get.toNamed("/selectfarmer"); 
              },
              child: Container(
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.h),
                    color: AppColors.buttoncolour),
                child: Center(
                  child: Text(
                    "Proceed To Buy (3 Items)",
                    style: TextStyle(color: AppColors.white, fontSize: 18.sp),
                  ),
                ),
              ),
            ),
            sizedBoxHeight(27.h),
            Container(
              width: 358.w,
              // height: 120.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xffF1F1F1),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff0000001F),
                        blurRadius: 12.0,
                        offset: Offset(0.0, 0.75),
                        spreadRadius: 2)
                  ]),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 22.w, right: 16.w, top: 8.h, bottom: 13.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/orderred.png",
                      width: 57.w,
                      height: 99.h,
                    ),
                    sizedBoxWidth(31.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pre-Calver Gain Gold",
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff141414),
                          ),
                        ),
                        sizedBoxHeight(7.h),
                        Image.asset(
                          "assets/images/cartmain.png",
                          width: 104.w,
                          height: 22.h,
                        ),
                        sizedBoxHeight(7.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "€ 500",
                              style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black),
                            ),
                            sizedBoxWidth(91.w),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (counter > widget.minValue) {
                                      counter--;
                                    }
                                    // widget.onChanged(counter);
                                  });
                                },
                                child: SvgPicture.asset(
                                    // "assets/images/minusbutton.svg",
                                    "assets/images/minus1.svg"
                                    // width: 20.w,
                                    // height: 40.h,
                                    ),
                              ),
                            ),
                            sizedBoxWidth(12.w),
                            SizedBox(
                              width: 14.w,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  "$counter",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xff141414),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            sizedBoxWidth(8.w),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (counter < widget.maxValue) {
                                      counter++;
                                    }
                                    // widget.onChanged(counter);
                                  });
                                },
                                child: SvgPicture.asset(
                                    // "assets/images/plusreorder.svg",
                                    "assets/images/plus1.svg"
                                    // width: 20.w,
                                    // height: 40.h,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            sizedBoxHeight(20.h),
            Container(
              width: 358.w,
              // height: 120.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xffF1F1F1),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff0000001F),
                        blurRadius: 12.0,
                        offset: Offset(0.0, 0.75),
                        spreadRadius: 2)
                  ]),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 22.w, right: 16.w, top: 8.h, bottom: 13.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/orderyellow.png",
                      width: 57.w,
                      height: 99.h,
                    ),
                    sizedBoxWidth(31.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pre-Calver Gain Gold",
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff141414),
                          ),
                        ),
                        sizedBoxHeight(7.h),
                        Image.asset(
                          "assets/images/cartmain.png",
                          width: 104.w,
                          height: 22.h,
                        ),
                        sizedBoxHeight(7.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "€ 500",
                              style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black),
                            ),
                            sizedBoxWidth(91.w),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (counter1 > widget.minValue1) {
                                      counter1--;
                                    }
                                    // widget.onChanged(counter1);
                                  });
                                },
                                child: SvgPicture.asset(
                                    // "assets/images/minusbutton.svg",
                                    "assets/images/minus1.svg"
                                    // width: 20.w,
                                    // height: 40.h,
                                    ),
                              ),
                            ),
                            sizedBoxWidth(12.w),
                            SizedBox(
                              width: 14.w,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  "$counter1",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xff141414),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            sizedBoxWidth(8.w),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (counter1 < widget.maxValue1) {
                                      counter1++;
                                    }
                                    // widget.onChanged(counter1);
                                  });
                                },
                                child: SvgPicture.asset(
                                    // "assets/images/plusreorder.svg",
                                    "assets/images/plus1.svg"
                                    // width: 20.w,
                                    // height: 40.h,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            sizedBoxHeight(20.h),
            Container(
              width: 358.w,
              // height: 120.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xffF1F1F1),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xff0000001F),
                        blurRadius: 12.0,
                        offset: Offset(0.0, 0.75),
                        spreadRadius: 2)
                  ]),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 22.w, right: 16.w, top: 8.h, bottom: 13.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/orderwhite.png",
                      width: 57.w,
                      height: 99.h,
                    ),
                    sizedBoxWidth(31.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pre-Calver Gain Gold",
                          style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff141414),
                          ),
                        ),
                        sizedBoxHeight(7.h),
                        Image.asset(
                          "assets/images/cartmain.png",
                          width: 104.w,
                          height: 22.h,
                        ),
                        sizedBoxHeight(7.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "€ 500",
                              style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black),
                            ),
                            sizedBoxWidth(91.w),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (counter2 > widget.minValue2) {
                                      counter2--;
                                    }
                                    // widget.onChanged(counter2);
                                  });
                                },
                                child: SvgPicture.asset(
                                    // "assets/images/minusbutton.svg",
                                    "assets/images/minus1.svg"
                                    // width: 20.w,
                                    // height: 40.h,
                                    ),
                              ),
                            ),
                            sizedBoxWidth(12.w),
                            SizedBox(
                              width: 14.w,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  "$counter2",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xff141414),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            sizedBoxWidth(8.w),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (counter2 < widget.maxValue2) {
                                      counter2++;
                                    }
                                    // widget.onChanged(counter2);
                                  });
                                },
                                child: SvgPicture.asset(
                                    // "assets/images/plusreorder.svg",
                                    "assets/images/plus1.svg"
                                    // width: 20.w,
                                    // height: 40.h,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
