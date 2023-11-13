import 'package:farm_flow_sales/Common/custom_button_curve.dart';
import 'package:farm_flow_sales/Utils/base_manager.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/view_models/farmer/ConnectFarmerAPI.dart';
import 'package:farm_flow_sales/view_models/connectFarmerApi/connect_farmer_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:farm_flow_sales/common/limit_range.dart';

class Connectfarmer extends StatefulWidget {
  const Connectfarmer({super.key});

  @override
  State<Connectfarmer> createState() => _ConnectfarmerState();
}

class _ConnectfarmerState extends State<Connectfarmer> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController connectCode = TextEditingController();

  _codecheck() async {
    final isValid = _form.currentState?.validate();
    if (isValid!) {
      Map<String, String> updata = {
        "connect_code": connectCode.text,
      };
      final resp = await ConnectFarmerAPI(updata).connectFarmerApi();
      if (resp.status == ResponseStatus.SUCCESS) {
        buildconnectfarmer(context);
      } else if (resp.status == ResponseStatus.PRIVATE) {
        String? message = resp.message;
        utils.showToast("$message");
      } else {
        utils.showToast(resp.data);
        utils.showToast("Error");
      }
    }
  }

  buildconnectfarmer(context) {
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 2), () {
            //   connectCodeController.text = "";
            Navigator.of(context).pop(true);
          });
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AlertDialog(
                insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                backgroundColor:
                    Get.isDarkMode ? Colors.black : const Color(0XFFFFFFFF),
                contentPadding: EdgeInsets.fromLTRB(31.w, 50.h, 31.w, 52.h),
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  side: BorderSide(
                      color: Get.isDarkMode
                          ? Colors.grey
                          : const Color(0XFFFFFFFF)),
                ),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //sizedBoxHeight(46.h),
                    Align(
                      alignment: Alignment.center,
                      child: Text("Farmer Added Succesfully",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 22.sp,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                    sizedBoxHeight(23.h),
                    Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        "assets/images/connectcheck.svg",
                        width: 87.w,
                        height: 87.h,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // appBar: AppBar(
      //   title: customAppBar(text: "Connect To Farmer"),
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      //   titleSpacing: 0,
      //   backgroundColor: AppColors.white,
      // ),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Connect To Farmer",
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
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sizedBoxHeight(42.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Enter The Code To Connect To \nA Farmer",
                                // textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff141414)),
                              ),
                            ],
                          ),
                          sizedBoxHeight(59.h),
                          Align(
                            alignment: Alignment.center,
                            child: Text("Connection Code!",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff141414))),
                          ),
                          sizedBoxHeight(14.h),
                          TextFormField(
                            controller: connectCode,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            readOnly: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            cursorColor: AppColors.buttoncolour,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(fontSize: 16.sp),
                              contentPadding: EdgeInsets.all(17.h),
                              filled: true,
                              fillColor: const Color(0xFFF1F1F1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                    color:
                                        const Color(0xFF707070).withOpacity(0),
                                    width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                    color:
                                        const Color(0xFF707070).withOpacity(0),
                                    width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                    color:
                                        const Color(0xFF707070).withOpacity(0),
                                    width: 1),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 1),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 1),
                              ),
                              hintStyle: TextStyle(
                                  color: AppColors.buttoncolour,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                  fontSize: 16.sp),
                              hintText: "Enter Code",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Connection code is required';
                              }
                              return null;
                            },
                          ),
                          sizedBoxHeight(55.h),
                          customButtonCurve(
                              text: "Connect To Farmer",
                              onTap: () {
                                _codecheck();
                              })
                        ],
                      ),
                    ),
                  ))
                ],
              ))),
    );
  }
}
