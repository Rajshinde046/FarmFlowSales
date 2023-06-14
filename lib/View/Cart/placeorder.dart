import 'package:farm_flow_sales/Common/custom_button_curve.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Placedorder extends StatefulWidget {
  const Placedorder({
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
  State<Placedorder> createState() => _PlacedorderState();
}

class _PlacedorderState extends State<Placedorder> {
  int counter = 0;
  int counter1 = 0;
  int counter2 = 0;

  buildorderconfirmpopup() {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(
          //   height: 45,
          //   width: 45,
          //   child: FittedBox(
          //     child: FloatingActionButton(
          //         elevation: 0,
          //         backgroundColor: Colors.white,
          //         onPressed: () {
          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) => SchduleAppointment()));
          //         },
          //         child: Icon(
          //           Icons.close,
          //           size: 30,
          //         )),
          //   ),
          // ),
          AlertDialog(
            insetPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
            contentPadding: EdgeInsets.fromLTRB(15, 30, 15, 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(
                  color: Get.isDarkMode ? Colors.grey : Colors.white),
            ),
            // contentPadding:
            //     EdgeInsets.all(
            //         10),
            //   title: ,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 45),
                      child: Text(
                        textAlign: TextAlign.center,
                        "Your Order Has Been Placed Successfully!",
                        style: GoogleFonts.poppins(
                            fontSize: 20.sp,
                            color: Color(0xff4D4D4D),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed("/placeordermain");
                  },
                  child: Container(
                    height: 50.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.h),
                        color: AppColors.buttoncolour),
                    child: Center(
                      child: Text(
                        "Ok",
                        style:
                            TextStyle(color: AppColors.white, fontSize: 18.sp),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 44.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                "assets/images/placedorder.svg",
                width: 411.w,
                // height: 45.h,
              ),
              sizedBoxHeight(28.h),
              Text(
                "Farmer Name",
                style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500),
              ),
              sizedBoxHeight(7.h),
              Container(
                width: 358.w,
                // height: 48.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Color(0xffF1F1F1),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 19.w, top: 12, bottom: 11),
                  child: Text(
                    "Kevin Mounsey",
                    style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              sizedBoxHeight(21.h),
              Container(
                width: 358.w,
                height: 263.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Color(0xffF1F1F1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 7.w),
                      child: SvgPicture.asset(
                        "assets/images/address.svg",
                        width: 29.w,
                        height: 29.h,
                      ),
                    ),
                    sizedBoxWidth(13.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Text(
                            "Address",
                            style: GoogleFonts.poppins(
                              fontSize: 20.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        sizedBoxHeight(4.h),
                        RichText(
                          text: TextSpan(
                            text: "street : ",
                            style: GoogleFonts.montserrat(
                                fontSize: 16.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                text: "64 martens place",
                                style: GoogleFonts.montserrat(
                                    fontSize: 16.sp,
                                    color: Color(0xff4D4D4D),
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        sizedBoxHeight(5.h),
                        RichText(
                          text: TextSpan(
                            text: "city : ",
                            style: GoogleFonts.montserrat(
                                fontSize: 16.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                text: "dunwich",
                                style: GoogleFonts.montserrat(
                                    fontSize: 16.sp,
                                    color: Color(0xff4D4D4D),
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        sizedBoxHeight(5.h),
                        RichText(
                          text: TextSpan(
                            text: "state/province/area : ",
                            style: GoogleFonts.montserrat(
                                fontSize: 16.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                text: "queensland",
                                style: GoogleFonts.montserrat(
                                    fontSize: 16.sp,
                                    color: Color(0xff4D4D4D),
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        sizedBoxHeight(5.h),
                        RichText(
                          text: TextSpan(
                            text: "phone number : ",
                            style: GoogleFonts.montserrat(
                                fontSize: 16.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                text: "(07) 3830 6616",
                                style: GoogleFonts.montserrat(
                                    fontSize: 16.sp,
                                    color: Color(0xff4D4D4D),
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        sizedBoxHeight(5.h),
                        RichText(
                          text: TextSpan(
                            text: "zip code : ",
                            style: GoogleFonts.montserrat(
                                fontSize: 16.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                text: "4183",
                                style: GoogleFonts.montserrat(
                                    fontSize: 16.sp,
                                    color: Color(0xff4D4D4D),
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        sizedBoxHeight(5.h),
                        RichText(
                          text: TextSpan(
                            text: "country : ",
                            style: GoogleFonts.montserrat(
                                fontSize: 16.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                text: "Ireland",
                                style: GoogleFonts.montserrat(
                                    fontSize: 16.sp,
                                    color: Color(0xff4D4D4D),
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              sizedBoxHeight(24.h),
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
                          sizedBoxHeight(3.h),
                          Text(
                            "lorem ipsum is simply dummy",
                            style: GoogleFonts.poppins(
                                fontSize: 15.sp,
                                color: Color(0xff4D4D4D),
                                fontWeight: FontWeight.w300),
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
                          sizedBoxHeight(3.h),
                          Text(
                            "lorem ipsum is simply dummy",
                            style: GoogleFonts.poppins(
                                fontSize: 15.sp,
                                color: Color(0xff4D4D4D),
                                fontWeight: FontWeight.w300),
                          ),
                          sizedBoxHeight(7.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "€ 200",
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
                          sizedBoxHeight(2.h),
                          Text(
                            "lorem ipsum is simply dummy",
                            style: GoogleFonts.poppins(
                                fontSize: 15.sp,
                                color: Color(0xff4D4D4D),
                                fontWeight: FontWeight.w300),
                          ),
                          sizedBoxHeight(7.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "€ 150",
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
              sizedBoxHeight(3.h),
              Divider(
                thickness: 1,
                color: AppColors.buttoncolour,
              ),
              sizedBoxHeight(7.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total MRP",
                    style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        color: Color(0xff4D4D4D),
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "€ 500",
                    style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        color: Color(0xff4D4D4D),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              sizedBoxHeight(15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Discount on MRP",
                    style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        color: Color(0xff4D4D4D),
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "- 10%",
                    style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        color: Color(0xff4D4D4D),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              sizedBoxHeight(3.h),
              Divider(
                thickness: 1,
                color: AppColors.buttoncolour,
              ),
              sizedBoxHeight(3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Amount",
                    style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        color: AppColors.buttoncolour,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "€ 450",
                    style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        color: AppColors.buttoncolour,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              sizedBoxHeight(29.h),
              customButtonCurve(
                  text: "Confirm Delivery",
                  onTap: () {
                    buildorderconfirmpopup();
                  }),
              sizedBoxHeight(30.h)
            ],
          ),
        ),
      ),
    );
  }
}
