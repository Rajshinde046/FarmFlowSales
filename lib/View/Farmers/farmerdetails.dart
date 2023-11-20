import 'package:farm_flow_sales/Common/custom_appbar.dart';
import 'package:farm_flow_sales/Utils/api_urls.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/Utils/utils.dart';
import 'package:farm_flow_sales/View/Side%20Menu/Profile/profile.dart';
import 'package:farm_flow_sales/models/farmerDetailsModel.dart';
import 'package:farm_flow_sales/view_models/farmer/FarmerdetailsAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Farmerdetails extends StatefulWidget {
  const Farmerdetails({super.key});

  @override
  State<Farmerdetails> createState() => _FarmerdetailsState();
}

class _FarmerdetailsState extends State<Farmerdetails> {
  String id = Get.arguments["id"];
  int selectedCurrentFeed = 0;

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
            child: FutureBuilder<FarmerDetailsModel>(
              future: FarmerDetailsAPI(id.toString()).farmerDetailsApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data?.data == null) {
                  return Center(child: Text('No farmer available'));
                }
                Data farmerData = snapshot.data!.data!;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // sizedBoxHeight(35.h),
                    Center(
                      child: farmerData.farmerDetails!.profilePhoto == null
                          ? Image.asset(
                              "assets/images/contactperson2.png",
                              width: 88.w,
                              height: 88.h,
                            )
                          : Image.network(
                              "${ApiUrls.baseImageUrl}/${farmerData.farmerDetails!.profilePhoto}",
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
                        color: Color(0xffF1F1F1),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  farmerData.feedDetails!.length,
                                  (index) => Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: currentFeedSelection(
                                        imagePath: farmerData.feedDetails!
                                            .elementAt(index)
                                            .livestockUri!,
                                        index: index),
                                  ),
                                ),
                              ),
                              sizedBoxHeight(22.h),
                              Row(
                                children: [
                                  Container(
                                    width: 109.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: Color(0xff9E9E9E)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 7.w, vertical: 9.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            farmerData
                                                .feedDetails![
                                                    selectedCurrentFeed]
                                                .livestockName!,
                                            style: GoogleFonts.poppins(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.black),
                                          ),
                                          Text(
                                            farmerData
                                                    .feedDetails![
                                                        selectedCurrentFeed]
                                                    .currentFeedAvailable
                                                    .toString() +
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
                                          Border.all(color: Color(0xff9E9E9E)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6.w, vertical: 9.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Reordering Date - ",
                                            style: GoogleFonts.poppins(
                                                fontSize: 12.sp,
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            Utils.convertISOToFormattedDate(
                                                farmerData
                                                    .feedDetails![
                                                        selectedCurrentFeed]
                                                    .reorderingDate!),
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

                    Text(
                      "Name",
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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
                              color: Color(0xFF707070).withOpacity(0),
                              width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                              color: Color(0xFF707070).withOpacity(0),
                              width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                              color: Color(0xFF707070).withOpacity(0),
                              width: 1),
                        ),
                        hintStyle: TextStyle(
                            color: const Color(0xFF4D4D4D),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                            fontSize: 16.sp),
                        hintText: farmerData.farmerDetails!.userName,
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
                              color: Color(0xFF707070).withOpacity(0),
                              width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                              color: Color(0xFF707070).withOpacity(0),
                              width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                              color: Color(0xFF707070).withOpacity(0),
                              width: 1),
                        ),
                        hintStyle: TextStyle(
                            color: const Color(0xFF4D4D4D),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                            fontSize: 16.sp),
                        hintText: farmerData.farmerDetails!.phoneNumber,
                      ),
                    ),
                    sizedBoxHeight(17.h),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: farmerData.farmDetails!.length,
                        itemBuilder: (context, index) {
                          return Container(
                              child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Farm Address ${index + 1}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ],
                              ),
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
                                        color: Color(0xFF707070).withOpacity(0),
                                        width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: BorderSide(
                                        color: Color(0xFF707070).withOpacity(0),
                                        width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: BorderSide(
                                        color: Color(0xFF707070).withOpacity(0),
                                        width: 1),
                                  ),
                                  hintStyle: TextStyle(
                                      color: const Color(0xFF4D4D4D),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Poppins",
                                      fontSize: 16.sp),
                                  hintText: farmerData.farmDetails!
                                      .elementAt(index)
                                      .farmAddress,
                                ),
                              ),
                              sizedBoxHeight(17.h),
                            ],
                          ));
                        }),
                  ],
                );
              },
            ),
          ),
        ),
      ),
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
          child: Image.network("${ApiUrls.baseImageUrl}/$imagePath"),
        ),
      ),
    );
  }
}
