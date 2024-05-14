import 'dart:developer';
import 'package:farm_flow_sales/Model/inventoriesModel/inventories_model.dart';
import 'package:farm_flow_sales/Model/inventoriesModel/inventory_details_model.dart';
import 'package:farm_flow_sales/Model/livestockModel/inventory_livestock_model.dart';
import 'package:farm_flow_sales/Utils/api_urls.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/Utils/texts.dart';
import 'package:farm_flow_sales/controller/inventories_controller.dart';
import 'package:farm_flow_sales/view_models/inventoriesApi/inventoriesApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'search_item.dart';
import 'package:farm_flow_sales/Model/inventoriesModel/inventories_model.dart'
    as lotsV;
import 'package:farm_flow_sales/Model/inventoriesModel/inventory_details_model.dart'
    as lotsvD;

class Productspage extends StatefulWidget {
  const Productspage({Key? key}) : super(key: key);

  @override
  State<Productspage> createState() => ProductspageState();
}

class ProductspageState extends State<Productspage> {
  InventoriesController inventoriesController =
      Get.put(InventoriesController());
  TextEditingController searchController = TextEditingController();
  List<int> filterList = [];
  InventoryLivestockModel inventoryLivestockModel = InventoryLivestockModel();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (inventoriesController.isProductFirst) {
        inventoriesController.isApiCalling.value = true;
      }

      await InventoriesApi().getFeedLivestockApi().then((value) {
        inventoryLivestockModel = InventoryLivestockModel.fromJson(value.data);
      });
      List<InventoriesData> outOfStockData = [];
      List<InventoriesData> notOutOfStockData = [];

      await InventoriesApi().getInventoriesData("", [], 0).then((value1) async {
        inventoriesController.inventoriesDataModel.value =
            InventoriesDataModel.fromJson(value1.data);

        Future.delayed(const Duration(seconds: 1), () {
          for (int i = 0;
              i < inventoriesController.inventoriesDataModel.value.data!.length;
              i++) {
            int outOfStockNo = 0;

            List<lotsV.Lots> lotOutOfStockData = [];

            List<lotsV.Lots> lotNotOutOfStockData = [];
            for (int j = 0;
                j <
                    inventoriesController
                        .inventoriesDataModel.value.data![i].lots!.length;
                j++) {
              if (!inventoriesController
                  .inventoriesDataModel.value.data![i].lots![j].lotName!
                  .contains("Bulk")) {
                if (inventoriesController.inventoriesDataModel.value.data![i]
                        .lots![j].quantity ==
                    0) {
                  lotOutOfStockData.add((inventoriesController
                      .inventoriesDataModel.value.data![i].lots![j]));
                  outOfStockNo += 1;
                } else {
                  lotNotOutOfStockData.add((inventoriesController
                      .inventoriesDataModel.value.data![i].lots![j]));
                }
              } else {
                lotNotOutOfStockData.add((inventoriesController
                    .inventoriesDataModel.value.data![i].lots![j]));
              }
            }

            if (outOfStockNo ==
                inventoriesController
                    .inventoriesDataModel.value.data![i].lots!.length) {
              lotNotOutOfStockData.addAll(lotOutOfStockData);
              inventoriesController.inventoriesDataModel.value.data![i].lots =
                  lotNotOutOfStockData;
              outOfStockData.add(
                  inventoriesController.inventoriesDataModel.value.data![i]);
            } else {
              lotNotOutOfStockData.addAll(lotOutOfStockData);
              inventoriesController.inventoriesDataModel.value.data![i].lots =
                  lotNotOutOfStockData;
              notOutOfStockData.add(
                  inventoriesController.inventoriesDataModel.value.data![i]);
            }
          }
          notOutOfStockData.addAll(outOfStockData);
          inventoriesController.inventoriesDataModel.value.data =
              notOutOfStockData;
        });
        Future.delayed(const Duration(seconds: 1), () {
          inventoriesController.isProductFirst = false;
          inventoriesController.isApiCalling.value = false;
        });
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: CupertinoSearchTextField(
                      controller: searchController,
                      onChanged: (value) async {
                        if (value.length >= 3) {
                          List<InventoriesData> outOfStockData = [];
                          List<InventoriesData> notOutOfStockData = [];
                          inventoriesController.isApiCalling.value = true;
                          await InventoriesApi()
                              .getInventoriesData(
                                  searchController.text.toLowerCase(),
                                  filterList,
                                  0)
                              .then((value) {
                            inventoriesController.inventoriesDataModel.value =
                                InventoriesDataModel.fromJson(value.data);
                            Future.delayed(const Duration(seconds: 1), () {
                              for (int i = 0;
                                  i <
                                      inventoriesController.inventoriesDataModel
                                          .value.data!.length;
                                  i++) {
                                int outOfStockNo = 0;

                                List<lotsV.Lots> lotOutOfStockData = [];

                                List<lotsV.Lots> lotNotOutOfStockData = [];
                                for (int j = 0;
                                    j <
                                        inventoriesController
                                            .inventoriesDataModel
                                            .value
                                            .data![i]
                                            .lots!
                                            .length;
                                    j++) {
                                  if (!inventoriesController
                                      .inventoriesDataModel
                                      .value
                                      .data![i]
                                      .lots![j]
                                      .lotName!
                                      .contains("Bulk")) {
                                    if (inventoriesController
                                            .inventoriesDataModel
                                            .value
                                            .data![i]
                                            .lots![j]
                                            .quantity ==
                                        0) {
                                      lotOutOfStockData.add(
                                          (inventoriesController
                                              .inventoriesDataModel
                                              .value
                                              .data![i]
                                              .lots![j]));
                                      outOfStockNo += 1;
                                    } else {
                                      lotNotOutOfStockData.add(
                                          (inventoriesController
                                              .inventoriesDataModel
                                              .value
                                              .data![i]
                                              .lots![j]));
                                    }
                                  } else {
                                    lotNotOutOfStockData.add(
                                        (inventoriesController
                                            .inventoriesDataModel
                                            .value
                                            .data![i]
                                            .lots![j]));
                                  }
                                }

                                if (outOfStockNo ==
                                    inventoriesController.inventoriesDataModel
                                        .value.data![i].lots!.length) {
                                  lotNotOutOfStockData
                                      .addAll(lotOutOfStockData);
                                  inventoriesController
                                      .inventoriesDataModel
                                      .value
                                      .data![i]
                                      .lots = lotNotOutOfStockData;
                                  outOfStockData.add(inventoriesController
                                      .inventoriesDataModel.value.data![i]);
                                } else {
                                  lotNotOutOfStockData
                                      .addAll(lotOutOfStockData);
                                  inventoriesController
                                      .inventoriesDataModel
                                      .value
                                      .data![i]
                                      .lots = lotNotOutOfStockData;
                                  notOutOfStockData.add(inventoriesController
                                      .inventoriesDataModel.value.data![i]);
                                }
                              }
                              notOutOfStockData.addAll(outOfStockData);
                              inventoriesController.inventoriesDataModel.value
                                  .data = notOutOfStockData;
                            });

                            Future.delayed(const Duration(seconds: 1), () {
                              inventoriesController.isApiCalling.value = false;
                            });
                          });
                        } else if (value.isEmpty) {
                          List<InventoriesData> outOfStockData = [];
                          List<InventoriesData> notOutOfStockData = [];
                          inventoriesController.isApiCalling.value = true;
                          await InventoriesApi()
                              .getInventoriesData(
                                  searchController.text, filterList, 0)
                              .then((value) {
                            inventoriesController.inventoriesDataModel.value =
                                InventoriesDataModel.fromJson(value.data);
                            Future.delayed(const Duration(seconds: 1), () {
                              for (int i = 0;
                                  i <
                                      inventoriesController.inventoriesDataModel
                                          .value.data!.length;
                                  i++) {
                                int outOfStockNo = 0;

                                List<lotsV.Lots> lotOutOfStockData = [];

                                List<lotsV.Lots> lotNotOutOfStockData = [];
                                for (int j = 0;
                                    j <
                                        inventoriesController
                                            .inventoriesDataModel
                                            .value
                                            .data![i]
                                            .lots!
                                            .length;
                                    j++) {
                                  if (!inventoriesController
                                      .inventoriesDataModel
                                      .value
                                      .data![i]
                                      .lots![j]
                                      .lotName!
                                      .contains("Bulk")) {
                                    if (inventoriesController
                                            .inventoriesDataModel
                                            .value
                                            .data![i]
                                            .lots![j]
                                            .quantity ==
                                        0) {
                                      lotOutOfStockData.add(
                                          (inventoriesController
                                              .inventoriesDataModel
                                              .value
                                              .data![i]
                                              .lots![j]));
                                      outOfStockNo += 1;
                                    } else {
                                      lotNotOutOfStockData.add(
                                          (inventoriesController
                                              .inventoriesDataModel
                                              .value
                                              .data![i]
                                              .lots![j]));
                                    }
                                  } else {
                                    lotNotOutOfStockData.add(
                                        (inventoriesController
                                            .inventoriesDataModel
                                            .value
                                            .data![i]
                                            .lots![j]));
                                  }
                                }

                                if (outOfStockNo ==
                                    inventoriesController.inventoriesDataModel
                                        .value.data![i].lots!.length) {
                                  lotNotOutOfStockData
                                      .addAll(lotOutOfStockData);
                                  inventoriesController
                                      .inventoriesDataModel
                                      .value
                                      .data![i]
                                      .lots = lotNotOutOfStockData;
                                  outOfStockData.add(inventoriesController
                                      .inventoriesDataModel.value.data![i]);
                                } else {
                                  lotNotOutOfStockData
                                      .addAll(lotOutOfStockData);
                                  inventoriesController
                                      .inventoriesDataModel
                                      .value
                                      .data![i]
                                      .lots = lotNotOutOfStockData;
                                  notOutOfStockData.add(inventoriesController
                                      .inventoriesDataModel.value.data![i]);
                                }
                              }
                              notOutOfStockData.addAll(outOfStockData);
                              inventoriesController.inventoriesDataModel.value
                                  .data = notOutOfStockData;
                            });

                            Future.delayed(const Duration(seconds: 1), () {
                              inventoriesController.isApiCalling.value = false;
                            });
                          });
                        }
                      },
                      prefixInsets:
                          EdgeInsetsDirectional.fromSTEB(15.w, 0, 0, 0),
                      prefixIcon: const Icon(
                        CupertinoIcons.search,
                        color: Colors.black,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.buttoncolour)),
                    )),
                    filter()
                  ],
                ),
              ),
              sizedBoxHeight(20.h),
              Obx(() => inventoriesController.isApiCalling.value
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Gap(Get.height / 2.7),
                        const Align(
                            alignment: Alignment.bottomCenter,
                            child: CircularProgressIndicator(
                              color: AppColors.buttoncolour,
                            )),
                      ],
                    )
                  : inventoriesController
                          .inventoriesDataModel.value.data!.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LottieBuilder.asset(
                                "assets/lotties/no_data_found.json"),
                            textGrey4D4D4D_22("No Product Found !"),
                          ],
                        )
                      : Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Products",
                                style: TextStyle(
                                  color: const Color(0XFF141414),
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              sizedBoxHeight(18.h),
                              Expanded(
                                child: ListView.builder(
                                    itemCount: inventoriesController
                                        .inventoriesDataModel
                                        .value
                                        .data!
                                        .length,
                                    itemBuilder: (ctx, index) {
                                      return ProductContainer(
                                        txt: inventoriesController
                                            .inventoriesDataModel
                                            .value
                                            .data![index]
                                            .title!,
                                        png: inventoriesController
                                            .inventoriesDataModel
                                            .value
                                            .data![index]
                                            .smallImageUrl!,
                                        data: inventoriesController
                                            .inventoriesDataModel
                                            .value
                                            .data![index],
                                        maxValue: inventoriesController
                                            .inventoriesDataModel
                                            .value
                                            .data![index]
                                            .lots![0]
                                            .quantity!,
                                      );
                                    }),
                              )
                            ],
                          ),
                        ))
            ],
          ),
        ),
      ),
    );
  }

  Widget filter() {
    return PopupMenuButton(
      icon: SvgPicture.asset('assets/images/filter.svg'),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height:
                    (Get.height * inventoryLivestockModel.data!.length) / 17,
                width: 200,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: inventoryLivestockModel.data!.length,
                    itemBuilder: (ctx, index) {
                      return index == 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  itemFilter(index),
                                  GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: const Icon(Icons.cancel_outlined))
                                ])
                          : itemFilter(index);
                    }),
              ),
              GestureDetector(
                  onTap: () async {
                    List<InventoriesData> outOfStockData = [];

                    List<InventoriesData> notOutOfStockData = [];

                    inventoriesController.isApiCalling.value = true;
                    Get.back();
                    await InventoriesApi()
                        .getInventoriesData(
                            searchController.text, filterList, 0)
                        .then((value) async {
                      inventoriesController.inventoriesDataModel.value =
                          InventoriesDataModel.fromJson(value.data);
                      Future.delayed(const Duration(seconds: 1), () {
                        for (int i = 0;
                            i <
                                inventoriesController
                                    .inventoriesDataModel.value.data!.length;
                            i++) {
                          int outOfStockNo = 0;

                          List<lotsV.Lots> lotOutOfStockData = [];

                          List<lotsV.Lots> lotNotOutOfStockData = [];
                          for (int j = 0;
                              j <
                                  inventoriesController.inventoriesDataModel
                                      .value.data![i].lots!.length;
                              j++) {
                            if (!inventoriesController.inventoriesDataModel
                                .value.data![i].lots![j].lotName!
                                .contains("Bulk")) {
                              if (inventoriesController.inventoriesDataModel
                                      .value.data![i].lots![j].quantity ==
                                  0) {
                                lotOutOfStockData.add((inventoriesController
                                    .inventoriesDataModel
                                    .value
                                    .data![i]
                                    .lots![j]));
                                outOfStockNo += 1;
                              } else {
                                lotNotOutOfStockData.add((inventoriesController
                                    .inventoriesDataModel
                                    .value
                                    .data![i]
                                    .lots![j]));
                              }
                            } else {
                              lotNotOutOfStockData.add((inventoriesController
                                  .inventoriesDataModel
                                  .value
                                  .data![i]
                                  .lots![j]));
                            }
                          }

                          if (outOfStockNo ==
                              inventoriesController.inventoriesDataModel.value
                                  .data![i].lots!.length) {
                            lotNotOutOfStockData.addAll(lotOutOfStockData);
                            inventoriesController.inventoriesDataModel.value
                                .data![i].lots = lotNotOutOfStockData;
                            outOfStockData.add(inventoriesController
                                .inventoriesDataModel.value.data![i]);
                          } else {
                            lotNotOutOfStockData.addAll(lotOutOfStockData);
                            inventoriesController.inventoriesDataModel.value
                                .data![i].lots = lotNotOutOfStockData;
                            notOutOfStockData.add(inventoriesController
                                .inventoriesDataModel.value.data![i]);
                          }
                        }
                        notOutOfStockData.addAll(outOfStockData);
                        inventoriesController.inventoriesDataModel.value.data =
                            notOutOfStockData;
                      });
                      Future.delayed(const Duration(seconds: 1), () {
                        inventoriesController.isApiCalling.value = false;
                      });
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 25.h),
                    decoration: BoxDecoration(
                        color: AppColors.buttoncolour,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(child: textWhite16('Apply Now')),
                  ))
            ],
          ))
        ];
      },
    );
  }

  Widget itemFilter(int index) {
    RxBool filter = false.obs;
    if (filterList.contains(inventoryLivestockModel.data![index].id!)) {
      filter.value = true;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Obx(
          () => Checkbox(
            activeColor: AppColors.buttoncolour,
            value: filter.value,
            onChanged: (value) {
              filter.value = !filter.value;
              if (value!) {
                filterList.add(inventoryLivestockModel.data![index].id!);
              } else {
                filterList.remove(inventoryLivestockModel.data![index].id!);
              }
              log(filterList.toString());
            },
          ),
        ),
        CachedNetworkImage(
          memCacheHeight: 24,
          maxHeightDiskCache: 40,
          maxWidthDiskCache: 24,
          memCacheWidth: 40,
          imageUrl:
              '${ApiUrls.baseImageUrl}/${inventoryLivestockModel.data![index].smallImageUrl}',
          placeholder: (context, url) => const CircularProgressIndicator(
            color: AppColors.buttoncolour,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        sizedBoxWidth(5.w),
        textblack14M(inventoryLivestockModel.data![index].name!),
      ],
    );
  }
}

class ProductContainer extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final String txt;
  final String png;
  final InventoriesData data;
  const ProductContainer({
    super.key,
    this.minValue = 0,
    this.maxValue = 9,
    required this.txt,
    required this.png,
    required this.data,
  });

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  RxInt counter = 0.obs;
  RxInt bagsQuantity = 0.obs;
  RxString bagText = ''.obs;
  RxInt price = 0.obs;
  RxInt selectedBag = 0.obs;
  InventoryDetailsModel inventoryDetailsModel = InventoryDetailsModel();
  InventoriesController inventoriesController =
      Get.put(InventoriesController());

  @override
  void initState() {
    price.value = widget.data.lots![0].price!;
    bagText.value = widget.data.lots![0].lotName!;
    bagsQuantity.value = widget.data.lots![0].quantity!;
    counter.value = widget.data.lots![0].prevQuantity!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        InventoriesApi()
            .getInventoryDetailData(widget.data.id.toString())
            .then((value) async {
          InventoryDetailsModel inventoryDetailsModel =
              InventoryDetailsModel.fromJson(value.data);

          List<lotsvD.Lots> lotOutOfStockData = [];

          List<lotsvD.Lots> lotNotOutOfStockData = [];
          for (int j = 0; j < inventoryDetailsModel.data!.lots!.length; j++) {
            if (!inventoryDetailsModel.data!.lots![j].lotName!
                .contains("Bulk")) {
              if (inventoryDetailsModel.data!.lots![j].quantity == 0) {
                lotOutOfStockData.add((inventoryDetailsModel.data!.lots![j]));
              } else {
                lotNotOutOfStockData
                    .add((inventoryDetailsModel.data!.lots![j]));
              }
            } else {
              lotNotOutOfStockData.add((inventoryDetailsModel.data!.lots![j]));
            }
          }

          lotNotOutOfStockData.addAll(lotOutOfStockData);
          inventoryDetailsModel.data!.lots = lotNotOutOfStockData;

          Get.to(() => SearchItem(
                data: inventoryDetailsModel,
              ));
        });
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffF1F1F1),
            boxShadow: [
              BoxShadow(
                  color: Color(0x0000001F),
                  offset: Offset(0.0, 0.75),
                  spreadRadius: 2)
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                memCacheWidth: 80,
                memCacheHeight: 97,
                maxHeightDiskCache: 97,
                maxWidthDiskCache: 80,
                imageUrl: "${ApiUrls.baseImageUrl}/${widget.png}",
                placeholder: (context, url) => const CircularProgressIndicator(
                  color: AppColors.buttoncolour,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              sizedBoxWidth(26.w),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textBlack18W5000(widget.txt),
                    sizedBoxHeight(10.h),
                    GestureDetector(
                      onTap: () {
                        InventoriesApi()
                            .getInventoryDetailData(widget.data.id.toString())
                            .then((value) {
                          inventoryDetailsModel =
                              InventoryDetailsModel.fromJson(value.data);
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return bottomSheetContainer();
                            },
                          );
                        });
                      },
                      child: Container(
                        width: 155.w,
                        padding: EdgeInsets.symmetric(
                            vertical: 3.h, horizontal: 8.w),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.buttoncolour, width: 1.h),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => textGreen14(' ${bagText.value}'),
                            ),
                            RotatedBox(
                                quarterTurns: 3,
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 14.h,
                                  color: AppColors.buttoncolour,
                                ))
                          ],
                        ),
                      ),
                    ),
                    sizedBoxHeight(10.h),
                    Obx(
                      () => Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            textBlack18W700Center('€ ${price.value}'),
                            bagsQuantity.value == 0
                                ? ((bagText.value.contains("Small Bag") ||
                                            bagText.value
                                                .contains("Big Bag")) &&
                                        bagsQuantity.value == 0)
                                    ? const Text("Out of stock")
                                    : SizedBox()
                                : Text(
                                    "Quantity : ${bagsQuantity.value}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        color: const Color(0xff0E5F02),
                                        fontWeight: FontWeight.w500),
                                  )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSheetContainer() {
    return Container(
      // height: 600.h,
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 20.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              radius: 15.h,
              backgroundColor: const Color(0XFFF1F1F1),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Icon(Icons.arrow_back_ios,
                      size: 18.h, color: const Color(0XFF141414)),
                ),
              ),
            ),
          ),
          sizedBoxHeight(5.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 8.h),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xff707070)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      memCacheHeight: 97,
                      maxHeightDiskCache: 97,
                      maxWidthDiskCache: 85,
                      memCacheWidth: 85,
                      imageUrl: "${ApiUrls.baseImageUrl}/${widget.png}",
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(
                        color: AppColors.buttoncolour,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    sizedBoxWidth(26.w),
                    Flexible(
                      child: textBlack18W5000(widget.txt),
                    ),
                  ],
                ),
                sizedBoxHeight(10.h),
                SizedBox(
                  height: 320,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.data.lots!.length,
                      itemBuilder: (ctx, index) {
                        return Container(
                            margin: EdgeInsets.only(bottom: 10.h),
                            child: insideDetContainer(
                              index,
                              widget.data.lots![index].quantity == null
                                  ? 0
                                  : widget.data.lots![index].quantity!,
                              widget.data.lots![index].price!,
                              widget.data.lots![index].lotName!,
                              inventoryDetailsModel
                                  .data!.lots![index].prevQuantity!,
                              inventoryDetailsModel
                                  .data!.lots![index].itemMasterLotXid!,
                            ));
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget insideDetContainer(
    int index,
    int quantity,
    int amount,
    String bag,
    int prevQuantity,
    id,
  ) {
    RxInt counterValue = prevQuantity.obs;
    return GestureDetector(
      onTap: () {
        bagText.value = bag;
        price.value = amount;
        bagsQuantity.value = quantity;
        selectedBag.value = index;
        counter.value = counterValue.value;
        Get.back();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(9.w, 9.h, 16.w, 20.h),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.buttoncolour, width: 1.h),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textGreen14(bag),
            sizedBoxHeight(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                textBlack18W700Center('€ $amount'),
                ((bag.contains("Small Bag") || bag.contains("Big Bag")) &&
                        quantity == 0)
                    ? const Text("Out of stock")
                    : quantity == 0
                        ? const SizedBox()
                        : Text(
                            "Quantity : $quantity",
                            style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                color: const Color(0xff0E5F02),
                                fontWeight: FontWeight.w500),
                          )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
