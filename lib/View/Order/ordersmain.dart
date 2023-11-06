import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/View/Order/ongoiningorderdata.dart';
import 'package:farm_flow_sales/View/Order/salesordermaindata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

enum SingingCharacter {
  Today,
  Week,
  Month,
  Threemonth,
  Year,
}

class OrderMain extends StatefulWidget {
  const OrderMain({super.key});

  @override
  State<OrderMain> createState() => _OrderMainState();
}

class _OrderMainState extends State<OrderMain> {
  SingingCharacter? _character = SingingCharacter.Today;
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
                  Text(
                    "Orders",
                    style: TextStyle(
                      color: const Color(0XFF141414),
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            sizedBoxHeight(13.h),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 9, 16, 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Ongoing Orders",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500, fontSize: 18.sp),
                          ),
                        ],
                      ),
                      sizedBoxHeight(10),
                      Container(
                        height: 370.h,
                        width: 360.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F1F1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(23, 5, 23, 0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: salesOrderMainData.length,
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(
                                      salesOrderMainData[index]["route"]);
                                },
                                child: SalesOrderMainTile(
                                    salesOrderMainData[index]["image"],
                                    salesOrderMainData[index]["name"],
                                    salesOrderMainData[index]["number"],
                                    salesOrderMainData[index]["location"]),
                              );
                            },
                          ),
                        ),
                      ),
                      sizedBoxHeight(25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Completed Orders",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500, fontSize: 18.sp),
                          ),
                          const Spacer(),
                          PopupMenuButton(
                            offset: const Offset(0, 50),
                            color: const Color(0xFFFFFFFF),
                            tooltip: '',
                            icon: const Icon(
                              Icons.filter_alt_outlined,
                              color: Colors.black,
                            ),
                            onSelected: (value) {
                              setState(() {
                                _character = value;
                              });
                              Get.back();
                            },
                            itemBuilder: (BuildContext bc) {
                              return [
                                PopupMenuItem(
                                  child: RadioListTile<SingingCharacter>(
                                    title: const Text('Today'),
                                    value: SingingCharacter.Today,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter? value) {
                                      setState(() {
                                        _character = value;
                                      });
                                      Get.back();
                                    },
                                  ),
                                ),
                                PopupMenuItem(
                                  child: RadioListTile<SingingCharacter>(
                                    title: const Text('Last Week'),
                                    value: SingingCharacter.Week,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter? value) {
                                      setState(() {
                                        _character = value;
                                      });
                                      Get.back();
                                    },
                                  ),
                                ),
                                PopupMenuItem(
                                  child: RadioListTile<SingingCharacter>(
                                    title: const Text('Last Month'),
                                    value: SingingCharacter.Month,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter? value) {
                                      setState(() {
                                        _character = value;
                                      });
                                      Get.back();
                                    },
                                  ),
                                ),
                                PopupMenuItem(
                                  child: RadioListTile<SingingCharacter>(
                                    title: const Text('Last 3 Month'),
                                    value: SingingCharacter.Threemonth,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter? value) {
                                      setState(() {
                                        _character = value;
                                      });
                                      Get.back();
                                    },
                                  ),
                                ),
                                PopupMenuItem(
                                  child: RadioListTile<SingingCharacter>(
                                    title: const Text('Last Year'),
                                    value: SingingCharacter.Year,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter? value) {
                                      setState(() {
                                        _character = value;
                                      });
                                      Get.back();
                                    },
                                  ),
                                ),
                              ];
                            },
                          ),
                        ],
                      ),
                      sizedBoxHeight(10),
                      Container(
                        height: 370.h,
                        width: 360.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F1F1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(23, 5, 23, 0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: ongoingOrderMainData.length,
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(
                                      ongoingOrderMainData[index]["route"]);
                                },
                                child: OngoingOrderMainTile(
                                    ongoingOrderMainData[index]["image"],
                                    ongoingOrderMainData[index]["name"],
                                    ongoingOrderMainData[index]["number"],
                                    ongoingOrderMainData[index]["location"]),
                              );
                            },
                          ),
                        ),
                      ),
                      sizedBoxHeight(40.h)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget SalesOrderMainTile(
    dynamic image, dynamic name, dynamic number, dynamic location) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Color(0xFFFFFFFF),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 11.h,
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60), //<-- SEE HERE
                  ),
                  child: Image.asset(image),
                ),
              ),
              sizedBoxWidth(8.w),
              SizedBox(
                width: 165.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: name,
                        // "Roma dsouza",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/call.svg",
                          width: 13.w,
                          height: 13.w,
                        ),
                        sizedBoxWidth(5.w),
                        RichText(
                          text: TextSpan(
                            text: number,
                            // "0225845855",
                            style: TextStyle(
                              color: const Color(0XFF585858),
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        Container()
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 3.h),
                          child: SvgPicture.asset(
                            "assets/images/locationconnect.svg",
                            width: 13.w,
                            height: 13.w,
                          ),
                        ),
                        sizedBoxWidth(5.w),
                        RichText(
                          text: TextSpan(
                            text: location,
                            // "Canada",
                            style: TextStyle(
                              color: const Color(0XFF585858),
                              fontSize: 16.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
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

Widget OngoingOrderMainTile(
    dynamic image, dynamic name, dynamic number, dynamic location) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: Container(
      //width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: Color(0xFFFFFFFF),
        // color: AppColors.greyMed
      ),
      child: Column(
        children: [
          SizedBox(
            height: 11.h,
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60), //<-- SEE HERE
                  ),
                  child: Image.asset(image),
                ),
              ),
              sizedBoxWidth(8.w),
              SizedBox(
                // width: 195.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: name,
                        // "Roma dsouza",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/call.svg",
                          width: 13.w,
                          height: 13.w,
                        ),
                        sizedBoxWidth(5.w),
                        RichText(
                          text: TextSpan(
                            text: number,
                            // "0225845855",
                            style: TextStyle(
                              color: const Color(0XFF585858),
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        Container()
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 3.h),
                          child: SvgPicture.asset(
                            "assets/images/locationconnect.svg",
                            width: 13.w,
                            height: 13.w,
                          ),
                        ),
                        sizedBoxWidth(5.w),
                        RichText(
                          text: TextSpan(
                            text: location,
                            // "Canada",
                            style: TextStyle(
                              color: const Color(0XFF585858),
                              fontSize: 16.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
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
