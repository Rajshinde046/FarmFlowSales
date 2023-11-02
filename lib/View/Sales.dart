import 'package:farm_flow_sales/Common/custom_appbar.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/View/SalesData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Sales extends StatefulWidget {
  const Sales({super.key});

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customAppBar(text: "Sales"),
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 20),
        child: Column(
          children: [
            Container(
              height: 125.h,
              width: 358.w,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 6.0, // soften the shadow
                      spreadRadius: 1.0, //extend the shadow
                      offset: Offset(
                        -1.0, // Move to right 5  horizontally
                        1.0, // Move to bottom 5 Vertically
                      ),
                    )
                  ],
                  color: const Color(0xFFE3FFE9),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Target",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Current",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Required",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "€ 5000",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "€ 1000",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "€ 4000",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            sizedBoxHeight(40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Probable Orders",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            sizedBoxHeight(5.h),
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
                  itemCount: salesMainData.length,
                  itemBuilder: (_, index) {
                    return SalesMainTile(
                        salesMainData[index]["image"],
                        salesMainData[index]["name"],
                        salesMainData[index]["number"],
                        salesMainData[index]["location"]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget SalesMainTile(
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
