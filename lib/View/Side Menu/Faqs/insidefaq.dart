import 'package:expansion_tile_group/expansion_tile_group.dart';
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
  int selectedTile = 0;
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
      body: commonGetXController.faqModel.data!.faqs!.isEmpty
          ? Center(
              child: Text(
                "No Data Available !",
                style: TextStyle(
                    fontSize: 20.sp,
                    color: const Color(0xFF141414),
                    fontWeight: FontWeight.w500),
              ),
            )
          : SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  sizedBoxHeight(26.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: ExpansionTileGroup(
                        spaceBetweenItem: 23,
                        toggleType: ToggleType.expandOnlyCurrent,
                        children: List.generate(
                            commonGetXController.faqModel.data!.faqs!.length,
                            (index) => ExpansionTileItem(
                                  isHasBottomBorder: true,
                                  isHasLeftBorder: true,
                                  isHasRightBorder: true,
                                  isHasTopBorder: true,
                                  collapsedBackgroundColor:
                                      AppColors.greyF1F1F1,
                                  borderRadius: BorderRadius.circular(10),
                                  onExpansionChanged: (bool expanding) {
                                    if (expanding) {
                                      setState(() {
                                        selectedTile = index;
                                      });
                                    } else {
                                      setState(() {
                                        selectedTile = -1;
                                      });
                                    }
                                  },
                                  backgroundColor: AppColors.greyF1F1F1,
                                  childrenPadding: EdgeInsets.only(
                                      left: 0.w,
                                      right: 0.w,
                                      bottom: 8.h,
                                      top: 10.h),
                                  initiallyExpanded: index == selectedTile,
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 275.w,
                                        child: Text(
                                          commonGetXController.faqModel.data!
                                              .faqs![index].question!,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: const Color(0xFF141414),
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Image.asset(
                                    index == selectedTile
                                        ? "assets/images/faqsminus.png"
                                        : "assets/images/faqsplus.png",
                                    width: 30.w,
                                    height: 30.h,
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 14.w, vertical: 15.h),
                                      child: Text(
                                        commonGetXController.faqModel.data!
                                            .faqs![index].answer!,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: const Color(0xFF4D4D4D),
                                        ),
                                      ),
                                    )
                                  ],
                                ))),
                  )
                ],
              ),
            ),
    );
  }
}
