import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Faqscontent extends StatefulWidget {
  const Faqscontent({super.key});

  @override
  State<Faqscontent> createState() => _FaqscontentState();
}

class _FaqscontentState extends State<Faqscontent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  sizedBoxHeight(26.h),
                  FaqExpanded(isExpanded2: true),
                  sizedBoxHeight(23.h),
                  FaqExpanded(isExpanded2: false),
                  sizedBoxHeight(23.h),
                  FaqExpanded(isExpanded2: false),
                  sizedBoxHeight(23.h),
                  FaqExpanded(
                    isExpanded2: false,
                  ),
                  sizedBoxHeight(23.h),
                  FaqExpanded(isExpanded2: false),
                  sizedBoxHeight(23.h),
                  FaqExpanded(isExpanded2: false),
                  sizedBoxHeight(23.h),
                  FaqExpanded(
                    isExpanded2: false,
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

class FaqExpanded extends StatefulWidget {
  bool isExpanded2;

  FaqExpanded({super.key, required this.isExpanded2});

  @override
  State<FaqExpanded> createState() => _FaqExpandedState();
}

class _FaqExpandedState extends State<FaqExpanded> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: 358.w,
        // height: 70.h,
        decoration: BoxDecoration(
          color: AppColors.greyF1F1F1,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: ExpansionTile(
          childrenPadding:
              EdgeInsets.only(left: 0.w, right: 0.w, bottom: 8.h, top: 10.h),
          initiallyExpanded: widget.isExpanded2,
          onExpansionChanged: (bool expanding) {
            setState(() {
              widget.isExpanded2 = expanding;
            });
          },
          trailing: Image.asset(
            widget.isExpanded2
                ? "assets/images/faqsminus.png"
                : "assets/images/faqsplus.png",
            width: 30.w,
            height: 30.h,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What Is Feed Flow?',
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(0xFF141414),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          children: <Widget>[
            Container(
              width: 370.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: AppColors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Color(0xFF4D4D4D),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
