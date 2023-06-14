import 'package:farm_flow_sales/Common/custom_button_curve.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/Utils/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchItem extends StatelessWidget {
  final String title;
  final String png;
  const SearchItem({super.key, required this.title, required this.png});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: CircleAvatar(
                            radius: 20.h,
                            backgroundColor: const Color(0XFFF1F1F1),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 25.h,
                                  color: const Color(0XFF141414),
                                ),
                              ),
                            ),
                          ),
                        ),
                        sizedBoxWidth(10.w),
                        Expanded(
                            child: CupertinoSearchTextField(
                          prefixInsets:
                              EdgeInsetsDirectional.fromSTEB(15.w, 0, 0, 0),
                          prefixIcon: const Icon(
                            CupertinoIcons.search,
                            color: Colors.black,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: AppColors.buttoncolour)),
                        )),
                      ],
                    ),
                  ),
                  sizedBoxHeight(20.h),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: const Color(0XFF141414),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins"),
                  ),
                  sizedBoxHeight(5.h),
                  textGrey4D4D4D_16(
                      'lorem ipsum is simply dummy text of the printing and typesetting industry. lorem ipsum has been the industry'),
                  sizedBoxHeight(20.h),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xffF1F1F1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.asset(
                      "assets/images/$png.png",
                      height: 200.w,
                    ),
                  ),
                ],
              ),
            ),
            sizedBoxHeight(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                indicatorRow(),
                sizedBoxWidth(5.w),
                indicatorRow(indexBool: true),
                sizedBoxWidth(5.w),
                indicatorRow(),
                sizedBoxWidth(5.w),
                indicatorRow(),
                sizedBoxWidth(5.w),
                indicatorRow(),
                Icon(Icons.play_arrow_outlined,
                    color: AppColors.buttoncolour, size: 22.h)
              ],
            ),
            sizedBoxHeight(10.h),
            Divider(thickness: 1.h),
            textGreen18W5000('   € 500'),
            Divider(thickness: 1.h),
            sizedBoxHeight(10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textGrey4D4D4D_16('In Stock'),
                  sizedBoxHeight(5.h),
                  Container(
                    width: 80.w,
                    padding:
                        EdgeInsets.symmetric(vertical: 3.h, horizontal: 8.w),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.buttoncolour, width: 1.h),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        textGrey4D4D4D_14('Qty:1'),
                        Column(
                          children: [
                            RotatedBox(
                              quarterTurns: 3,
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 14.h,
                                color: AppColors.buttoncolour,
                              ),
                            ),
                            sizedBoxHeight(5.h)
                          ],
                        )
                      ],
                    ),
                  ),
                  sizedBoxHeight(30.h),
                  customButtonCurve(text: 'Add to Cart')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget indicatorRow({bool indexBool = false}) {
    return Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(
          border: Border.all(width: 1.5.h, color: AppColors.buttoncolour),
          borderRadius: BorderRadius.circular(10),
          color: indexBool ? AppColors.buttoncolour : AppColors.white),
    );
  }
}
