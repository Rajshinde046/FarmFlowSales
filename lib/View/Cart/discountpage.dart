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
    investAmountPopUp() {
      final tecOneTime = TextEditingController();
      final tecMonthly = TextEditingController();
      final controllerMySub = Get.put(MySubController());
      controllerMySub.changeInvestmentAmount("0");
      // controllerMySub.investmentAmount = 0;

      // bool readonlyOneTime = false;
      // bool readonlyMonthly = false;

      // int investmentAmount = 0;

      double baseWidth = 360;
      double fem = MediaQuery.of(context).size.width / baseWidth;
      double ffem = fem * 0.97;
      return showDialog(
        context: context,
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlertDialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
              backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
              // contentPadding: EdgeInsets.fromLTRB(30.w, 14.h, 24.w, 30.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(
                    color: Get.isDarkMode ? Colors.grey : Colors.white),
              ),
              // contentPadding:
              //     EdgeInsets.all(
              //         10),
              //   title: ,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 30.h,
                      ),
                      // sized
                      // Container(
                      //   // pleaseentertheinvestmentamount (18:70)
                      //   margin: EdgeInsets.fromLTRB(
                      //       0 * fem, 4 * fem, 30 * fem, 0 * fem),
                      //   constraints: BoxConstraints(
                      //     maxWidth: 195 * fem,
                      //   ),
                      // child:
                      Expanded(
                        child: Text('PLEASE ENTER THE INVESTMENT  AMOUNT',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 18 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.2575 * ffem / fem,
                              color: Color(0xff151515),
                            )),
                      ),

                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          // Get.back();
                        },
                        child: Icon(
                          Icons.cancel_outlined,
                          size: 30.h,
                          color: Color(0XFF000000),
                        ),
                      )
                    ],
                  ),
                  sizedBoxHeight(20.h),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: GetBuilder<MySubController>(builder: (_) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('One-Time',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      // height: 1.2575 * ffem / fem,
                                      color: Color(0xff151515),
                                    )
                                    // SafeGoogleFont(
                                    //   'Product Sans',

                                    // ),
                                    ),
                                inputField(
                                  controller: tecOneTime,
                                  onChanged: (p0) {
                                    tecMonthly.clear();
                                    controllerMySub.changeInvestmentAmount(
                                        tecOneTime.text);
                                  },
                                  // readOnly: readonlyOneTime
                                )
                              ],
                            ),
                            sizedBoxHeight(10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Monthly',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      // height: 1.2575 * ffem / fem,
                                      color: Color(0xff151515),
                                    )
                                    // SafeGoogleFont(
                                    //   'Product Sans',
                                    //   fontSize: 18.sp,
                                    //   fontWeight: FontWeight.w700,
                                    //   // height: 1.2575 * ffem / fem,
                                    //   color: Color(0xff151515),
                                    // ),
                                    ),
                                inputField(
                                  controller: tecMonthly,
                                  onChanged: (p0) {
                                    tecOneTime.clear();
                                    controllerMySub
                                        .changeInvestmentAmountMonthly(
                                            tecMonthly.text);
                                  },
                                  // readOnly: readonlyMonthly
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: GoogleFonts.poppins(
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5 * ffem / fem,
                                  color: Color(0xff151515),
                                ),
                                // SafeGoogleFont(
                                //   'Product Sans',
                                //   fontSize: 16 * ffem,
                                //   fontWeight: FontWeight.w400,
                                //   height: 1.5 * ffem / fem,
                                //   color: Color(0xff151515),
                                // ),
                                children: [
                                  TextSpan(
                                      text: 'Investment Amount Per Year \n',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5 * ffem / fem,
                                        color: Color(0xff151515),
                                      )
                                      // SafeGoogleFont(
                                      //   'Product Sans',
                                      //   fontSize: 16 * ffem,
                                      //   fontWeight: FontWeight.w400,
                                      //   height: 1.5 * ffem / fem,
                                      //   color: Color(0xff151515),
                                      // ),
                                      ),
                                  TextSpan(
                                      text: controllerMySub.investmentAmount
                                          .toString(),
                                      // text: '12*  = 1,20,000',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16 * ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.5 * ffem / fem,
                                        color: Color(0xff151515),
                                      )
                                      // SafeGoogleFont(
                                      //   'Product Sans',
                                      //   fontSize: 16 * ffem,
                                      //   fontWeight: FontWeight.w700,
                                      //   height: 1.5 * ffem / fem,
                                      //   color: Color(0xff151515),
                                      // ),
                                      ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Investment',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    // height: 1.1000000238 * ffem / fem,
                                    color: Colors.black,
                                  ),
                                  // SafeGoogleFont(
                                  //   'Product Sans',
                                  //   fontSize: 16.sp,
                                  //   fontWeight: FontWeight.w400,
                                  //   // height: 1.1000000238 * ffem / fem,
                                  //   color: Colors.black,
                                  // ),
                                ),
                                Text(
                                    // j8P (18:55)
                                    controllerMySub.intInvestMentAmount
                                        .toString(),
                                    // '₹ 2,00,000/-',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      // height: 1.1000000238 * ffem / fem,
                                      color: Colors.black,
                                    )
                                    // SafeGoogleFont(
                                    //   'Product Sans',
                                    //   fontSize: 16.sp,
                                    //   fontWeight: FontWeight.w400,
                                    //   // height: 1.1000000238 * ffem / fem,
                                    //   color: Colors.black,
                                    // ),
                                    ),
                              ],
                            ),
                            Divider(
                              thickness: 1.h,
                              color: Colors.black,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Fees (${controllerMySub.feePercent}%)',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      // height: 1.1000000238 * ffem / fem,
                                      color: Colors.grey,
                                    )
                                    //  SafeGoogleFont(
                                    //   'Product Sans',
                                    //   fontSize: 16.sp,
                                    //   fontWeight: FontWeight.w400,
                                    //   // height: 1.1000000238 * ffem / fem,
                                    //   color: Colors.grey,
                                    // ),
                                    ),
                                Text(
                                    // j8P (18:55)
                                    // '₹ 3,000/-',
                                    controllerMySub.fee!.toStringAsFixed(2),
                                    // ((controllerMySub.intInvestMentAmount!/100)*2).toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      // height: 1.1000000238 * ffem / fem,
                                      color: Colors.black,
                                    )
                                    // SafeGoogleFont(
                                    //   'Product Sans',
                                    //   fontSize: 16.sp,
                                    //   fontWeight: FontWeight.w400,
                                    //   // height: 1.1000000238 * ffem / fem,
                                    //   color: Colors.black,
                                    // ),
                                    ),
                              ],
                            ),
                            sizedBoxHeight(10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Discount (0.5%)',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      // height: 1.1000000238 * ffem / fem,
                                      color: Colors.grey,
                                    )
                                    // SafeGoogleFont(
                                    //   'Product Sans',
                                    //   fontSize: 16.sp,
                                    //   fontWeight: FontWeight.w400,
                                    //   // height: 1.1000000238 * ffem / fem,
                                    //   color: Colors.grey,
                                    // ),
                                    ),
                                Text(
                                    controllerMySub.discount!
                                        .toStringAsFixed(2),
                                    // j8P (18:55)
                                    // '-₹ 1,000/-',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      // height: 1.1000000238 * ffem / fem,
                                      color: Colors.red,
                                    )
                                    // SafeGoogleFont(
                                    //   'Product Sans',
                                    //   fontSize: 16.sp,
                                    //   fontWeight: FontWeight.w400,
                                    //   // height: 1.1000000238 * ffem / fem,
                                    //   color: Colors.red,
                                    // ),
                                    ),
                              ],
                            ),
                            Divider(
                              thickness: 1.h,
                              color: Colors.black,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Payable',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      // height: 1.1000000238 * ffem / fem,
                                      color: Colors.grey,
                                    )
                                    // SafeGoogleFont(
                                    //   'Product Sans',
                                    //   fontSize: 16.sp,
                                    //   fontWeight: FontWeight.w400,
                                    //   // height: 1.1000000238 * ffem / fem,
                                    //   color: Colors.grey,
                                    // ),
                                    ),
                                Text(
                                    controllerMySub.totalPayable!
                                        .toStringAsFixed(2),
                                    // j8P (18:55)
                                    // 'Total Payable',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      // height: 1.1000000238 * ffem / fem,
                                      color: Colors.black,
                                    )
                                    // SafeGoogleFont(
                                    //   'Product Sans',
                                    //   fontSize: 16.sp,
                                    //   fontWeight: FontWeight.w400,
                                    //   // height: 1.1000000238 * ffem / fem,
                                    //   color: Colors.black,
                                    // ),
                                    ),
                              ],
                            ),
                          ],
                        );
                      })),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    // frame48096305eEf (18:71)
                    margin: EdgeInsets.fromLTRB(
                        55.5 * fem, 0 * fem, 75.5 * fem, 0 * fem),
                    width: double.infinity,
                    height: 47 * fem,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.h),
                      gradient: LinearGradient(
                        begin: Alignment(-1.138, 0),
                        end: Alignment(1.122, 0),
                        colors: <Color>[Color(0xfff98100), Color(0xfffe6c73)],
                        stops: <double>[0, 1],
                      ),
                    ),
                    child: Center(
                      child: Text('PAY NOW',
                          style: GoogleFonts.poppins(
                            fontSize: 16 * ffem,
                            fontWeight: FontWeight.w700,
                            height: 1.2575 * ffem / fem,
                            color: Color(0xffffffff),
                          )
                          // SafeGoogleFont(
                          //   'Product Sans',
                          //   fontSize: 16 * ffem,
                          //   fontWeight: FontWeight.w700,
                          //   height: 1.2575 * ffem / fem,
                          //   color: Color(0xffffffff),
                          // ),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

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
                  SvgPicture.asset(
                    "assets/images/discountimage.svg",
                    width: 360.w,
                  ),
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
                          //  investAmountPopUp();
                        }
                      })
                ],
              ),
            ),
          ),
        ));
  }
}

class MySubController extends GetxController {
  String? _investmentAmount = "0";

  String? get investmentAmount => _investmentAmount;

  int? _intInvestMentAmount = 0;
  int? get intInvestMentAmount => _intInvestMentAmount;

  double? _fee = 0;
  double? get fee => _fee;

  double? _discount = 0;
  double? get discount => _discount;

  double? _totalPayable = 0;
  double? get totalPayable => _totalPayable;

  double? _feePercent = 0;
  double? get feePercent => _feePercent;

  changeInvestmentAmount(String value) {
    _intInvestMentAmount = int.tryParse(value) ?? 0;
    _investmentAmount = _intInvestMentAmount.toString();
    if (_intInvestMentAmount! < 1000000) {
      _feePercent = 1.50;
      _fee = ((_intInvestMentAmount! / 100) * _feePercent!);
    } else if (_intInvestMentAmount! >= 1000000 &&
        _intInvestMentAmount! < 2500000) {
      _feePercent = 1.25;
      _fee = ((_intInvestMentAmount! / 100) * _feePercent!);
    } else if (_intInvestMentAmount! >= 2500000 &&
        _intInvestMentAmount! < 5000000) {
      _feePercent = 1;
      _fee = ((_intInvestMentAmount! / 100) * _feePercent!);
    } else {
      _feePercent = 0.75;
      _fee = ((_intInvestMentAmount! / 100) * _feePercent!);
    }

    _discount = ((_intInvestMentAmount! / 100) * 0.5);

    _totalPayable = (_fee! - _discount!);
    // _fee = _intInvestMentAmount/100);
    update();
  }

  changeInvestmentAmountMonthly(String value) {
    print(value);
    int monthly = int.tryParse(value) ?? 0;
    // print(monthly);
    _intInvestMentAmount = monthly * 12;
    _investmentAmount = "12*${monthly.toString()} = ${monthly * 12}";

    if (_intInvestMentAmount! < 1000000) {
      _feePercent = 1.50;
      _fee = ((_intInvestMentAmount! / 100) * _feePercent!);
      // _fee = int.parse(((_intInvestMentAmount!/100)*_feePercent!));
      //((_intInvestMentAmount!/100)*_feePercent!);
    } else if (_intInvestMentAmount! >= 1000000 &&
        _intInvestMentAmount! < 2500000) {
      _feePercent = 1.25;
      _fee = ((_intInvestMentAmount! / 100) * _feePercent!);
    } else if (_intInvestMentAmount! >= 2500000 &&
        _intInvestMentAmount! < 5000000) {
      _feePercent = 1;
      _fee = ((_intInvestMentAmount! / 100) * _feePercent!);
    } else {
      _feePercent = 0.75;
      _fee = ((_intInvestMentAmount! / 100) * _feePercent!);
    }

    _discount = ((_intInvestMentAmount! / 100) * 0.5);

    _totalPayable = (_fee! - _discount!);

    update();
  }
}

SizedBox inputField({
  void Function(String)? onChanged,
  TextEditingController? controller,
  // bool? readOnly
}) {
  return SizedBox(
      height: 40.h,
      width: 150.w,
      child: TextField(
          // readOnly: readOnly!,
          controller: controller,
          onChanged: onChanged,
          keyboardType: TextInputType.phone,
          inputFormatters: <TextInputFormatter>[
            // for below version 2 use this
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            // for version 2 and greater youcan also use this
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xfff4f4f4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.h),
              borderSide: BorderSide(color: Color(0xfff4f4f4), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.h),
              borderSide: BorderSide(color: Color(0xfff4f4f4), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.h),
              borderSide: BorderSide(color: Color(0xfff4f4f4), width: 1),
            ),
          )));
}
