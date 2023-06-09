import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Faq extends StatefulWidget {
  const Faq({super.key});

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    backgroundColor: Color(0XFFF1F1F1),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 25.h,
                          color: Color(0XFF141414),
                        ),
                      ),
                    ),
                  ),
                ),
                sizedBoxWidth(15.w),
                Text(
                  "FAQ's",
                  style: TextStyle(
                    color: Color(0XFF141414),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          sizedBoxHeight(21.h),
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: GestureDetector(
              onTap: () {
                Get.toNamed('/faqcontent');
              },
              child: SizedBox(
                width: 358.w,
                height: 220.h,
                child: Card(
                  // elevation: 2,
                  color: Color(0xffF1F1F1),
                  // shadowColor: Color(0XFF00000029),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    //set border radius more than 50% of height and width to make circle
                  ),
                  // Container(
                  //   width: 358.w,
                  //   height: 185.h,
                  //   decoration: BoxDecoration(
                  //       color: Color(0xffF1F1F1),
                  //       borderRadius: BorderRadius.circular(20.r),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Color(0XFF00000029),
                  //           blurRadius: 15.0,
                  //           spreadRadius: 3,
                  //            offset: Offset(0.0, 0.75)
                  //         )
                  //       ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/faqorder.png",
                        width: 118.w,
                        height: 118.h,
                      ),
                      sizedBoxHeight(6.h),
                      Text(
                        "Orders",
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          // ),
          sizedBoxHeight(27.h),
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: GestureDetector(
              onTap: () {
                Get.toNamed('/faqcontent');
              },
              child: SizedBox(
                width: 358.w,
                height: 220.h,
                child: Card(
                  color: Color(0xffF1F1F1),
                  // shadowColor: Color(0XFF00000029),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    //set border radius more than 50% of height and width to make circle
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/faqdelivery.png",
                        width: 118.w,
                        height: 118.h,
                      ),
                      sizedBoxHeight(6.h),
                      Text(
                        "Delivery",
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          sizedBoxHeight(21.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: GestureDetector(
              onTap: () {
                Get.toNamed('/faqcontent');
              },
              child: SizedBox(
                width: 358.w,
                height: 220.h,
                child: Card(
                  color: Color(0xffF1F1F1),
                  // shadowColor: Color(0XFF00000029),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    //set border radius more than 50% of height and width to make circle
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/faqscurrency.png",
                        width: 118.w,
                        height: 118.h,
                      ),
                      sizedBoxHeight(6.h),
                      Text(
                        "Returns & Refunds",
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
