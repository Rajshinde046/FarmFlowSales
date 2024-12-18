import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:farm_flow_sales/Common/limit_range.dart';
import 'package:farm_flow_sales/Model/orderModel/order_details_model.dart';
import 'package:farm_flow_sales/Utils/api_urls.dart';
import 'package:farm_flow_sales/Utils/base_manager.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/Utils/utils.dart';
import 'package:farm_flow_sales/view_models/orderApi/order_api.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Utils/texts.dart';

class Orderdetails extends StatefulWidget {
  const Orderdetails({super.key});

  @override
  State<Orderdetails> createState() => _OrderdetailsState();
}

class _OrderdetailsState extends State<Orderdetails> {
  String? id;
  RxBool isLoading = true.obs;
  OrderDetailsModel orderDetailsModel = OrderDetailsModel();
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    var args = Get.arguments;
    id = args['id'].toString();
    OrderApi().getOrderDetails(id!).then((value) {
      orderDetailsModel = OrderDetailsModel.fromJson(value.data);
      isLoading.value = false;

      _analytics.logEvent(
        name: 'order_details_loaded',
        parameters: {
          'order_id': orderDetailsModel.data!.orderHeaderId,
        },
      );
    });
    super.initState();
  }

  buildcontentcalldialog(
    context,
    String number,
  ) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            backgroundColor:
                Get.isDarkMode ? Colors.black : const Color(0XFFFFFFFF),
            //contentPadding: EdgeInsets.fromLTRB(96, 32, 96, 28),
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
                //sizedBoxHeight(32.h),
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/images/contactphone.svg",
                    // "assets/images/call.svg",
                    width: 35.w,
                    height: 35.h,
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Are you sure you want to call delviery agent?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                sizedBoxHeight(21.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        launch("tel://$number");
                        _analytics.logEvent(
                          name: 'call_delivery_agent',
                          parameters: {
                            'number': number,
                          },
                        );
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.buttoncolour),
                        child: Center(
                          child: Text(
                            "Yes",
                            style: TextStyle(
                                color: AppColors.white, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
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
                            "No",
                            style: TextStyle(
                                color: AppColors.buttoncolour, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: 20.h, left: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
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
                sizedBoxWidth(15.w),
                Text(
                  "Order Details",
                  style: TextStyle(
                    color: const Color(0XFF141414),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: AppColors.white,
        body: Obx(
          () => isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.buttoncolour,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sizedBoxHeight(9.h),
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order Id : ${orderDetailsModel.data!.orderHeaderId!}",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: const Color(0XFF141414),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                            ),
                          ),
                          Text(
                            orderDetailsModel.data!.orderType == 1
                                ? "Order Type : Bin"
                                : "Order Type : Shed",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: const Color(0XFF141414),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sizedBoxHeight(10.h),
                            Padding(
                              padding: EdgeInsets.only(left: 16.w, right: 16.w),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.h),
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/images/locationconnect.svg",
                                              width: 13.w,
                                              height: 17.h,
                                            ),
                                            sizedBoxWidth(6.w),
                                            Text(
                                              "Delivering To",
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w300,
                                                  color:
                                                      const Color(0xff4D4D4D),
                                                  fontFamily: "Poppins"),
                                            ),
                                          ],
                                        ),
                                        sizedBoxHeight(1.h),
                                        SizedBox(
                                          width: Get.width / 1.1,
                                          child: Text(
                                            orderDetailsModel.data!.address!,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: const Color(0XFF141414),
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  // Padding(
                                  //   padding: EdgeInsets.only(top: 8.h),
                                  //   child: Text(
                                  //     "Edit",
                                  //     style: TextStyle(
                                  //         fontSize: 16.sp,
                                  //         color: const Color(0XFF0E5F02),
                                  //         fontFamily: "Poppins",
                                  //         fontWeight: FontWeight.bold),
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                            sizedBoxHeight(17.h),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    orderDetailsModel.data!.productList!.length,
                                itemBuilder: (ctx, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: 16.w, right: 16.w, bottom: 9.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 82.w,
                                          height: 88.h,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.h),
                                              border: Border.all(
                                                color: const Color(0xff918E8E),
                                              ),
                                              color: AppColors.white),
                                          child: CachedNetworkImage(
                                            memCacheHeight: 71,
                                            maxHeightDiskCache: 71,
                                            maxWidthDiskCache: 76,
                                            memCacheWidth: 76,
                                            imageUrl:
                                                "${ApiUrls.baseImageUrl}/${orderDetailsModel.data!.productList![index].smallImageUrl}",
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(
                                              color: AppColors.buttoncolour,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                        sizedBoxWidth(15.w),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 0.6.sw,
                                              child: Text(
                                                orderDetailsModel
                                                    .data!
                                                    .productList![index]
                                                    .itemTitle!,
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color:
                                                        const Color(0XFF141414),
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Poppins"),
                                              ),
                                            ),
                                            sizedBoxHeight(2.h),
                                            Text(
                                              "Quantity : ${orderDetailsModel.data!.productList![index].quantity}",
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w300,
                                                  color:
                                                      const Color(0XFF4D4D4D),
                                                  fontFamily: "Poppins"),
                                            ),
                                            sizedBoxHeight(2.h),
                                            Text(
                                              "Lot : ${orderDetailsModel.data!.productList![index].lot}",
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w300,
                                                  color:
                                                      const Color(0XFF4D4D4D),
                                                  fontFamily: "Poppins"),
                                            ),
                                            sizedBoxHeight(2.h),
                                            Text(
                                              "€ ${double.parse(orderDetailsModel.data!.productList![index].itemUnitValue!) * orderDetailsModel.data!.productList![index].quantity!}",
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0XFF141414),
                                                  fontFamily: "Poppins"),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }),
                            // sizedBoxHeight(9.h),
                            // Padding(
                            //   padding: EdgeInsets.symmetric(horizontal: 16.w),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Text(
                            //         "Order",
                            //         style: TextStyle(
                            //             fontSize: 16.sp,
                            //             color: const Color(0XFF4D4D4D),
                            //             fontFamily: "Poppins",
                            //             fontWeight: FontWeight.w500),
                            //       ),
                            //       Text(
                            //         "Cow Feed",
                            //         style: TextStyle(
                            //             fontSize: 16.sp,
                            //             color: const Color(0xff141414),
                            //             fontFamily: "Poppins",
                            //             fontWeight: FontWeight.w500),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            sizedBoxHeight(14.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        text18w5004D4D4D('Total Amount'),
                                        text18w5004D4D4D(
                                            '€ ${orderDetailsModel.data!.totalValue!}'),
                                      ]),
                                  sizedBoxHeight(15.h),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        text18w5004D4D4D("Discount on MRP"),
                                        text18w5004D4D4D(orderDetailsModel
                                                    .data!.discountType ==
                                                "0"
                                            ? "- ${orderDetailsModel.data!.discountValue} %"
                                            : '- € ${orderDetailsModel.data!.discountValue}')
                                      ]),
                                  sizedBoxHeight(3.h),
                                  const Divider(
                                      thickness: 1,
                                      color: AppColors.buttoncolour),
                                  sizedBoxHeight(3.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      text18w5004D4D4D("Total Amount"),
                                      Row(
                                        children: [
                                          text18w5004D4D4D(
                                              "€ ${orderDetailsModel.data!.netValue}"),
                                          sizedBoxWidth(11.h),
                                          Padding(
                                            padding: EdgeInsets.only(top: 2.h),
                                            child: Text(
                                              "(${orderDetailsModel.data!.productList!.length} Items)",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: const Color(0XFF4D4D4D),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Poppins",
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            sizedBoxHeight(13.h),
                            InkWell(
                              onTap: () async {
                                var permissionStatus =
                                    await Permission.storage.status;
                                if (permissionStatus.isDenied) {
                                  await Permission.storage.request();
                                  permissionStatus =
                                      await Permission.storage.status;
                                  if (permissionStatus.isDenied) {
                                    await openAppSettings();
                                  }
                                } else if (permissionStatus
                                    .isPermanentlyDenied) {
                                  await openAppSettings();
                                } else {
                                  log("${ApiUrls.base}download/invoice/${orderDetailsModel.data!.orderHeaderId!}");
                                  OrderApi()
                                      .downloadFile(
                                          "${ApiUrls.base}download/invoice/${orderDetailsModel.data!.orderHeaderId!}",
                                          "invoice_${orderDetailsModel.data!.orderHeaderId!}.pdf")
                                      .then((value) {});
                                }
                                permissionStatus =
                                    await Permission.storage.status;
                                if (permissionStatus.isGranted) {
                                  OrderApi()
                                      .downloadFile(
                                          "${ApiUrls.base}download/invoice/${orderDetailsModel.data!.orderHeaderId!}",
                                          "invoice_${orderDetailsModel.data!.orderHeaderId!}.pdf")
                                      .then((value) {
                                    _analytics.logEvent(
                                      name: "download_invoice",
                                      parameters: {
                                        "order_id": orderDetailsModel
                                            .data!.orderHeaderId!,
                                      },
                                    );
                                  });
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Container(
                                  width: 358.w,
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0XFF918E8E),
                                    ),
                                    color: AppColors.white,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Gap(15),
                                      SvgPicture.asset(
                                        "assets/images/download.svg",
                                        // width: 12.w,
                                        // height: 13.h,
                                      ),
                                      sizedBoxWidth(10.w),
                                      Text(
                                        "Download Invoice",
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: "Poppins",
                                            color: const Color(0XFF0E5F02),
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            sizedBoxHeight(22.h),
                            orderDetailsModel.data!.deliveryAgent == null
                                ? Center(
                                    child: LottieBuilder.asset(
                                      "assets/lotties/order_pending.json",
                                      width: 250,
                                      height: 150,
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(left: 51.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            sizedBoxHeight(8.h),
                                            status(),
                                            !orderDetailsModel
                                                    .data!.deliveryStatus!
                                                    .any((item) =>
                                                        item.deliveryStatusXid ==
                                                        7)
                                                ? const DottedLine(
                                                    direction: Axis.vertical,
                                                    lineLength: 45,
                                                    lineThickness: 2.0,
                                                    dashLength: 4.0,
                                                    dashColor:
                                                        Color(0XFF0E5F02),
                                                  )
                                                : const Dash(
                                                    direction: Axis.vertical,
                                                    length: 25,
                                                    dashLength: 49,
                                                    dashGap: 0,
                                                    dashColor:
                                                        Color(0XFF0E5F02)),
                                            status(),
                                            !orderDetailsModel
                                                    .data!.deliveryStatus!
                                                    .any((item) =>
                                                        item.deliveryStatusXid ==
                                                        5)
                                                ? const DottedLine(
                                                    direction: Axis.vertical,
                                                    lineLength: 45,
                                                    lineThickness: 2.0,
                                                    dashLength: 4.0,
                                                    dashColor:
                                                        Color(0XFF0E5F02),
                                                  )
                                                : const Dash(
                                                    direction: Axis.vertical,
                                                    length: 25,
                                                    dashLength: 49,
                                                    dashGap: 0,
                                                    dashColor:
                                                        Color(0XFF0E5F02)),
                                            status(),
                                            !orderDetailsModel
                                                    .data!.deliveryStatus!
                                                    .any((item) =>
                                                        item.deliveryStatusXid ==
                                                        4)
                                                ? const DottedLine(
                                                    direction: Axis.vertical,
                                                    lineLength: 45,
                                                    lineThickness: 2.0,
                                                    dashLength: 4.0,
                                                    dashColor:
                                                        Color(0XFF0E5F02),
                                                  )
                                                : const Dash(
                                                    direction: Axis.vertical,
                                                    length: 25,
                                                    dashLength: 39,
                                                    dashGap: 0,
                                                    dashColor:
                                                        Color(0XFF0E5F02)),
                                            status(),
                                          ],
                                        ),
                                        sizedBoxWidth(18.w),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            sizedBoxHeight(3.h),
                                            Text(
                                              "Delivered",
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xff141414),
                                                  fontFamily: "Poppins"),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                !orderDetailsModel
                                                        .data!.deliveryStatus!
                                                        .any((item) =>
                                                            item.deliveryStatusXid ==
                                                            7)
                                                    ? Text("Pending",
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0xff4D4D4D),
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                "Poppins"))
                                                    : Text(
                                                        Utils.convertUtcToCustomFormat(
                                                            orderDetailsModel
                                                                .data!
                                                                .deliveryStatus![
                                                                    4]
                                                                .createdAt!),
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0xff4D4D4D),
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                "Poppins"),
                                                      ),
                                              ],
                                            ),
                                            sizedBoxHeight(22.h),
                                            Text(
                                              "Out For Delivery",
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xff141414),
                                                  fontFamily: "Poppins"),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                !orderDetailsModel
                                                        .data!.deliveryStatus!
                                                        .any((item) =>
                                                            item.deliveryStatusXid ==
                                                            5)
                                                    ? Text("Pending",
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0xff4D4D4D),
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                "Poppins"))
                                                    : Text(
                                                        Utils.convertUtcToCustomFormat(
                                                            orderDetailsModel
                                                                .data!
                                                                .deliveryStatus![
                                                                    3]
                                                                .createdAt!),
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0xff4D4D4D),
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                "Poppins"),
                                                      ),
                                              ],
                                            ),
                                            sizedBoxHeight(25.h),
                                            Text(
                                              "Packed & Ready",
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xff141414),
                                                  fontFamily: "Poppins"),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                !orderDetailsModel
                                                        .data!.deliveryStatus!
                                                        .any((item) =>
                                                            item.deliveryStatusXid ==
                                                            4)
                                                    ? Text("Pending",
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0xff4D4D4D),
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                "Poppins"))
                                                    : Text(
                                                        Utils.convertUtcToCustomFormat(
                                                            orderDetailsModel
                                                                .data!
                                                                .deliveryStatus![
                                                                    2]
                                                                .createdAt!),
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0xff4D4D4D),
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                "Poppins"),
                                                      ),
                                              ],
                                            ),
                                            sizedBoxHeight(15.h),
                                            Text(
                                              "Ordered",
                                              style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xff141414),
                                                  fontFamily: "Poppins"),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  Utils
                                                      .convertUtcToCustomFormat(
                                                          orderDetailsModel
                                                              .data!
                                                              .oderSummary!),
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xff4D4D4D),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.sp,
                                                      fontFamily: "Poppins"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                            orderDetailsModel.data!.deliveryAgent == null
                                ? const SizedBox()
                                : sizedBoxHeight(20.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: orderDetailsModel.data!.deliveryAgent ==
                                      null
                                  ? Center(
                                      child: Text(
                                        "Your order is yet to be picked by our delivery agent",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: AppColors.buttoncolour,
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        _analytics.logEvent(
                                          name: "call_delivery_agent",
                                          parameters: {
                                            "delivery_agent": orderDetailsModel
                                                .data!.deliveryAgent!,
                                          },
                                        );
                                        buildcontentcalldialog(
                                            context,
                                            orderDetailsModel
                                                .data!.deliveryAgent!);
                                      },
                                      child: Container(
                                        height: 50.h,
                                        width: 358.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.h),
                                            color: AppColors.buttoncolour),
                                        child: Center(
                                          child: Text(
                                            "Call Delivery Agent",
                                            style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                            orderDetailsModel.data!.deliveryAgent == null
                                ? sizedBoxHeight(20.h)
                                : const SizedBox(),
                            orderDetailsModel.data!.deliveryAgent == null
                                ? Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    child: InkWell(
                                      onTap: () {
                                        _analytics.logEvent(
                                          name: "cancel_order",
                                          parameters: {
                                            "order_id": orderDetailsModel
                                                .data!.orderHeaderId!,
                                          },
                                        );
                                        Utils.loader();
                                        OrderApi()
                                            .cancelOrderApi(orderDetailsModel
                                                .data!.orderHeaderId
                                                .toString())
                                            .then((value) {
                                          Get.back();
                                          if (value.status ==
                                              ResponseStatus.FAILED) {
                                            utils.showToast(value.message);
                                          } else {
                                            utils.showToast(
                                                value.data["message"]);
                                            Get.back(result: true);
                                          }
                                        });
                                      },
                                      child: Container(
                                        height: 50.h,
                                        width: 358.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.h),
                                            color: AppColors.buttoncolour),
                                        child: Center(
                                          child: Text(
                                            "Cancel Order",
                                            style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 18.sp),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            sizedBoxHeight(26.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Container(
                                width: 358.w,
                                // height: 115.h,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Color(0xffF1F1F1),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0xff00000029),
                                          blurRadius: 6.0,
                                          spreadRadius: 0)
                                    ]),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 10.w, top: 5.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 5.h),
                                        child: SvgPicture.asset(
                                          "assets/images/list.svg",
                                          width: 53.w,
                                          height: 53.h,
                                        ),
                                      ),
                                      sizedBoxWidth(10.w),
                                      Padding(
                                        padding: EdgeInsets.only(top: 14.h),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Order Summary",
                                              style: TextStyle(
                                                  fontSize: 20.sp,
                                                  color:
                                                      const Color(0xff141414),
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Poppins"),
                                            ),
                                            // sizedBoxHeight(8.h),
                                            // Text(
                                            //   "Order g: 408-0073624-7437935",
                                            //   style: TextStyle(
                                            //       fontSize: 14.sp,
                                            //       color:
                                            //           const Color(0XFF141414),
                                            //       fontWeight: FontWeight.w400,
                                            //       fontFamily: "Poppins"),
                                            // ),
                                            sizedBoxHeight(7.h),
                                            Text(
                                              "Ordered: ${Utils.convertDate(orderDetailsModel.data!.oderSummary!)}",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color:
                                                      const Color(0XFF141414),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Poppins"),
                                            ),
                                            sizedBoxHeight(18.h),
                                          ],
                                        ),
                                      ),
                                      //)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            sizedBoxHeight(20.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget status() {
    return CircleAvatar(
      backgroundColor: AppColors.buttoncolour,
      radius: 6.h,
    );
  }
}
