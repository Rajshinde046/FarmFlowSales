import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_flow_sales/Model/orderModel/completed_order_model.dart';
import 'package:farm_flow_sales/Model/orderModel/ongoing_order_model.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/controller/dashboard_controller.dart';
import 'package:farm_flow_sales/view_models/orderApi/order_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../Utils/api_urls.dart';
import '../../Utils/texts.dart';

enum SingingCharacter {
  All,
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

class _OrderMainState extends State<OrderMain> with TickerProviderStateMixin {
  OngoingOrderModel ongoingOrderModel = OngoingOrderModel();
  DashboardController dashboardController = Get.put(DashboardController());
  CompletedOrderModel completedOrderModel = CompletedOrderModel();
  RxBool isOngoingLoading = true.obs;
  RxBool isCompletedLoading = true.obs;
  TabController? tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    if (dashboardController.selectedTab.value == 0) {
      tabController!.animateTo(0);
      OrderApi().getOngoingOrderData().then((value) {
        ongoingOrderModel = OngoingOrderModel.fromJson(value.data);
        isOngoingLoading.value = false;
      });
    } else if (dashboardController.selectedTab.value == 1) {
      tabController!.animateTo(1);
      OrderApi().getPendingOrdersList().then((value) {
        ongoingOrderModel = OngoingOrderModel.fromJson(value.data);
        isOngoingLoading.value = false;
      });
    } else {
      tabController!.animateTo(2);
      OrderApi().getCompletedOrderData("0").then((value) {
        completedOrderModel = CompletedOrderModel.fromJson(value.data);
        isCompletedLoading.value = false;
      });
    }

    super.initState();
  }

  SingingCharacter? _character = SingingCharacter.All;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 8.h),
              child: TabBar(
                controller: tabController,
                onTap: ((value) {
                  if (value == 0) {
                    isOngoingLoading.value = true;
                    OrderApi().getOngoingOrderData().then((value) {
                      ongoingOrderModel =
                          OngoingOrderModel.fromJson(value.data);
                      isOngoingLoading.value = false;
                    });
                  } else if (value == 1) {
                    isOngoingLoading.value = true;
                    OrderApi().getPendingOrdersList().then((value) {
                      ongoingOrderModel =
                          OngoingOrderModel.fromJson(value.data);
                      isOngoingLoading.value = false;
                    });
                  } else {
                    isCompletedLoading.value = true;
                    OrderApi().getCompletedOrderData("0").then((value) {
                      completedOrderModel =
                          CompletedOrderModel.fromJson(value.data);
                      isCompletedLoading.value = false;
                    });
                  }
                }),
                labelStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.normal, fontSize: 16.sp),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.white,
                tabs: const [
                  Tab(
                    text: "Ongoing",
                  ),
                  Tab(
                    text: "Pending",
                  ),
                  Tab(
                    text: "Completed",
                  ),
                ],
              ),
            ),
            elevation: 0,
            backgroundColor: AppColors.buttoncolour,
          ),
          backgroundColor: AppColors.white,
          body: TabBarView(
            controller: tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              RefreshIndicator(
                strokeWidth: 3,
                displacement: 250,
                backgroundColor: Colors.white,
                color: AppColors.buttoncolour,
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 1500));
                  isOngoingLoading.value = true;
                  OrderApi().getOngoingOrderData().then((value) {
                    ongoingOrderModel = OngoingOrderModel.fromJson(value.data);
                    isOngoingLoading.value = false;
                  });
                  setState(() {});
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
                        child: Text(
                          "Ongoing Orders",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, fontSize: 18.sp),
                        ),
                      ),
                      sizedBoxHeight(13.h),
                      Obx(
                        () => isOngoingLoading.value
                            ? Container(
                                margin: EdgeInsets.only(top: Get.height / 3.5),
                                child: const Center(
                                    child: CircularProgressIndicator(
                                  color: AppColors.buttoncolour,
                                )))
                            : SizedBox(
                                height: Get.height / 1.4,
                                width: Get.width,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(23, 5, 23, 0),
                                  child: ongoingOrderModel.data!.isEmpty
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            LottieBuilder.asset(
                                                "assets/lotties/no_data_found.json"),
                                            textGrey4D4D4D_22(
                                                "No Ongoing Orders Found !"),
                                          ],
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount:
                                              ongoingOrderModel.data!.length,
                                          itemBuilder: (_, index) {
                                            return InkWell(
                                              onTap: () async {
                                                var result = await Get.toNamed(
                                                    "/orderdetails",
                                                    arguments: {
                                                      "id": ongoingOrderModel
                                                          .data![index]
                                                          .orderHeaderId!,
                                                    });
                                                if (result != null &&
                                                    result == true) {
                                                  isOngoingLoading.value = true;
                                                  OrderApi()
                                                      .getOngoingOrderData()
                                                      .then((value) {
                                                    ongoingOrderModel =
                                                        OngoingOrderModel
                                                            .fromJson(
                                                                value.data);
                                                    isOngoingLoading.value =
                                                        false;
                                                  });
                                                }
                                              },
                                              child: SalesOrderMainTile(
                                                ongoingOrderModel.data![index]
                                                    .getFarmer!.profilePhoto!,
                                                ongoingOrderModel.data![index]
                                                    .getFarmer!.userName!,
                                                ongoingOrderModel.data![index]
                                                    .getFarmer!.phoneNumber!,
                                                ongoingOrderModel
                                                    .data![index].address!,
                                              ),
                                            );
                                          },
                                        ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              RefreshIndicator(
                strokeWidth: 3,
                displacement: 250,
                backgroundColor: Colors.white,
                color: AppColors.buttoncolour,
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 1500));
                  isOngoingLoading.value = true;
                  OrderApi().getPendingOrdersList().then((value) {
                    ongoingOrderModel = OngoingOrderModel.fromJson(value.data);
                    isOngoingLoading.value = false;
                  });
                  setState(() {});
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
                        child: Text(
                          "Pending Orders",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500, fontSize: 18.sp),
                        ),
                      ),
                      sizedBoxHeight(13.h),
                      Obx(
                        () => isOngoingLoading.value
                            ? Container(
                                margin: EdgeInsets.only(top: Get.height / 3.5),
                                child: const Center(
                                    child: CircularProgressIndicator(
                                  color: AppColors.buttoncolour,
                                )))
                            : SizedBox(
                                height: Get.height / 1.4,
                                width: Get.width,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(23, 5, 23, 0),
                                  child: ongoingOrderModel.data!.isEmpty
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            LottieBuilder.asset(
                                                "assets/lotties/no_data_found.json"),
                                            textGrey4D4D4D_22(
                                                "No Ongoing Orders Found !"),
                                          ],
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount:
                                              ongoingOrderModel.data!.length,
                                          itemBuilder: (_, index) {
                                            return InkWell(
                                              onTap: () async {
                                                var result = await Get.toNamed(
                                                    "/orderdetails",
                                                    arguments: {
                                                      "id": ongoingOrderModel
                                                          .data![index]
                                                          .orderHeaderId!,
                                                    });
                                                if (result != null &&
                                                    result == true) {
                                                  isOngoingLoading.value = true;
                                                  OrderApi()
                                                      .getPendingOrdersList()
                                                      .then((value) {
                                                    ongoingOrderModel =
                                                        OngoingOrderModel
                                                            .fromJson(
                                                                value.data);
                                                    isOngoingLoading.value =
                                                        false;
                                                  });
                                                }
                                              },
                                              child: SalesOrderMainTile(
                                                ongoingOrderModel.data![index]
                                                    .getFarmer!.profilePhoto!,
                                                ongoingOrderModel.data![index]
                                                    .getFarmer!.userName!,
                                                ongoingOrderModel.data![index]
                                                    .getFarmer!.phoneNumber!,
                                                ongoingOrderModel
                                                    .data![index].address!,
                                              ),
                                            );
                                          },
                                        ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              RefreshIndicator(
                strokeWidth: 3,
                displacement: 250,
                backgroundColor: Colors.white,
                color: AppColors.buttoncolour,
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 1500));
                  isCompletedLoading.value = true;
                  OrderApi().getCompletedOrderData("0").then((value) {
                    completedOrderModel =
                        CompletedOrderModel.fromJson(value.data);
                    isCompletedLoading.value = false;
                  });
                  setState(() {});
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
                        child: Row(
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
                                  log(value);
                                });
                                Get.back();
                              },
                              itemBuilder: (BuildContext bc) {
                                return [
                                  PopupMenuItem(
                                    child: RadioListTile<SingingCharacter>(
                                      title: const Text('All'),
                                      value: SingingCharacter.All,
                                      groupValue: _character,
                                      onChanged: (SingingCharacter? value) {
                                        setState(() {
                                          _character = value;
                                        });
                                        Get.back();
                                        isCompletedLoading.value = true;
                                        OrderApi()
                                            .getCompletedOrderData("0")
                                            .then((value) {
                                          completedOrderModel =
                                              CompletedOrderModel.fromJson(
                                                  value.data);
                                          isCompletedLoading.value = false;
                                        });
                                      },
                                    ),
                                  ),
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
                                        isCompletedLoading.value = true;
                                        OrderApi()
                                            .getCompletedOrderData("1")
                                            .then((value) {
                                          completedOrderModel =
                                              CompletedOrderModel.fromJson(
                                                  value.data);
                                          isCompletedLoading.value = false;
                                        });
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
                                        isCompletedLoading.value = true;
                                        OrderApi()
                                            .getCompletedOrderData("2")
                                            .then((value) {
                                          completedOrderModel =
                                              CompletedOrderModel.fromJson(
                                                  value.data);
                                          isCompletedLoading.value = false;
                                        });
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
                                        isCompletedLoading.value = true;
                                        OrderApi()
                                            .getCompletedOrderData("3")
                                            .then((value) {
                                          completedOrderModel =
                                              CompletedOrderModel.fromJson(
                                                  value.data);
                                          isCompletedLoading.value = false;
                                        });
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
                                        isCompletedLoading.value = true;
                                        OrderApi()
                                            .getCompletedOrderData("4")
                                            .then((value) {
                                          completedOrderModel =
                                              CompletedOrderModel.fromJson(
                                                  value.data);
                                          isCompletedLoading.value = false;
                                        });
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
                                        isCompletedLoading.value = true;
                                        OrderApi()
                                            .getCompletedOrderData("5")
                                            .then((value) {
                                          completedOrderModel =
                                              CompletedOrderModel.fromJson(
                                                  value.data);
                                          isCompletedLoading.value = false;
                                        });
                                      },
                                    ),
                                  ),
                                ];
                              },
                            ),
                          ],
                        ),
                      ),
                      sizedBoxHeight(13.h),
                      Obx(
                        () => isCompletedLoading.value
                            ? Container(
                                margin: EdgeInsets.only(top: Get.height / 3.5),
                                child: const Center(
                                    child: CircularProgressIndicator(
                                  color: AppColors.buttoncolour,
                                )))
                            : SizedBox(
                                height: Get.height / 1.46,
                                width: Get.width,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(23, 5, 23, 0),
                                  child: completedOrderModel.data!.isEmpty
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            LottieBuilder.asset(
                                                "assets/lotties/no_data_found.json"),
                                            textGrey4D4D4D_22(
                                                "No Completed Orders Found !"),
                                          ],
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount:
                                              completedOrderModel.data!.length,
                                          itemBuilder: (_, index) {
                                            return InkWell(
                                              onTap: () {
                                                Get.toNamed("/orderdetails",
                                                    arguments: {
                                                      "id": completedOrderModel
                                                          .data![index]
                                                          .orderHeaderId!,
                                                    });
                                              },
                                              child: SalesOrderMainTile(
                                                completedOrderModel.data![index]
                                                    .getFarmer!.profilePhoto!,
                                                completedOrderModel.data![index]
                                                    .getFarmer!.userName!,
                                                completedOrderModel.data![index]
                                                    .getFarmer!.phoneNumber!,
                                                completedOrderModel
                                                    .data![index].address!,
                                              ),
                                            );
                                          },
                                        ),
                                ),
                              ),
                      ),
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
}

Widget SalesOrderMainTile(
    String image, String name, String number, String location) {
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60), //<-- SEE HERE
                  ),
                  child: image.isEmpty
                      ? Image.asset("assets/images/person.png")
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: CachedNetworkImage(
                            memCacheHeight: 65,
                            maxHeightDiskCache: 65,
                            maxWidthDiskCache: 65,
                            memCacheWidth: 65,
                            imageUrl: "${ApiUrls.baseImageUrl}/$image",
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(
                              color: AppColors.buttoncolour,
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                ),
              ),
              sizedBoxWidth(8.w),
              Column(
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
                      SizedBox(
                        width: Get.width / 1.7,
                        child: Text(
                          location.isEmpty ? "Unknown" : location,
                          // "Canada",
                          maxLines: 3,
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
