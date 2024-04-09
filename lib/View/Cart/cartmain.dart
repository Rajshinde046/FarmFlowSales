import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm_flow_sales/Utils/api_urls.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:farm_flow_sales/Common/limit_range.dart';

import '../../Model/cartModel/cartModel.dart';
import '../../controller/inventories_controller.dart';
import '../../view_models/cartApi/cartApi.dart';

class Cartmain extends StatefulWidget {
  const Cartmain({
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
  State<Cartmain> createState() => _CartmainState();
}

class _CartmainState extends State<Cartmain> {
  InventoriesController inventoriesController =
      Get.put(InventoriesController());

  CartController cartController = Get.put(CartController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      inventoriesController.isLoading.value = true;
      CartApi().getViewCartData().then((value) {
        inventoriesController.viewCartModel.value =
            ViewCartModel.fromJson(value.data);
        inventoriesController.cartSubTotalValue.value =
            inventoriesController.viewCartModel.value.data!.subTotal!;
        inventoriesController.isLoading.value = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Obx(
        () => inventoriesController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColors.buttoncolour,
              ))
            : inventoriesController.viewCartModel.value.data!.cart!.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: LottieBuilder.asset(
                        "assets/lotties/empty_cart.json",
                        height: 250,
                        width: 200,
                        fit: BoxFit.contain,
                      )),
                      Text(
                          "Cart's feeling a bit empty? Let's plant some products in there!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  )
                : SafeArea(
                    child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 16.w, top: 42.h, right: 16.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              "Subtotal € ${inventoriesController.cartSubTotalValue.value}",
                              style: GoogleFonts.montserrat(
                                fontSize: 18.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          sizedBoxHeight(11.h),
                          InkWell(
                            onTap: () {
                              List<int> listV = [];
                              for (var a in inventoriesController
                                  .viewCartModel.value.data!.cart!) {
                                listV.add(a.id!);
                              }
                              cartController.cartDataId = listV;
                              Get.toNamed("/selectfarmer");
                            },
                            child: Container(
                              height: 50.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.h),
                                  color: AppColors.buttoncolour),
                              child: Center(
                                child: Text(
                                  "Proceed To Buy (${inventoriesController.viewCartModel.value.data!.cart!.length} Items)",
                                  style: TextStyle(
                                      color: AppColors.white, fontSize: 18.sp),
                                ),
                              ),
                            ),
                          ),
                          sizedBoxHeight(27.h),
                          SizedBox(
                            height: Get.height / 1.65,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: inventoriesController
                                    .viewCartModel.value.data!.cart!.length,
                                itemBuilder: (ctx, index) {
                                  return CartCardDetails(
                                      index: index,
                                      maxValue: inventoriesController
                                                  .viewCartModel
                                                  .value
                                                  .data!
                                                  .cart![index]
                                                  .getItems![0]
                                                  .quantity ==
                                              null
                                          ? 0
                                          : inventoriesController
                                              .viewCartModel
                                              .value
                                              .data!
                                              .cart![index]
                                              .getItems![0]
                                              .quantity!);
                                }),
                          ),
                          sizedBoxHeight(20.h),
                        ],
                      ),
                    ),
                  )),
      ),
    );
  }
}

class CartCardDetails extends StatefulWidget {
  CartCardDetails({super.key, required this.index, required this.maxValue});
  int index;
  int maxValue;

  @override
  State<CartCardDetails> createState() => _CartCardDetailsState();
}

class _CartCardDetailsState extends State<CartCardDetails> {
  InventoriesController inventoriesController =
      Get.put(InventoriesController());
  RxInt counter = 0.obs;
  RxInt price = 0.obs;
  @override
  void initState() {
    counter = inventoriesController
        .viewCartModel.value.data!.cart![widget.index].quantity!.obs;
    price.value = counter.value *
        inventoriesController
            .viewCartModel.value.data!.cart![widget.index].getItems![0].price!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
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
        padding:
            EdgeInsets.only(left: 22.w, right: 16.w, top: 8.h, bottom: 13.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              memCacheHeight: 97,
              maxHeightDiskCache: 97,
              maxWidthDiskCache: 85,
              memCacheWidth: 85,
              imageUrl:
                  "${ApiUrls.baseImageUrl}/${inventoriesController.viewCartModel.value.data!.cart![widget.index].getItems![0].item!.smallImageUrl}",
              placeholder: (context, url) => const CircularProgressIndicator(
                color: AppColors.buttoncolour,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            sizedBoxWidth(31.w),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    inventoriesController.viewCartModel.value.data!
                        .cart![widget.index].getItems![0].item!.title!,
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff141414),
                    ),
                  ),
                  sizedBoxHeight(7.h),
                  Text(
                    inventoriesController.viewCartModel.value.data!
                        .cart![widget.index].getItems![0].lotName!,
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                      color: const Color(0xff141414),
                    ),
                  ),
                  sizedBoxHeight(7.h),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "€ ${price.value}",
                          style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (counter.value > 0) {
                                      counter.value--;

                                      CartApi()
                                          .manageCartData(
                                              inventoriesController
                                                  .viewCartModel
                                                  .value
                                                  .data!
                                                  .cart![widget.index]
                                                  .itemMasterLotXid!,
                                              counter.value)
                                          .then((value) {
                                        if (counter.value == 0) {
                                          // inventoriesController.isLoading.value =
                                          //     true;
                                          CartApi()
                                              .getViewCartData()
                                              .then((value) {
                                            inventoriesController
                                                    .viewCartModel.value =
                                                ViewCartModel.fromJson(
                                                    value.data);
                                            inventoriesController
                                                    .cartSubTotalValue.value =
                                                inventoriesController
                                                    .viewCartModel
                                                    .value
                                                    .data!
                                                    .subTotal!;
                                            // inventoriesController.isLoading.value =
                                            //     false;
                                            // setState(() {});
                                          });
                                        } else {
                                          int totalPriceV = 0;
                                          inventoriesController
                                              .viewCartModel
                                              .value
                                              .data!
                                              .cart![widget.index]
                                              .quantity = counter.value;

                                          price.value = counter.value *
                                              inventoriesController
                                                  .viewCartModel
                                                  .value
                                                  .data!
                                                  .cart![widget.index]
                                                  .getItems![0]
                                                  .price!;

                                          for (int i = 0;
                                              i <
                                                  inventoriesController
                                                      .viewCartModel
                                                      .value
                                                      .data!
                                                      .cart!
                                                      .length;
                                              i++) {
                                            totalPriceV += inventoriesController
                                                    .viewCartModel
                                                    .value
                                                    .data!
                                                    .cart![i]
                                                    .quantity! *
                                                inventoriesController
                                                    .viewCartModel
                                                    .value
                                                    .data!
                                                    .cart![i]
                                                    .getItems![0]
                                                    .price!;
                                          }

                                          inventoriesController
                                              .cartSubTotalValue
                                              .value = totalPriceV;
                                          setState(() {});
                                        }
                                        Map<String, dynamic> responseData =
                                            Map<String, dynamic>.from(
                                                value.data);
                                        utils
                                            .showToast(responseData["message"]);
                                      });
                                    }
                                    // widget.onChanged(counter);
                                  });
                                },
                                child: SvgPicture.asset(
                                  // "assets/images/minusbutton.svg",
                                  "assets/images/minus1.svg",
                                  width: 20.w,
                                  // width: 20.w,
                                  // height: 40.h,
                                ),
                              ),
                            ),
                            sizedBoxWidth(12.w),
                            Obx(
                              () => SizedBox(
                                width: 14.w,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    "${counter.value}",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: const Color(0xff141414),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            sizedBoxWidth(8.w),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (inventoriesController
                                        .viewCartModel
                                        .value
                                        .data!
                                        .cart![widget.index]
                                        .getItems![0]
                                        .lotName!
                                        .contains("Bulk")) {
                                      counter.value++;
                                      CartApi()
                                          .manageCartData(
                                              inventoriesController
                                                  .viewCartModel
                                                  .value
                                                  .data!
                                                  .cart![widget.index]
                                                  .itemMasterLotXid!,
                                              counter.value)
                                          .then((value) {
                                        int totalPriceV = 0;
                                        inventoriesController
                                            .viewCartModel
                                            .value
                                            .data!
                                            .cart![widget.index]
                                            .quantity = counter.value;
                                        price.value = counter.value *
                                            inventoriesController
                                                .viewCartModel
                                                .value
                                                .data!
                                                .cart![widget.index]
                                                .getItems![0]
                                                .price!;
                                        for (int i = 0;
                                            i <
                                                inventoriesController
                                                    .viewCartModel
                                                    .value
                                                    .data!
                                                    .cart!
                                                    .length;
                                            i++) {
                                          totalPriceV += inventoriesController
                                                  .viewCartModel
                                                  .value
                                                  .data!
                                                  .cart![i]
                                                  .quantity! *
                                              inventoriesController
                                                  .viewCartModel
                                                  .value
                                                  .data!
                                                  .cart![i]
                                                  .getItems![0]
                                                  .price!;
                                        }

                                        inventoriesController.cartSubTotalValue
                                            .value = totalPriceV;
                                        Map<String, dynamic> responseData =
                                            Map<String, dynamic>.from(
                                                value.data);
                                        utils
                                            .showToast(responseData["message"]);
                                      });
                                    } else {
                                      if (counter.value < widget.maxValue) {
                                        counter.value++;
                                        CartApi()
                                            .manageCartData(
                                                inventoriesController
                                                    .viewCartModel
                                                    .value
                                                    .data!
                                                    .cart![widget.index]
                                                    .itemMasterLotXid!,
                                                counter.value)
                                            .then((value) {
                                          int totalPriceV = 0;
                                          inventoriesController
                                              .viewCartModel
                                              .value
                                              .data!
                                              .cart![widget.index]
                                              .quantity = counter.value;
                                          price.value = counter.value *
                                              inventoriesController
                                                  .viewCartModel
                                                  .value
                                                  .data!
                                                  .cart![widget.index]
                                                  .getItems![0]
                                                  .price!;
                                          for (int i = 0;
                                              i <
                                                  inventoriesController
                                                      .viewCartModel
                                                      .value
                                                      .data!
                                                      .cart!
                                                      .length;
                                              i++) {
                                            totalPriceV += inventoriesController
                                                    .viewCartModel
                                                    .value
                                                    .data!
                                                    .cart![i]
                                                    .quantity! *
                                                inventoriesController
                                                    .viewCartModel
                                                    .value
                                                    .data!
                                                    .cart![i]
                                                    .getItems![0]
                                                    .price!;
                                          }

                                          inventoriesController
                                              .cartSubTotalValue
                                              .value = totalPriceV;
                                          Map<String, dynamic> responseData =
                                              Map<String, dynamic>.from(
                                                  value.data);
                                          utils.showToast(
                                              responseData["message"]);
                                        });
                                      }
                                    }
                                    // widget.onChanged(counter);
                                  });
                                },
                                child: SvgPicture.asset(
                                  // "assets/images/plusreorder.svg",
                                  "assets/images/plus1.svg",
                                  width: 20.w,
                                  // width: 20.w,
                                  // height: 40.h,
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
            ),
          ],
        ),
      ),
    );
  }
}
