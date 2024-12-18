import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_flow_sales/Common/limit_range.dart';
import 'package:farm_flow_sales/Model/inventoriesModel/inventories_model.dart'
    as lotsV;
import 'package:farm_flow_sales/Model/inventoriesModel/inventories_model.dart';
import 'package:farm_flow_sales/Model/inventoriesModel/inventory_details_model.dart'
    as lotsvD;
import 'package:farm_flow_sales/Model/inventoriesModel/inventory_details_model.dart';
import 'package:farm_flow_sales/Model/livestockModel/inventory_livestock_model.dart';
import 'package:farm_flow_sales/Utils/api_urls.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/Utils/texts.dart';
import 'package:farm_flow_sales/controller/inventories_controller.dart';
import 'package:farm_flow_sales/view_models/cartApi/cartApi.dart';
import 'package:farm_flow_sales/view_models/inventoriesApi/inventoriesApi.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'search_item.dart';

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
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    super.initState();
    _analytics.logScreenView(screenName: 'Products_Page');

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      inventoriesController.isApiCalling.value = true;

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
                          _logSearchEvent(value);
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
                    _logFilterEvent(filterList);
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

  void _logSearchEvent(String searchTerm) {
    _analytics.logSearch(searchTerm: searchTerm);
  }

  void _logFilterEvent(List<int> filters) {
    _analytics.logEvent(
      name: 'apply_product_filter',
      parameters: {
        'filter_count': filters.length,
        'filters': filters.toString(),
      },
    );
  }

  void _logProductSelect(InventoriesData product) {
    _analytics.logSelectContent(
      contentType: 'product',
      itemId: product.id.toString(),
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
    bagsQuantity.value = widget.data.lots![0].quantity == null
        ? 0
        : widget.data.lots![0].quantity!;
    counter.value = widget.data.lots![0].prevQuantity!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!inventoriesController.fromWarehouse) {
          // Log product view event
          FirebaseAnalytics.instance.logViewItem(
            items: [
              AnalyticsEventItem(
                itemId: widget.data.id.toString(),
                itemName: widget.txt,
                price: widget.data.lots?[0].price?.toDouble(),
              )
            ],
          );

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
                lotNotOutOfStockData
                    .add((inventoryDetailsModel.data!.lots![j]));
              }
            }

            lotNotOutOfStockData.addAll(lotOutOfStockData);
            inventoryDetailsModel.data!.lots = lotNotOutOfStockData;

            var res = await Get.to(() => SearchItem(
                  data: inventoryDetailsModel,
                ));
            if (res == true) {
              inventoriesController.isApiCalling.value = true;
              await InventoriesApi()
                  .getInventoriesData(
                      "",
                      [],
                      inventoriesController.fromWarehouse
                          ? inventoriesController.wareHouseId
                          : 0)
                  .then((value1) async {
                List<InventoriesData> outOfStockData = [];

                List<InventoriesData> notOutOfStockData = [];
                inventoriesController.inventoriesDataModel.value =
                    InventoriesDataModel.fromJson(value1.data);
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
                            inventoriesController.inventoriesDataModel.value
                                .data![i].lots!.length;
                        j++) {
                      if (!inventoriesController
                          .inventoriesDataModel.value.data![i].lots![j].lotName!
                          .contains("Bulk")) {
                        if (inventoriesController.inventoriesDataModel.value
                                .data![i].lots![j].quantity ==
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
                      inventoriesController.inventoriesDataModel.value.data![i]
                          .lots = lotNotOutOfStockData;
                      outOfStockData.add(inventoriesController
                          .inventoriesDataModel.value.data![i]);
                    } else {
                      lotNotOutOfStockData.addAll(lotOutOfStockData);
                      inventoriesController.inventoriesDataModel.value.data![i]
                          .lots = lotNotOutOfStockData;
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
            }
          });
        }
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                memCacheHeight: 97,
                maxHeightDiskCache: 97,
                maxWidthDiskCache: 85,
                memCacheWidth: 85,
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
                          List<lotsvD.Lots> lotOutOfStockData = [];

                          List<lotsvD.Lots> lotNotOutOfStockData = [];
                          inventoryDetailsModel =
                              InventoryDetailsModel.fromJson(value.data);

                          for (int j = 0;
                              j < inventoryDetailsModel.data!.lots!.length;
                              j++) {
                            if (!inventoryDetailsModel.data!.lots![j].lotName!
                                .contains("Bulk")) {
                              if (inventoryDetailsModel
                                      .data!.lots![j].quantity ==
                                  0) {
                                lotOutOfStockData.add(
                                    (inventoryDetailsModel.data!.lots![j]));
                              } else {
                                lotNotOutOfStockData.add(
                                    (inventoryDetailsModel.data!.lots![j]));
                              }
                            } else {
                              lotNotOutOfStockData
                                  .add((inventoryDetailsModel.data!.lots![j]));
                            }
                          }

                          lotNotOutOfStockData.addAll(lotOutOfStockData);
                          inventoryDetailsModel.data!.lots =
                              lotNotOutOfStockData;

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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            inventoriesController.fromWarehouse
                                ? bagsQuantity.value <= 0
                                    ? const SizedBox()
                                    : bagText.value.contains("Bulk")
                                        ? const SizedBox()
                                        : Text(
                                            "Quantity : ${bagsQuantity.value}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 16.sp,
                                                color: const Color(0xff0E5F02),
                                                fontWeight: FontWeight.w500),
                                          )
                                : ((widget.data.lots![selectedBag.value]
                                                .lotName!
                                                .contains("Small Bag") ||
                                            widget.data.lots![selectedBag.value]
                                                .lotName!
                                                .contains("Big Bag")) &&
                                        widget.data.lots![selectedBag.value]
                                                .quantity ==
                                            0)
                                    ? const Text("Out of stock")
                                    : Row(
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (counter.value >
                                                      widget.minValue) {
                                                    counter.value--;

                                                    // Log remove from cart event
                                                    FirebaseAnalytics.instance
                                                        .logRemoveFromCart(
                                                      items: [
                                                        AnalyticsEventItem(
                                                          itemId: widget
                                                              .data
                                                              .lots![selectedBag
                                                                  .value]
                                                              .itemMasterXid
                                                              .toString(),
                                                          itemName: widget.txt,
                                                          itemVariant:
                                                              bagText.value,
                                                          price: price.value
                                                              .toDouble(),
                                                          quantity: 1,
                                                        )
                                                      ],
                                                      value: price.value
                                                          .toDouble(),
                                                      currency: 'EUR',
                                                    );

                                                    CartApi()
                                                        .manageCartData(
                                                            widget
                                                                .data
                                                                .lots![
                                                                    selectedBag
                                                                        .value]
                                                                .itemMasterXid!,
                                                            counter.value)
                                                        .then((value) {
                                                      Map<String, dynamic>
                                                          responseData = Map<
                                                                  String,
                                                                  dynamic>.from(
                                                              value.data);
                                                      utils.showToast(
                                                          responseData[
                                                              "message"]);
                                                    });
                                                  }
                                                });
                                              },
                                              child: SvgPicture.asset(
                                                "assets/images/minusbutton.svg",
                                                width: 20.w,
                                              )),
                                          sizedBoxWidth(12.w),
                                          textblack14M('${counter.value}'),
                                          sizedBoxWidth(8.w),
                                          GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (bagText
                                                      .contains("Bulk")) {
                                                    counter.value++;

                                                    // Log add to cart event
                                                    FirebaseAnalytics.instance
                                                        .logAddToCart(
                                                            items: [
                                                          AnalyticsEventItem(
                                                            itemId: widget
                                                                .data
                                                                .lots![
                                                                    selectedBag
                                                                        .value]
                                                                .itemMasterXid
                                                                .toString(),
                                                            itemName:
                                                                widget.txt,
                                                            itemVariant:
                                                                bagText.value,
                                                            price: price.value
                                                                .toDouble(),
                                                            quantity: 1,
                                                          )
                                                        ],
                                                            value: price.value
                                                                .toDouble(),
                                                            currency: "EUR");

                                                    CartApi()
                                                        .manageCartData(
                                                            widget
                                                                .data
                                                                .lots![
                                                                    selectedBag
                                                                        .value]
                                                                .itemMasterXid!,
                                                            counter.value)
                                                        .then((value) {
                                                      Map<String, dynamic>
                                                          responseData = Map<
                                                                  String,
                                                                  dynamic>.from(
                                                              value.data);

                                                      utils.showToast(
                                                          responseData[
                                                              "message"]);
                                                    });
                                                  } else {
                                                    if (counter.value <
                                                        bagsQuantity.value) {
                                                      counter.value++;

                                                      // Log add to cart event
                                                      FirebaseAnalytics.instance
                                                          .logAddToCart(
                                                        items: [
                                                          AnalyticsEventItem(
                                                            itemId: widget
                                                                .data
                                                                .lots![
                                                                    selectedBag
                                                                        .value]
                                                                .itemMasterXid
                                                                .toString(),
                                                            itemName:
                                                                widget.txt,
                                                            itemVariant:
                                                                bagText.value,
                                                            price: price.value
                                                                .toDouble(),
                                                            quantity: 1,
                                                          )
                                                        ],
                                                        value: price.value
                                                            .toDouble(),
                                                        currency: 'EUR',
                                                      );

                                                      CartApi()
                                                          .manageCartData(
                                                              widget
                                                                  .data
                                                                  .lots![
                                                                      selectedBag
                                                                          .value]
                                                                  .itemMasterXid!,
                                                              counter.value)
                                                          .then((value) {
                                                        Map<String, dynamic>
                                                            responseData = Map<
                                                                    String,
                                                                    dynamic>.from(
                                                                value.data);

                                                        utils.showToast(
                                                            responseData[
                                                                "message"]);
                                                      });
                                                    }
                                                  }
                                                });
                                              },
                                              child: SvgPicture.asset(
                                                "assets/images/plusreorder.svg",
                                                width: 20.w,
                                              )),
                                        ],
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
                inventoriesController.fromWarehouse
                    ? quantity == 0
                        ? const SizedBox()
                        : bagText.value.contains("Bulk")
                            ? const SizedBox()
                            : Text(
                                "Quantity : $quantity",
                                style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    color: const Color(0xff0E5F02),
                                    fontWeight: FontWeight.w500),
                              )
                    : ((bag.contains("Small Bag") || bag.contains("Big Bag")) &&
                            quantity == 0)
                        ? const Text("Out of stock")
                        : Obx(
                            () => Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (counterValue.value >
                                            widget.minValue) {
                                          if (selectedBag.value == index) {
                                            counter--;
                                          }
                                          counterValue.value--;

                                          // Log remove from cart event
                                          FirebaseAnalytics.instance
                                              .logRemoveFromCart(
                                            items: [
                                              AnalyticsEventItem(
                                                itemId: id.toString(),
                                                itemName: widget.txt,
                                                itemVariant: bag,
                                                price: amount.toDouble(),
                                                quantity: 1,
                                              )
                                            ],
                                            value: amount.toDouble(),
                                            currency: 'EUR',
                                          );

                                          CartApi()
                                              .manageCartData(
                                                  id, counterValue.value)
                                              .then((value) {
                                            Map<String, dynamic> responseData =
                                                Map<String, dynamic>.from(
                                                    value.data);

                                            utils.showToast(
                                                responseData["message"]);
                                          });
                                        }
                                      });
                                    },
                                    child: SvgPicture.asset(
                                        "assets/images/minusbutton.svg")),
                                sizedBoxWidth(12.w),
                                textblack14M('${counterValue.value}'),
                                sizedBoxWidth(8.w),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (bag.contains("Bulk")) {
                                          if (selectedBag.value == index) {
                                            counter++;
                                          }
                                          counterValue.value++;

                                          // Log add to cart event
                                          FirebaseAnalytics.instance
                                              .logAddToCart(
                                            items: [
                                              AnalyticsEventItem(
                                                itemId: id.toString(),
                                                itemName: widget.txt,
                                                itemVariant: bag,
                                                price: amount.toDouble(),
                                                quantity: 1,
                                              )
                                            ],
                                            value: amount.toDouble(),
                                            currency: 'EUR',
                                          );

                                          CartApi()
                                              .manageCartData(
                                                  id, counterValue.value)
                                              .then((value) {
                                            Map<String, dynamic> responseData =
                                                Map<String, dynamic>.from(
                                                    value.data);

                                            utils.showToast(
                                                responseData["message"]);
                                          });
                                        } else {
                                          if (counterValue.value < quantity) {
                                            if (selectedBag.value == index) {
                                              counter++;
                                            }
                                            counterValue.value++;

                                            // Log add to cart event
                                            FirebaseAnalytics.instance
                                                .logAddToCart(
                                              items: [
                                                AnalyticsEventItem(
                                                  itemId: id.toString(),
                                                  itemName: widget.txt,
                                                  itemVariant: bag,
                                                  price: amount.toDouble(),
                                                  quantity: 1,
                                                )
                                              ],
                                              value: amount.toDouble(),
                                              currency: 'EUR',
                                            );

                                            CartApi()
                                                .manageCartData(
                                                    id, counterValue.value)
                                                .then((value) {
                                              Map<String, dynamic>
                                                  responseData =
                                                  Map<String, dynamic>.from(
                                                      value.data);

                                              utils.showToast(
                                                  responseData["message"]);
                                            });
                                          }
                                        }
                                      });
                                    },
                                    child: SvgPicture.asset(
                                        "assets/images/plusreorder.svg")),
                              ],
                            ),
                          )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
