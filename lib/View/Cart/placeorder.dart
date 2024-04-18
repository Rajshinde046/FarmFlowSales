import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_flow_sales/Common/custom_button_curve.dart';
import 'package:farm_flow_sales/Common/limit_range.dart';
import 'package:farm_flow_sales/Utils/api_urls.dart';
import 'package:farm_flow_sales/Utils/base_manager.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/controller/inventories_controller.dart';
import 'package:farm_flow_sales/view_models/cartApi/cartApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Utils/utils.dart';
import '../../controller/cart_controller.dart';

class Placedorder extends StatefulWidget {
  const Placedorder({
    Key? key,
    this.minValue = 0,
    this.maxValue = 10,
    this.minValue1 = 0,
    this.maxValue1 = 10,
    this.minValue2 = 0,
    this.maxValue2 = 10,

    //  this.onChanged
  }) : super(key: key);
  final int minValue;
  final int maxValue;
  final int minValue1;
  final int maxValue1;
  final int minValue2;
  final int maxValue2;

  @override
  State<Placedorder> createState() => _PlacedorderState();
}

class _PlacedorderState extends State<Placedorder> {
  CartController cartController = Get.put(CartController());
  InventoriesController inventoriesController =
      Get.put(InventoriesController());
  String phoneNumber = "";
  String street = "";

  String city = "";
  String state = "";
  String zipcode = "";
  String country = "";

  buildorderconfirmpopup() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: Column(
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
              content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 45),
                        child: Text(
                          textAlign: TextAlign.center,
                          "Your Order Has Been Placed Successfully!",
                          style: GoogleFonts.poppins(
                              fontSize: 20.sp,
                              color: const Color(0xff4D4D4D),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed("/sideMenu");
                    },
                    child: Container(
                      height: 50.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.h),
                          color: AppColors.buttoncolour),
                      child: Center(
                        child: Text(
                          "Ok",
                          style: TextStyle(
                              color: AppColors.white, fontSize: 18.sp),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool? change;

  @override
  void initState() {
    change = Get.arguments["bool"];
    for (var a in cartController.farmerListModel.data!.farmers!) {
      if (a.id == cartController.selectedFarmerId) {
        phoneNumber = a.phoneNumber!;
      }
    }
    for (var a in cartController.farmerAddressModel.data!) {
      if (a.id == cartController.selectedFarmAddressId) {
        street = a.street!;
        city = a.city!;
        state = a.province!;
        zipcode = a.postalCode.toString();
        country = a.country!;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 44.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                "assets/images/placedorder.svg",
                width: 360.w,
                // height: 45.h,
              ),
              sizedBoxHeight(28.h),
              Text(
                "Farmer Name",
                style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500),
              ),
              sizedBoxHeight(7.h),
              Container(
                width: 358.w,
                // height: 48.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: const Color(0xffF1F1F1),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 19.w, top: 12, bottom: 11),
                  child: Text(
                    cartController.farmerName,
                    style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              sizedBoxHeight(21.h),
              Container(
                width: 358.w,
                height: 263.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: const Color(0xffF1F1F1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 19.w, top: 12, bottom: 11),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Text(
                              "Address",
                              style: GoogleFonts.poppins(
                                fontSize: 20.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          sizedBoxHeight(4.h),
                          RichText(
                            text: TextSpan(
                              text: "street : ",
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600),
                              children: [
                                TextSpan(
                                  text: street,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16.sp,
                                      color: const Color(0xff4D4D4D),
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          sizedBoxHeight(5.h),
                          RichText(
                            text: TextSpan(
                              text: "city : ",
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600),
                              children: [
                                TextSpan(
                                  text: city,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16.sp,
                                      color: const Color(0xff4D4D4D),
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          sizedBoxHeight(5.h),
                          RichText(
                            text: TextSpan(
                              text: "state/province/area : ",
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600),
                              children: [
                                TextSpan(
                                  text: state,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16.sp,
                                      color: const Color(0xff4D4D4D),
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          sizedBoxHeight(5.h),
                          RichText(
                            text: TextSpan(
                              text: "phone number : ",
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600),
                              children: [
                                TextSpan(
                                  text: phoneNumber,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16.sp,
                                      color: const Color(0xff4D4D4D),
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          sizedBoxHeight(5.h),
                          RichText(
                            text: TextSpan(
                              text: "zip code : ",
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600),
                              children: [
                                TextSpan(
                                  text: zipcode,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16.sp,
                                      color: const Color(0xff4D4D4D),
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          sizedBoxHeight(5.h),
                          RichText(
                            text: TextSpan(
                              text: "country : ",
                              style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600),
                              children: [
                                TextSpan(
                                  text: country,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 16.sp,
                                      color: const Color(0xff4D4D4D),
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              sizedBoxHeight(24.h),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: inventoriesController
                      .viewCartModel.value.data!.cart!.length,
                  itemBuilder: (ctx, index) {
                    return Container(
                      width: 358.w, margin: const EdgeInsets.only(bottom: 15),
                      // height: 120.h,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xffF1F1F1),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xff0000001F),
                                blurRadius: 12.0,
                                offset: Offset(0.0, 0.75),
                                spreadRadius: 2)
                          ]),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 22.w, right: 16.w, top: 8.h, bottom: 13.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CachedNetworkImage(
                              memCacheHeight: 97,
                              maxHeightDiskCache: 97,
                              maxWidthDiskCache: 85,
                              memCacheWidth: 85,
                              imageUrl:
                                  "${ApiUrls.baseImageUrl}/${inventoriesController.viewCartModel.value.data!.cart![index].getItems![0].item!.smallImageUrl}",
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(
                                color: AppColors.buttoncolour,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            sizedBoxWidth(31.w),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 0.6.sw,
                                  child: Text(
                                    inventoriesController
                                        .viewCartModel
                                        .value
                                        .data!
                                        .cart![index]
                                        .getItems![0]
                                        .item!
                                        .title!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff141414),
                                    ),
                                  ),
                                ),
                                sizedBoxHeight(3.h),
                                Text(
                                  inventoriesController.viewCartModel.value
                                      .data!.cart![index].getItems![0].lotName!,
                                  style: GoogleFonts.poppins(
                                      fontSize: 15.sp,
                                      color: const Color(0xff4D4D4D),
                                      fontWeight: FontWeight.w300),
                                ),
                                sizedBoxHeight(7.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "€ ${inventoriesController.viewCartModel.value.data!.cart![index].getItems![0].price! * inventoriesController.viewCartModel.value.data!.cart![index].quantity!}",
                                      style: GoogleFonts.poppins(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              sizedBoxHeight(3.h),
              const Divider(
                thickness: 1,
                color: AppColors.buttoncolour,
              ),
              sizedBoxHeight(7.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total MRP",
                    style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        color: const Color(0xff4D4D4D),
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "€ ${inventoriesController.cartSubTotalValue}",
                    style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        color: const Color(0xff4D4D4D),
                        fontWeight: FontWeight.w500),
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
                        color: const Color(0xff4D4D4D),
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    change!
                        ? "- ${cartController.discountValue} %"
                        : "€ ${cartController.discountValue}",
                    style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        color: const Color(0xff4D4D4D),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              sizedBoxHeight(3.h),
              const Divider(
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
                        color: AppColors.buttoncolour,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "€ ${cartController.netValue}",
                    style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        color: AppColors.buttoncolour,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              sizedBoxHeight(29.h),
              customButtonCurve(
                  text: "Confirm Delivery",
                  onTap: () {
                    Utils.loader();
                    String formattedDate = "";
                    if (cartController.selectedStartDate.isNotEmpty) {
                      List<String> dateSplit =
                          cartController.selectedStartDate.split("/");
                      formattedDate =
                          '${dateSplit[2]}-${dateSplit[1]}-${dateSplit[0]}';
                    }

                    CartApi()
                        .placeOrder(
                      cartController.selectedFarmerId,
                      cartController.selectedFarmAddressId,
                      cartController.deliveryInstructionText,
                      cartController.selectedFrequencyId,
                      formattedDate,
                      cartController.discountTypeId,
                      cartController.discountValue,
                      cartController.cartDataId,
                      inventoriesController.cartSubTotalValue.value.toDouble(),
                      cartController.netValue,
                      cartController.selectedOrderType,
                    )
                        .then((value) {
                      Get.back();
                      if (value.status == ResponseStatus.FAILED) {
                        utils.showToast(value.message);
                      } else {
                        buildorderconfirmpopup();
                      }
                    });
                  }),
              sizedBoxHeight(30.h)
            ],
          ),
        ),
      ),
    );
  }
}
