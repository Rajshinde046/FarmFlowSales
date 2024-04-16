import 'package:farm_flow_sales/Common/limit_range.dart';
import 'package:farm_flow_sales/Model/farmerModel/farmer_address_model.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/custom_button.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/controller/cart_controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Common/custom_dropdown.dart';
import '../../view_models/farmer/FarmerListAPI.dart';

class selectFarmer extends StatefulWidget {
  const selectFarmer({super.key});

  @override
  State<selectFarmer> createState() => _selectFarmerState();
}

class _selectFarmerState extends State<selectFarmer> {
  String? selectedFarmer;
  String? selectedAddress;

  List<String> farmerList = [];
  List<String> farmerAddressList = [];
  List<int> farmerId = [];

  List<int> farmerAddressId = [];

  CartController cartController = Get.put(CartController());
  TextEditingController customNoteText = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  buildprofilelogoutdialog(context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlertDialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 16),
              backgroundColor:
                  Get.isDarkMode ? Colors.black : const Color(0XFFFFFFFF),
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                side: BorderSide(
                    color:
                        Get.isDarkMode ? Colors.grey : const Color(0XFFFFFFFF)),
              ),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.warning_amber_outlined,
                        color: Colors.red,
                        size: 60,
                      )),
                  SizedBox(
                    height: 22.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Please connect to farmer to place order !",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.sp,
                      ),
                    ),
                  ),
                  sizedBoxHeight(21.h),
                  InkWell(
                    onTap: () async {
                      Get.back();
                      Get.back();
                    },
                    child: Center(
                      child: Container(
                        height: 48.h,
                        width: 200.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.buttoncolour),
                        child: Center(
                          child: Text(
                            "OK",
                            style: TextStyle(
                                color: AppColors.white, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await FarmerListAPI().farmerApi().then((value) {
        if (value == "SalesAgents not connect to Any Farmer") {
          buildprofilelogoutdialog(context);
        } else {
          cartController.farmerListModel = value;
          for (var a in value.data!.farmers!) {
            farmerList.add(a.userName!);
            farmerId.add(a.id!);
          }
        }
        setState(() {});
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              SvgPicture.asset(
                "assets/images/selectfarmer.svg",
                width: 360.w,
              ),
              SizedBox(
                height: 25.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Select Farmer",
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              sizedBoxHeight(10.h),
              DropdownBtn(
                hint: "Select Farmer",
                // items: ,
                items: farmerList
                    .map((e) => DropdownMenuItem(
                          value: e,
                          onTap: () async {
                            setState(() {
                              selectedFarmer = e;
                            });
                            farmerAddressList.clear();
                            farmerAddressId.clear();
                            selectedAddress = null;
                            await FarmerListAPI()
                                .getFarmerAddressApi(
                                    farmerId[farmerList.indexOf(e)])
                                .then((value) {
                              FarmerAddressModel farmerAddressModel =
                                  FarmerAddressModel.fromJson(value.data);
                              cartController.farmerAddressModel =
                                  farmerAddressModel;
                              for (var a in farmerAddressModel.data!) {
                                farmerAddressId.add(a.id!);
                                farmerAddressList.add(
                                    "${a.farmAddress!}, ${a.street}, ${a.city}, ${a.province}, ${a.country}, ${a.postalCode}");
                              }
                              setState(() {});
                            });
                          },
                          child: Text(
                            e,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4D4D4D),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                value: selectedFarmer,
              ),
              sizedBoxHeight(30),
              DropdownBtn(
                hint: "Select Address",
                // items: ,
                items: farmerAddressList
                    .map((e) => DropdownMenuItem(
                          value: e,
                          onTap: () {
                            setState(() {
                              selectedAddress = e;
                            });
                          },
                          child: Text(
                            e,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4D4D4D),
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                value: selectedAddress,
              ),
              sizedBoxHeight(30),
              CustomButton(
                  text: "Deliver To This Address",
                  onTap: () {
                    if (selectedFarmer == null) {
                      utils.showToast("Please Select Farmer");
                    } else if (selectedAddress == null) {
                      utils.showToast("Please Select Farmer Address");
                    } else {
                      cartController.farmerName = selectedFarmer!;

                      cartController.selectedFarmerId =
                          farmerId[farmerList.indexOf(selectedFarmer!)];
                      cartController.selectedFarmAddressId = farmerAddressId[
                          farmerAddressList.indexOf(selectedAddress!)];
                      Get.toNamed("/selectfrequency");
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  buildcustomnote();
                },
                child: Container(
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.buttoncolour),
                      borderRadius: BorderRadius.circular(25.h),
                      color: AppColors.white),
                  child: Center(
                    child: Text(
                      "Add Delivery Instructions",
                      style: TextStyle(color: AppColors.black, fontSize: 18.sp),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildcustomnote() {
    customNoteText.text = cartController.deliveryInstructionText;
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            insetPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
            contentPadding: const EdgeInsets.fromLTRB(15, 30, 15, 24),
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              side: BorderSide(
                  color: Get.isDarkMode ? Colors.grey : Colors.white),
            ),
            // contentPadding:
            //     EdgeInsets.all(
            //         10),
            //   title: ,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Custom Note",
                  style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500),
                ),
                sizedBoxHeight(9.h),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: customNoteText,
                    style: TextStyle(fontSize: 16.sp),
                    cursorColor: const Color(0xFF3B3F43),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(fontSize: 16.sp),
                      contentPadding: EdgeInsets.all(17.h),
                      filled: true,
                      fillColor: AppColors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(
                            color: Color(0xFF707070), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(
                            color: Color(0xFF707070), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(
                            color: Color(0xFF707070), width: 1),
                      ),
                      hintStyle: TextStyle(
                          color: const Color(0xFF4D4D4D), fontSize: 16.sp),
                      hintText: "",
                    ),
                    minLines: 3,
                    maxLines: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Message is required';
                      }
                      return null;
                    },
                  ),
                ),
                sizedBoxHeight(41.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        final isValid = _formKey.currentState?.validate();
                        if (isValid!) {
                          cartController.deliveryInstructionText =
                              customNoteText.text;
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.buttoncolour),
                        child: Center(
                          child: Text(
                            "Add",
                            style: TextStyle(
                                color: AppColors.white, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                    sizedBoxWidth(28.w),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0XFF0E5F02)),
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.white),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: AppColors.buttoncolour, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget newslistCard(
    dynamic recipeimage,
    dynamic title,
    dynamic street,
    int index,
    dynamic city,
    dynamic state,
    dynamic phone,
    dynamic zipcode,
    dynamic country) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: GFAccordion(
          showAccordion: false,
          titleBorderRadius: BorderRadius.circular(5.r),
          contentBorderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5.r),
            bottomRight: Radius.circular(5.r),
          ),
          margin: const EdgeInsets.all(0),
          titlePadding: EdgeInsets.all(10.h),
          contentPadding: EdgeInsets.all(10.w),
          expandedTitleBackgroundColor: Colors.white,
          contentBackgroundColor: Colors.white,
          titleChild: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontFamily: "Poppins",
            ),
          ),
          contentChild: Row(
            children: [
              const Icon(
                Icons.radio_button_checked,
                color: AppColors.buttoncolour,
              ),
              sizedBoxWidth(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Address",
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "street: ",
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        street,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "city: ",
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        city,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "state/province/area: ",
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        state,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "phone number: ",
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        phone,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "zip code: ",
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        zipcode,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "country: ",
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        country,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                  sizedBoxHeight(15.h),
                ],
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 15.h,
      ),
    ],
  );
}
