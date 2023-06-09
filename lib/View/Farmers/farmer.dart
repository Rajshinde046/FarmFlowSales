import 'package:farm_flow_sales/Common/custom_appbar.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/View/Farmers/farmerdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Farmer extends StatefulWidget {
  const Farmer({super.key});

  @override
  State<Farmer> createState() => _FarmerState();
}

class _FarmerState extends State<Farmer> {
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
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  separatorBuilder: (context, index) {
                    return sizedBoxHeight(13.h);
                  },
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: farmerdata.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed("/farmerdetails");
                          },
                          child: warehousecard(
                            farmerdata[index]["image"],
                            farmerdata[index]["tittle"],
                            farmerdata[index]["number"],
                            index,
                          ),
                        )
                      ],
                    );
                  },
                ),
                sizedBoxHeight(20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget warehousecard(
      dynamic image, dynamic tittle, dynamic number, int index) {
    return SizedBox(
      width: 358.w,
      child: Card(
        elevation: 2,
        // shadowColor: Color(0XFF00000029),
        color: Color(0xffF1F1F1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            sizedBoxHeight(11.h),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Image.asset(
                    image,
                    width: 77.w,
                    height: 77.h,
                  ),
                ),
                sizedBoxWidth(9.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      // overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: tittle,
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 3.h),
                          child: SvgPicture.asset(
                            "assets/images/call.svg",
                            width: 11.w,
                            height: 15.w,
                          ),
                        ),
                        sizedBoxWidth(7.w),
                        RichText(
                          text: TextSpan(
                              text: number,
                              style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  color: Color(0xff4D4D4D),
                                  fontWeight: FontWeight.w400)),
                        )
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding:
                      EdgeInsets.only(right: 15.w, top: 15.h, bottom: 15.h),
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
    );
  }
}
