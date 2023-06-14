import 'package:farm_flow_sales/Common/CommonTextFormField.dart';
import 'package:farm_flow_sales/Common/custom_appbar.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Farmerdetails extends StatefulWidget {
  const Farmerdetails({super.key});

  @override
  State<Farmerdetails> createState() => _FarmerdetailsState();
}

class _FarmerdetailsState extends State<Farmerdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: customAppBar(text: "Farmer Details"),
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 35.h),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // sizedBoxHeight(35.h),
              Center(
                child: Image.asset(
                  "assets/images/contactperson2.png",
                  width: 88.w,
                  height: 88.h,
                ),
              ),
              sizedBoxHeight(23.h),
              Text("Name",
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  )),
              sizedBoxHeight(3.h),

              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  errorStyle: TextStyle(fontSize: 16.sp),
                  contentPadding: EdgeInsets.all(17.h),
                  filled: true,
                  fillColor: Color(0xFFF1F1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  hintStyle: TextStyle(
                      color: const Color(0xFF4D4D4D),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                      fontSize: 16.sp),
                  hintText: "John O Brien",
                ),
              ),
              sizedBoxHeight(17.h),
              Text("Phone Number",
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  )),
              sizedBoxHeight(3.h),

              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  errorStyle: TextStyle(fontSize: 16.sp),
                  contentPadding: EdgeInsets.all(17.h),
                  filled: true,
                  fillColor: Color(0xFFF1F1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  hintStyle: TextStyle(
                      color: const Color(0xFF4D4D4D),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                      fontSize: 16.sp),
                  hintText: "0873457549",
                ),
              ),
              sizedBoxHeight(17.h),
              Text("Gender",
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  )),
              sizedBoxHeight(3.h),

              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  errorStyle: TextStyle(fontSize: 16.sp),
                  contentPadding: EdgeInsets.all(17.h),
                  filled: true,
                  fillColor: Color(0xFFF1F1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  hintStyle: TextStyle(
                      color: const Color(0xFF4D4D4D),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                      fontSize: 16.sp),
                  hintText: "Male",
                ),
              ),
              sizedBoxHeight(17.h),
              Text("Age",
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  )),
              sizedBoxHeight(3.h),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  errorStyle: TextStyle(fontSize: 16.sp),
                  contentPadding: EdgeInsets.all(17.h),
                  filled: true,
                  fillColor: Color(0xFFF1F1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  hintStyle: TextStyle(
                      color: const Color(0xFF4D4D4D),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                      fontSize: 16.sp),
                  hintText: "40",
                ),
              ),
              sizedBoxHeight(17.h),
              Text("Farm Address",
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  )),
              sizedBoxHeight(3.h),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  errorStyle: TextStyle(fontSize: 16.sp),
                  contentPadding: EdgeInsets.all(17.h),
                  filled: true,
                  fillColor: Color(0xFFF1F1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  hintStyle: TextStyle(
                      color: const Color(0xFF4D4D4D),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                      fontSize: 16.sp),
                  hintText: "Kingswell",
                ),
              ),
              sizedBoxHeight(17.h),
              Text("Street",
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  )),
              sizedBoxHeight(3.h),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  errorStyle: TextStyle(fontSize: 16.sp),
                  contentPadding: EdgeInsets.all(17.h),
                  filled: true,
                  fillColor: Color(0xFFF1F1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  hintStyle: TextStyle(
                      color: const Color(0xFF4D4D4D),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                      fontSize: 16.sp),
                  hintText: "64 martens place",
                ),
              ),
              sizedBoxHeight(17.h),
              Text("City",
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  )),
              sizedBoxHeight(3.h),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  errorStyle: TextStyle(fontSize: 16.sp),
                  contentPadding: EdgeInsets.all(17.h),
                  filled: true,
                  fillColor: Color(0xFFF1F1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  hintStyle: TextStyle(
                      color: const Color(0xFF4D4D4D),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                      fontSize: 16.sp),
                  hintText: "dunwich",
                ),
              ),
              sizedBoxHeight(17.h),
              Text("State/Province/Area",
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  )),
              sizedBoxHeight(3.h),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  errorStyle: TextStyle(fontSize: 16.sp),
                  contentPadding: EdgeInsets.all(17.h),
                  filled: true,
                  fillColor: Color(0xFFF1F1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  hintStyle: TextStyle(
                      color: const Color(0xFF4D4D4D),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                      fontSize: 16.sp),
                  hintText: "queensland",
                ),
              ),
              sizedBoxHeight(17.h),
              Text("Zip code",
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  )),
              sizedBoxHeight(3.h),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  errorStyle: TextStyle(fontSize: 16.sp),
                  contentPadding: EdgeInsets.all(17.h),
                  filled: true,
                  fillColor: Color(0xFFF1F1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  hintStyle: TextStyle(
                      color: const Color(0xFF4D4D4D),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                      fontSize: 16.sp),
                  hintText: "4183",
                ),
              ),
              sizedBoxHeight(17.h),
              Text("Country",
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  )),
              sizedBoxHeight(3.h),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  errorStyle: TextStyle(fontSize: 16.sp),
                  contentPadding: EdgeInsets.all(17.h),
                  filled: true,
                  fillColor: Color(0xFFF1F1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  hintStyle: TextStyle(
                      color: const Color(0xFF4D4D4D),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                      fontSize: 16.sp),
                  hintText: "Ireland",
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
