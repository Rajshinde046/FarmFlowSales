import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_flow_sales/Common/limit_range.dart';
import 'package:farm_flow_sales/Model/cartModel/cartModel.dart';
import 'package:farm_flow_sales/Model/inventoriesModel/inventories_model.dart';
import 'package:farm_flow_sales/Model/inventoriesModel/inventory_details_model.dart';
import 'package:farm_flow_sales/Model/livestockModel/inventory_livestock_model.dart';
import 'package:farm_flow_sales/Utils/api_urls.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/Utils/texts.dart';
import 'package:farm_flow_sales/controller/inventories_controller.dart';
import 'package:farm_flow_sales/view_models/cartApi/cartApi.dart';
import 'package:farm_flow_sales/view_models/inventoriesApi/inventoriesApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'search_item.dart';

class SearchProductCategories extends StatefulWidget {
  const SearchProductCategories({Key? key}) : super(key: key);

  @override
  State<SearchProductCategories> createState() =>
      _SearchProductCategoriesState();
}

class _SearchProductCategoriesState extends State<SearchProductCategories> {
  InventoriesController inventoriesController =
      Get.put(InventoriesController());
  TextEditingController searchController = TextEditingController();
  List<int> filterList = [];
  InventoryLivestockModel inventoryLivestockModel = InventoryLivestockModel();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      inventoriesController.isApiCalling.value = true;
      await InventoriesApi()
          .getInventoriesData(
              "",
              [],
              inventoriesController.fromWarehouse
                  ? inventoriesController.wareHouseId
                  : 0)
          .then((value1) async {
        inventoriesController.inventoriesDataModel.value =
            InventoriesDataModel.fromJson(value1.data);
        await InventoriesApi().getFeedLivestockApi().then((value) {
          inventoryLivestockModel =
              InventoryLivestockModel.fromJson(value.data);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: inventoriesController.fromWarehouse
          ? const SizedBox()
          : SizedBox(
              width: 100.w,
              height: 50.h,
              child: FloatingActionButton(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                  backgroundColor: AppColors.buttoncolour,
                  onPressed: () {
                    CartApi().getViewCartData().then((value) {
                      inventoriesController.viewCartModel.value =
                          ViewCartModel.fromJson(value.data);

                      Get.toNamed('/sideMenu', arguments: 3);
                    });
                  },
                  tooltip: 'View Cart',
                  child: Text(
                    "View Cart",
                    style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white),
                  )),
            ),
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
                    sizedBoxWidth(10.w),
                    Expanded(
                        child: CupertinoSearchTextField(
                      controller: searchController,
                      onChanged: (value) async {
                        if (value.length >= 3) {
                          inventoriesController.isApiCalling.value = true;
                          await InventoriesApi()
                              .getInventoriesData(
                                  searchController.text,
                                  filterList,
                                  inventoriesController.fromWarehouse
                                      ? inventoriesController.wareHouseId
                                      : 0)
                              .then((value) {
                            inventoriesController.inventoriesDataModel.value =
                                InventoriesDataModel.fromJson(value.data);
                            inventoriesController.isApiCalling.value = false;
                          });
                        } else if (value.isEmpty) {
                          inventoriesController.isApiCalling.value = true;
                          await InventoriesApi()
                              .getInventoriesData(
                                  searchController.text,
                                  filterList,
                                  inventoriesController.fromWarehouse
                                      ? inventoriesController.wareHouseId
                                      : 0)
                              .then((value) {
                            inventoriesController.inventoriesDataModel.value =
                                InventoriesDataModel.fromJson(value.data);
                            inventoriesController.isApiCalling.value = false;
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
                                "Product Categories",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: const Color(0XFF141414),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins"),
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
                    inventoriesController.isApiCalling.value = true;
                    Get.back();
                    await InventoriesApi()
                        .getInventoriesData(
                            searchController.text,
                            filterList,
                            inventoriesController.fromWarehouse
                                ? inventoriesController.wareHouseId
                                : 0)
                        .then((value) async {
                      inventoriesController.inventoriesDataModel.value =
                          InventoriesDataModel.fromJson(value.data);

                      inventoriesController.isApiCalling.value = false;
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
          memCacheWidth: 40,
          memCacheHeight: 24,
          maxHeightDiskCache: 40,
          maxWidthDiskCache: 24,
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
        if (!inventoriesController.fromWarehouse) {
          InventoriesApi()
              .getInventoryDetailData(widget.data.id.toString())
              .then((value) async {
            var res = await Get.to(() => SearchItem(
                  data: InventoryDetailsModel.fromJson(value.data),
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
                inventoriesController.inventoriesDataModel.value =
                    InventoriesDataModel.fromJson(value1.data);
                inventoriesController.isApiCalling.value = false;
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
                        width: 110.w,
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
                            inventoriesController.fromWarehouse
                                ? Text(
                                    "Quantity : ${bagsQuantity.value}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        color: const Color(0xff0E5F02),
                                        fontWeight: FontWeight.w500),
                                  )
                                : Row(
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (counter.value >
                                                  widget.minValue) {
                                                counter.value--;
                                                CartApi()
                                                    .manageCartData(
                                                        widget
                                                            .data
                                                            .lots![selectedBag
                                                                .value]
                                                            .itemMasterXid!,
                                                        counter.value)
                                                    .then((value) {
                                                  Map<String, dynamic>
                                                      responseData =
                                                      Map<String, dynamic>.from(
                                                          value.data);
                                                  utils.showToast(
                                                      responseData["message"]);
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
                                              if (counter.value <
                                                  bagsQuantity.value) {
                                                counter.value++;

                                                CartApi()
                                                    .manageCartData(
                                                        widget
                                                            .data
                                                            .lots![selectedBag
                                                                .value]
                                                            .itemMasterXid!,
                                                        counter.value)
                                                    .then((value) {
                                                  Map<String, dynamic>
                                                      responseData =
                                                      Map<String, dynamic>.from(
                                                          value.data);

                                                  utils.showToast(
                                                      responseData["message"]);
                                                });
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
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.data.lots!.length,
                    itemBuilder: (ctx, index) {
                      return Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          child: insideDetContainer(
                            index,
                            widget.data.lots![index].quantity!,
                            widget.data.lots![index].price!,
                            widget.data.lots![index].lotName!,
                            inventoryDetailsModel
                                .data!.lots![index].prevQuantity!,
                            inventoryDetailsModel
                                .data!.lots![index].itemMasterLotXid!,
                          ));
                    }),
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
                    ? Text(
                        "Quantity : $quantity",
                        style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            color: const Color(0xff0E5F02),
                            fontWeight: FontWeight.w500),
                      )
                    : Obx(
                        () => Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (counterValue.value > widget.minValue) {
                                      if (selectedBag.value == index) {
                                        counter--;
                                      }
                                      counterValue.value--;
                                      CartApi()
                                          .manageCartData(
                                              id, counterValue.value)
                                          .then((value) {
                                        Map<String, dynamic> responseData =
                                            Map<String, dynamic>.from(
                                                value.data);

                                        utils
                                            .showToast(responseData["message"]);
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
                                    if (counterValue.value < quantity) {
                                      if (selectedBag.value == index) {
                                        counter++;
                                      }
                                      counterValue.value++;
                                    }
                                    CartApi()
                                        .manageCartData(id, counterValue.value)
                                        .then((value) {
                                      Map<String, dynamic> responseData =
                                          Map<String, dynamic>.from(value.data);

                                      utils.showToast(responseData["message"]);
                                    });
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
