import 'package:farm_flow_sales/Common/custom_appbar.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/View/Warehouse/warehousedata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Warehouse extends StatefulWidget {
  const Warehouse({super.key});

  @override
  State<Warehouse> createState() => _WarehouseState();
}

class _WarehouseState extends State<Warehouse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: customAppBar(text: "Warehouse"),
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
                  itemCount: warehousedata.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.toNamed("/products");
                          },
                          child: warehousecard(
                            warehousedata[index]["image"],
                            warehousedata[index]["tittle"],
                            warehousedata[index]["location"],
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
      dynamic image, dynamic tittle, dynamic location, int index) {
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
                  padding: EdgeInsets.only(left: 21.w),
                  child: Image.asset(
                    image,
                    width: 47.w,
                    height: 47.h,
                  ),
                ),
                sizedBoxWidth(24.w),
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
                            "assets/images/locationconnect.svg",
                            width: 11.w,
                            height: 15.w,
                          ),
                        ),
                        sizedBoxWidth(7.w),
                        RichText(
                          text: TextSpan(
                              text: location,
                              style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  color: Color(0xff4D4D4D),
                                  fontWeight: FontWeight.w400)),
                        )
                      ],
                    ),
                  ],
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
