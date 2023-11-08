import 'package:farm_flow_sales/Common/getx_controller.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Faqscontent extends StatefulWidget {
  const Faqscontent({super.key});

  @override
  State<Faqscontent> createState() => _FaqscontentState();
}

class _FaqscontentState extends State<Faqscontent> {
  CommonGetXController commonGetXController = Get.put(CommonGetXController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(
            top: 20.h,
          ),
          child: Text(
            "FAQ's",
            style: TextStyle(
              color: const Color(0XFF141414),
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.only(
            top: 20.h,
            left: 16.w,
          ),
          child: GestureDetector(
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
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            sizedBoxHeight(26.h),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: commonGetXController.faqModel.data!.length,
                itemBuilder: (ctx, index) {
                  return Container(
                      margin: EdgeInsets.only(bottom: 23.h),
                      child: FaqExpanded(
                        isExpanded2: index == 0 ? true : false,
                        title: commonGetXController
                            .faqModel.data![index].question!,
                        desc:
                            commonGetXController.faqModel.data![index].answer!,
                      ));
                })
          ],
        ),
      ),
    );
  }
}

class FaqExpanded extends StatefulWidget {
  bool isExpanded2;
  String title;
  String desc;

  FaqExpanded({
    super.key,
    required this.isExpanded2,
    required this.title,
    required this.desc,
  });

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
              SizedBox(
                width: 275.w,
                child: Text(
                  widget.title,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xFF141414),
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          children: <Widget>[
            Container(
              width: 370.w,
              height: 30.h,
              decoration: const BoxDecoration(
                color: AppColors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 15.h),
              child: Text(
                widget.desc,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xFF4D4D4D),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
