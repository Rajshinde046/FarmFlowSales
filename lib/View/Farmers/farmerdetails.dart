import 'package:farm_flow_sales/Common/custom_appbar.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Farmerdetails extends StatefulWidget {
  const Farmerdetails({super.key});

  @override
  State<Farmerdetails> createState() => _FarmerdetailsState();
}

class _FarmerdetailsState extends State<Farmerdetails> {
  int selectedCurrentFeed = 0;
  List currentFeedData = [
    {
      "imagePath": "assets/images/buffalo.png",
      "feedFor": "Buffalo",
      "qty": "100"
    },
    {"imagePath": "assets/images/cow.png", "feedFor": "Cow", "qty": "600"},
    {"imagePath": "assets/images/Sheep1.png", "feedFor": "Sheep", "qty": "100"},
    {"imagePath": "assets/images/pig1.png", "feedFor": "Pig", "qty": "600"},
    {"imagePath": "assets/images/hen.png", "feedFor": "Hen", "qty": "100"},
  ];

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
              Text("Current Feed",
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  )),
              sizedBoxHeight(14.h),
              SizedBox(
                width: 358.w,
                child: Card(
                  color: const Color(0xffF1F1F1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 18.w, bottom: 22.h, right: 18.w, top: 23.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                                5,
                                (index) => currentFeedSelection(
                                    imagePath: currentFeedData[index]
                                        ["imagePath"],
                                    index: index))),
                        sizedBoxHeight(22.h),
                        Row(
                          children: [
                            Container(
                              width: 109.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: const Color(0xff9E9E9E)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 7.w, vertical: 9.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentFeedData[selectedCurrentFeed]
                                              ["feedFor"] +
                                          " - ",
                                      style: GoogleFonts.poppins(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.black),
                                    ),
                                    Text(
                                      currentFeedData[selectedCurrentFeed]
                                              ["qty"] +
                                          " Kg",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            sizedBoxWidth(7.h),
                            Container(
                              // width: 210.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: const Color(0xff9E9E9E)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 7.w, vertical: 9.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Reordering Date - ",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12.sp,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "29/05-2023",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12.sp,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              sizedBoxHeight(10.h),

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
                  fillColor: const Color(0xFFF1F1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
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
                  fillColor: const Color(0xFFF1F1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
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
                  fillColor: const Color(0xFFF1F1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
                  ),
                  hintStyle: TextStyle(
                      color: const Color(0xFF4D4D4D),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                      fontSize: 16.sp),
                  hintText: "Male",
                ),
              ),
              // sizedBoxHeight(17.h),
              // Text("Age",
              //     style: GoogleFonts.poppins(
              //       fontSize: 18.sp,
              //       color: Colors.black,
              //       fontWeight: FontWeight.w500,
              //     )),
              // sizedBoxHeight(3.h),
              // TextFormField(
              //   readOnly: true,
              //   decoration: InputDecoration(
              //     errorStyle: TextStyle(fontSize: 16.sp),
              //     contentPadding: EdgeInsets.all(17.h),
              //     filled: true,
              //     fillColor: Color(0xFFF1F1F1),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8.r),
              //       borderSide: BorderSide(
              //           color: Color(0xFF707070).withOpacity(0), width: 1),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8.r),
              //       borderSide: BorderSide(
              //           color: Color(0xFF707070).withOpacity(0), width: 1),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8.r),
              //       borderSide: BorderSide(
              //           color: Color(0xFF707070).withOpacity(0), width: 1),
              //     ),
              //     hintStyle: TextStyle(
              //         color: const Color(0xFF4D4D4D),
              //         fontWeight: FontWeight.w400,
              //         fontFamily: "Poppins",
              //         fontSize: 16.sp),
              //     hintText: "40",
              //   ),
              // ),
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
                  fillColor: const Color(0xFFF1F1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
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
              Text("First Line Of Address",
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
                  fillColor: const Color(0xFFF1F1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
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
              Text("Second Line Of Address",
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
                  fillColor: const Color(0xFFF1F1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
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
                  fillColor: const Color(0xFFF1F1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
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
              Text("Eircode",
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
                  fillColor: const Color(0xFFF1F1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: const Color(0xFF707070).withOpacity(0),
                        width: 1),
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
              // Text("Country",
              //     style: GoogleFonts.poppins(
              //       fontSize: 18.sp,
              //       color: Colors.black,
              //       fontWeight: FontWeight.w500,
              //     )),
              // sizedBoxHeight(3.h),
              // TextFormField(
              //   readOnly: true,
              //   decoration: InputDecoration(
              //     errorStyle: TextStyle(fontSize: 16.sp),
              //     contentPadding: EdgeInsets.all(17.h),
              //     filled: true,
              //     fillColor: Color(0xFFF1F1F1),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8.r),
              //       borderSide: BorderSide(
              //           color: Color(0xFF707070).withOpacity(0), width: 1),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8.r),
              //       borderSide: BorderSide(
              //           color: Color(0xFF707070).withOpacity(0), width: 1),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8.r),
              //       borderSide: BorderSide(
              //           color: Color(0xFF707070).withOpacity(0), width: 1),
              //     ),
              //     hintStyle: TextStyle(
              //         color: const Color(0xFF4D4D4D),
              //         fontWeight: FontWeight.w400,
              //         fontFamily: "Poppins",
              //         fontSize: 16.sp),
              //     hintText: "Ireland",
              //   ),
              // ),
            ],
          ),
        ),
      )),
    );
  }

  Widget currentFeedSelection({required String imagePath, required int index}) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedCurrentFeed = index;
        });
      },
      child: Container(
        width: 40.w,
        height: 30.h,
        decoration: BoxDecoration(
            // dec
            color: selectedCurrentFeed == index
                ? const Color.fromARGB(255, 236, 248, 239)
                : AppColors.white,
            borderRadius: BorderRadius.circular(5.h),
            border: Border.all(
                color: selectedCurrentFeed == index
                    ? AppColors.buttoncolour
                    : AppColors.grey4D4D4D)),
        child: Padding(
          padding: EdgeInsets.all(4.h),
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}
