import 'package:farm_flow_sales/Common/CommonTextFormField.dart';
import 'package:farm_flow_sales/Common/custom_button_curve.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Discount extends StatefulWidget {
  const Discount({super.key});

  @override
  State<Discount> createState() => _DiscountState();
}

class _DiscountState extends State<Discount> {
  bool _iscurrency = false;
  bool _isdiscount = false;
  TextEditingController discountcurrency = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 44.h),
            child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/images/discountimage.svg"),
                  sizedBoxHeight(28.h),
                  Text(
                    "Discount",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  sizedBoxHeight(9.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isdiscount = true;
                            _iscurrency = false;
                          });
                        },
                        child: Container(
                          width: 179.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.buttoncolour),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            // borderRadius: BorderRadius.circular(10),
                            color: _isdiscount
                                ? AppColors.buttoncolour
                                : AppColors.white,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              "assets/images/percentage-svgrepo-com.svg",
                              color: _isdiscount
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _iscurrency = true;
                            _isdiscount = false;
                          });
                        },
                        child: Container(
                          width: 179.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              // borderRadius: BorderRadius.circular(10),
                              color: _iscurrency
                                  ? AppColors.buttoncolour
                                  : AppColors.white,
                              border:
                                  Border.all(color: AppColors.buttoncolour)),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "€",
                                style: GoogleFonts.poppins(
                                    fontSize: 28.sp,
                                    color: _iscurrency
                                        ? AppColors.white
                                        : AppColors.black,
                                    fontWeight: FontWeight.w500),
                              )),
                        ),
                      ),
                    ],
                  ),
                  sizedBoxHeight(21.h),
                  Text(
                    "Enter Value",
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Color(0xff4D4D4D),
                        fontWeight: FontWeight.w400),
                  ),
                  sizedBoxHeight(7.h),
                  CustomTextFormField(
                      hintText: "Enter value",
                      texttype: TextInputType.phone,
                      textEditingController: discountcurrency,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a value";
                        }
                        // else if (!RegExp(
                        //         r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                        //     .hasMatch(value)) {
                        //   return "Please enter a valid value";
                        // }
                        return null;
                      },
                      validatorText: "Enter your value"),
                  sizedBoxHeight(23.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total MRP",
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff4D4D4D)),
                      ),
                      Text(
                        "€ 500",
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff4D4D4D)),
                      ),
                    ],
                  ),
                  sizedBoxHeight(15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Discount on MRP",
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff4D4D4D)),
                      ),
                      Text(
                        "- 10%",
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff4D4D4D)),
                      ),
                    ],
                  ),
                  sizedBoxHeight(3.h),
                  Divider(
                    thickness: 1,
                    color: AppColors.buttoncolour,
                  ),
                  sizedBoxHeight(3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Amount",
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff4D4D4D)),
                      ),
                      Text(
                        "€ 450",
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.buttoncolour),
                      ),
                    ],
                  ),
                  sizedBoxHeight(179.h),
                  customButtonCurve(
                      text: "Proceed",
                      onTap: () {
                        if (_form.currentState!.validate()) {
                          Get.toNamed("/placeordermain");
                        }
                      })
                ],
              ),
            ),
          ),
        ));
  }
}
