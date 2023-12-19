import 'package:farm_flow_sales/Common/custom_appbar.dart';
import 'package:farm_flow_sales/Utils/api_urls.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/view_models/farmer/FarmerListAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Model/farmerListModel.dart';

class Farmer extends StatefulWidget {
  const Farmer({super.key});

  @override
  State<Farmer> createState() => _FarmerState();
}

class _FarmerState extends State<Farmer> {
  RxBool isLoading = true.obs;
  FarmerListModel farmerData = FarmerListModel();
  @override
  void initState() {
    FarmerListAPI().farmerApi().then((value) {
      farmerData = value;
      isLoading.value = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: customAppBar(text: "Farmers"),
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
          child: SingleChildScrollView(
              child: Obx(() => isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: AppColors.buttoncolour,
                    ))
                  : farmerData.data!.farmers!.isEmpty
                      ? Center(child: Text('No farmer available'))
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            return sizedBoxHeight(13.h);
                          },
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: farmerData.data!.farmers!.length,
                          itemBuilder: (context, index) {
                            String? Imagepath =
                                farmerData.data!.farmers![index].profilePhoto;
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed("/farmerdetails", arguments: {
                                      "id": farmerData.data!.farmers![index].id
                                          .toString()
                                    });
                                  },
                                  child: SizedBox(
                                    width: 358.w,
                                    child: Card(
                                      elevation: 2,
                                      // shadowColor: Color(0XFF00000029),
                                      color: const Color(0xffF1F1F1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          sizedBoxHeight(11.h),
                                          Row(
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.w),
                                                  child: Imagepath == null
                                                      ? CircleAvatar(
                                                          radius: 30.r,
                                                          foregroundImage:
                                                              const NetworkImage(
                                                            ("https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-pictur+e-973460_960_720.png"),
                                                          ),
                                                        )
                                                      : CircleAvatar(
                                                          radius: 30.r,
                                                          foregroundImage:
                                                              NetworkImage(
                                                            "${ApiUrls.baseImageUrl}/$Imagepath",
                                                            // width: 77.w,
                                                            // height: 77.h,
                                                          ),
                                                        )),
                                              sizedBoxWidth(9.w),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    // overflow: TextOverflow.ellipsis,
                                                    text: TextSpan(
                                                      text: farmerData
                                                          .data!
                                                          .farmers![index]
                                                          .userName,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 18.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 3.h),
                                                        child: SvgPicture.asset(
                                                          "assets/images/call.svg",
                                                          width: 11.w,
                                                          height: 15.w,
                                                        ),
                                                      ),
                                                      sizedBoxWidth(7.w),
                                                      RichText(
                                                        text: TextSpan(
                                                            text: farmerData
                                                                .data!
                                                                .farmers![index]
                                                                .phoneNumber,
                                                            style: GoogleFonts.poppins(
                                                                fontSize: 14.sp,
                                                                color: const Color(
                                                                    0xff4D4D4D),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 15.w,
                                                    top: 15.h,
                                                    bottom: 15.h),
                                                child: Image.asset(
                                                  "assets/images/text.png",
                                                  width: 39.w,
                                                  height: 39.w,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 11.h,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ))),
        ),
      ),
    );
  }
}
