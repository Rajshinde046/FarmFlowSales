import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_flow_sales/Common/custom_appbar.dart';
import 'package:farm_flow_sales/Utils/api_urls.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/Utils/utils.dart';
import 'package:farm_flow_sales/view_models/farmer/FarmerdetailsAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Model/farmerDetailsModel.dart';

class Farmerdetails extends StatefulWidget {
  const Farmerdetails({super.key});

  @override
  State<Farmerdetails> createState() => _FarmerdetailsState();
}

class _FarmerdetailsState extends State<Farmerdetails> {
  String id = Get.arguments["id"];
  RxInt selectedCurrentFeed = 0.obs;

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
                  return const Center(
                      child: CircularProgressIndicator(
                    color: AppColors.buttoncolour,
                  ));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data?.data == null) {
                  return const Center(child: Text('No farmer available'));
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
                          : CachedNetworkImage(
                              memCacheHeight: 88,
                              maxHeightDiskCache: 88,
                              maxWidthDiskCache: 88,
                              memCacheWidth: 88,
                              imageUrl:
                                  "${ApiUrls.baseImageUrl}/${farmerData.farmerDetails!.profilePhoto}",
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(
                                color: AppColors.buttoncolour,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
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
                              SizedBox(
                                width: Get.width / 0.8,
                                height: 30,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: farmerData
                                      .farmerDetails!.feedDetails!.length,
                                  itemBuilder: (ctx, index) => Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: currentFeedSelection(
                                        imagePath: farmerData
                                            .farmerDetails!.feedDetails!
                                            .elementAt(index)
                                            .livestockUri!,
                                        index: index),
                                  ),
                                ),
                              ),
                              sizedBoxHeight(22.h),
                              Obx(
                                () => Row(
                                  children: [
                                    Container(
                                      width: 109.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: const Color(0xff9E9E9E)),
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
                                                  .farmerDetails!
                                                  .feedDetails![
                                                      selectedCurrentFeed.value]
                                                  .livestockName!,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 11.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.black),
                                            ),
                                            Text(
                                              "${farmerData.farmerDetails!.feedDetails![selectedCurrentFeed.value].currentFeedAvailable} Kg",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 11.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    sizedBoxWidth(7.h),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: const Color(0xff9E9E9E)),
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
                                                  fontSize: 11.sp,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              Utils.convertISOToFormattedDate(
                                                  farmerData
                                                      .farmerDetails!
                                                      .feedDetails![
                                                          selectedCurrentFeed
                                                              .value]
                                                      .reorderingDate!),
                                              style: GoogleFonts.poppins(
                                                  fontSize: 11.sp,
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
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
                        hintText: farmerData.farmerDetails!.phoneNumber,
                      ),
                    ),
                    sizedBoxHeight(17.h),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            farmerData.farmerDetails!.farmDetails!.length,
                        itemBuilder: (context, index) {
                          return Column(
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
                                maxLines: 3,
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(fontSize: 16.sp),
                                  contentPadding: EdgeInsets.all(17.h),
                                  filled: true,
                                  fillColor: const Color(0xFFF1F1F1),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: BorderSide(
                                        color: const Color(0xFF707070)
                                            .withOpacity(0),
                                        width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: BorderSide(
                                        color: const Color(0xFF707070)
                                            .withOpacity(0),
                                        width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: BorderSide(
                                        color: const Color(0xFF707070)
                                            .withOpacity(0),
                                        width: 1),
                                  ),
                                  hintStyle: TextStyle(
                                      color: const Color(0xFF4D4D4D),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Poppins",
                                      fontSize: 16.sp),
                                  hintText: farmerData
                                      .farmerDetails!.farmDetails!
                                      .elementAt(index)
                                      .farmAddress,
                                ),
                              ),
                              sizedBoxHeight(17.h),
                            ],
                          );
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
    return Obx(
      () => InkWell(
        onTap: () {
          selectedCurrentFeed.value = index;
        },
        child: Container(
          width: 40.w,
          height: 30.h,
          decoration: BoxDecoration(
              // dec
              color: selectedCurrentFeed.value == index
                  ? const Color.fromARGB(255, 236, 248, 239)
                  : AppColors.white,
              borderRadius: BorderRadius.circular(5.h),
              border: Border.all(
                  color: selectedCurrentFeed.value == index
                      ? AppColors.buttoncolour
                      : AppColors.grey4D4D4D)),
          child: Padding(
            padding: EdgeInsets.all(4.h),
            child: CachedNetworkImage(
              imageUrl: "${ApiUrls.baseImageUrl}/$imagePath",
              placeholder: (context, url) => const CircularProgressIndicator(
                color: AppColors.buttoncolour,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
