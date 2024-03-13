import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:farm_flow_sales/Common/custom_button_curve.dart';
import 'package:farm_flow_sales/Utils/api_urls.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:farm_flow_sales/Common/limit_range.dart';
import '../Model/inventoriesModel/inventory_details_model.dart';
import '../Utils/texts.dart';
import '../controller/inventories_controller.dart';
import '../view_models/cartApi/cartApi.dart';
import '../view_models/inventoriesApi/inventoriesApi.dart';

class SearchItem extends StatefulWidget {
  final InventoryDetailsModel data;
  const SearchItem({
    super.key,
    required this.data,
  });

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  int _current = 0;
  InventoryDetailsModel inventoryDetailsModel = InventoryDetailsModel();
  final CarouselController _controller = CarouselController();
  InventoriesController inventoriesController =
      Get.put(InventoriesController());
  RxInt counter = 0.obs;
  RxInt bagsQuantity = 0.obs;
  RxString bagText = ''.obs;
  RxInt price = 0.obs;
  RxInt selectedBag = 0.obs;

  @override
  void initState() {
    price.value = widget.data.data!.lots![0].price!;
    bagText.value = widget.data.data!.lots![0].lotName!;
    bagsQuantity.value = widget.data.data!.lots![0].quantity!;
    counter.value = widget.data.data!.lots![0].prevQuantity!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = widget.data.data!.media!
        .map((item) => Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: CachedNetworkImage(
                  memCacheWidth: Get.width.toInt(),
                  maxWidthDiskCache: Get.width.toInt(),
                  imageUrl: "${ApiUrls.baseImageUrl}/${item.imageUrl!}",
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(
                    color: AppColors.buttoncolour,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ))
        .toList();
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: true);
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(25),
          child: customButtonCurve(
              text: 'Add to Cart',
              onTap: () {
                InventoriesApi()
                    .getInventoryDetailData(widget.data.data!.id.toString())
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
              }),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back(result: true);
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
                        ],
                      ),
                    ),
                    sizedBoxHeight(20.h),
                    Text(
                      widget.data.data!.title!,
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: const Color(0XFF141414),
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins"),
                    ),
                    sizedBoxHeight(20.h),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: const Color(0xffF1F1F1),
                          borderRadius: BorderRadius.circular(10)),
                      child: CarouselSlider(
                        items: imageSliders,
                        carouselController: _controller,
                        options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            aspectRatio: 2.0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              sizedBoxHeight(10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.data.data!.media!.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.buttoncolour),
                          shape: BoxShape.circle,
                          color: _current == entry.key
                              ? AppColors.buttoncolour
                              : AppColors.white),
                    ),
                  );
                }).toList(),
              ),
              sizedBoxHeight(10.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          "General Information",
                          style: GoogleFonts.poppins(
                              fontSize: 22.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      sizedBoxHeight(11.h),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(children: [
                          rowWithText("Product Number : ",
                              widget.data.data!.id!.toString()),
                          const Gap(3),
                          // rowWithText("Quantity : ", "500"),
                          // const Gap(3),
                          rowWithText("Batch : ", widget.data.data!.batch!),
                          const Gap(3),
                          rowWithText("Gross : ", widget.data.data!.gross!),
                          const Gap(3),
                          rowWithText("Tare : ", widget.data.data!.tare!),
                          const Gap(3),
                          rowWithText("Section : ", widget.data.data!.section!),
                          const Gap(3),
                          rowWithText("Net : ", widget.data.data!.net!),
                          const Gap(3),
                          rowWithText("Daycode : ", widget.data.data!.daycode!),
                          const Gap(3),
                          rowWithText(
                              "Wbridge No : ", widget.data.data!.wbridgeNo!),
                          const Gap(3),
                          rowWithText("Manufactured : ",
                              widget.data.data!.manufactured!),
                        ]),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 16.w),
                      //   child: Text(
                      //     "Ballysimon Rd, Limerick Aielk000192 UFAS Approved Compounder. Reg No 4050.",
                      //     style: GoogleFonts.poppins(
                      //         fontSize: 18.sp,
                      //         fontWeight: FontWeight.w400,
                      //         color: const Color(0xff4D4D4D)),
                      //   ),
                      // ),
                      // sizedBoxHeight(3.h),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 16.w),
                      //   child: Text(
                      //     "Elite Dairy 15% Nut(2 To 8) Best before And Added Mineral And Vit Expiry Date:01/08/23 No:!TM",
                      //     style: GoogleFonts.poppins(
                      //         fontSize: 18.sp,
                      //         fontWeight: FontWeight.w400,
                      //         color: const Color(0xff4D4D4D)),
                      //   ),
                      // ),
                      Divider(thickness: 1.h),
                      sizedBoxHeight(10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          "Product Description",
                          style: GoogleFonts.poppins(
                              fontSize: 22.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      sizedBoxHeight(11.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          "Analytical Constituents:",
                          style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      sizedBoxHeight(11.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          widget.data.data!.analyticalConstituents!,
                          style: GoogleFonts.poppins(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff4D4D4D)),
                        ),
                      ),
                      Divider(thickness: 1.h),
                      sizedBoxHeight(10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          "Additives Per kg: VITAMINS",
                          style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      sizedBoxHeight(11.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          widget.data.data!.additivesPerKg!,
                          style: GoogleFonts.poppins(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff4D4D4D)),
                        ),
                      ),
                      Divider(thickness: 1.h),
                      sizedBoxHeight(10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          "TRACE ELEMENTS Per Kg:",
                          style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      sizedBoxHeight(11.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          widget.data.data!.traceElementsPerKg!,
                          style: GoogleFonts.poppins(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff4D4D4D)),
                        ),
                      ),
                      Divider(thickness: 1.h),
                      sizedBoxHeight(10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          "Composition:",
                          style: GoogleFonts.poppins(
                              fontSize: 18.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      sizedBoxHeight(11.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          widget.data.data!.composition!,
                          style: GoogleFonts.poppins(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff4D4D4D)),
                        ),
                      ),
                      sizedBoxHeight(80.h),
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

  Widget rowWithText(String text1, String text2) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            text1,
            maxLines: 2,
            style: GoogleFonts.poppins(
                fontSize: 18.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Text(
            text2,
            maxLines: 3,
            style: GoogleFonts.poppins(
                fontSize: 17.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xff4D4D4D)),
          ),
        )
      ],
    );
  }

  Widget bottomSheetContainer() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 20.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
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
                      imageUrl:
                          "${ApiUrls.baseImageUrl}/${widget.data.data!.smallImageUrl}",
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(
                        color: AppColors.buttoncolour,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    sizedBoxWidth(26.w),
                    Flexible(
                      child: textBlack18W5000(widget.data.data!.title!),
                    ),
                  ],
                ),
                sizedBoxHeight(10.h),
                SizedBox(
                  height: 287,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.data.data!.lots!.length,
                      itemBuilder: (ctx, index) {
                        return Container(
                            margin: EdgeInsets.only(bottom: 10.h),
                            child: insideDetContainer(
                              index,
                              widget.data.data!.lots![index].quantity!,
                              widget.data.data!.lots![index].price!,
                              widget.data.data!.lots![index].lotName!,
                              inventoryDetailsModel
                                  .data!.lots![index].prevQuantity!,
                              widget.data.data!.lots![index].itemMasterLotXid!,
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
    return Container(
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
              Obx(
                () => Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            if (counterValue.value > quantity) {
                              if (selectedBag.value == index) {
                                counter--;
                              }
                              counterValue.value--;
                              CartApi()
                                  .manageCartData(id, counterValue.value)
                                  .then((value) {
                                Map<String, dynamic> responseData =
                                    Map<String, dynamic>.from(value.data);

                                utils.showToast(responseData["message"]);
                              });
                            }
                          });
                        },
                        child:
                            SvgPicture.asset("assets/images/minusbutton.svg")),
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
                        child:
                            SvgPicture.asset("assets/images/plusreorder.svg")),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget indicatorRow({bool indexBool = false}) {
    return Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(
          border: Border.all(width: 1.5.h, color: AppColors.buttoncolour),
          borderRadius: BorderRadius.circular(10),
          color: indexBool ? AppColors.buttoncolour : AppColors.white),
    );
  }
}
