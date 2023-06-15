import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/Utils/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'search_item.dart';

class SearchProductCategories extends StatefulWidget {
  const SearchProductCategories({Key? key}) : super(key: key);

  @override
  State<SearchProductCategories> createState() =>
      _SearchProductCategoriesState();
}

class _SearchProductCategoriesState extends State<SearchProductCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 200.h),
        child: SizedBox(
          width: 100.w,
          height: 50.h,
          child: FloatingActionButton(
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
              backgroundColor: AppColors.buttoncolour,
              onPressed: () {
                Get.toNamed('/sideMenu', arguments: 3);
                // Get.to(() => const SearchProductCategories());
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
      ),
      body: SafeArea(
        child: Padding(
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
              Text(
                "Product Categories",
                style: TextStyle(
                    fontSize: 18.sp,
                    color: const Color(0XFF141414),
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins"),
              ),
              sizedBoxHeight(18.h),
              const ProductContainer(
                  txt: "Pre-Calver Gain Gold", png: 'redreorder'),
              sizedBoxHeight(15.h),
              const ProductContainer(
                  txt: "Agrofeed Ruminant Feed", png: 'yellowreorder'),
              sizedBoxHeight(15.h),
              const ProductContainer(txt: 'Feedmix', png: 'whitereorder'),
            ],
          ),
        ),
      ),
    );
  }

  List filterList = ['Dairy', 'Beef', 'Sheep', 'Pig', 'Poultry'];
  Widget filter() {
    return PopupMenuButton(
      icon: SvgPicture.asset('assets/images/filter.svg'),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
              child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                itemFilter(0),
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.cancel_outlined))
              ]),
              itemFilter(1),
              itemFilter(2),
              itemFilter(3),
              itemFilter(4),
              GestureDetector(
                  onTap: () {
                    Get.back();
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Obx(
          () => Checkbox(
            activeColor: AppColors.buttoncolour,
            value: filter.value,
            onChanged: (value) {
              filter.value = !filter.value;
            },
          ),
        ),
        Image.asset('assets/images/${filterList[index]}.png',
            width: 40.w, height: 24.h),
        sizedBoxWidth(5.w),
        textblack14M(filterList[index]),
      ],
    );
  }
}

class ProductContainer extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final String txt;
  final String png;
  const ProductContainer(
      {super.key,
      this.minValue = 0,
      this.maxValue = 9,
      required this.txt,
      required this.png});

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  int counter = 0;
  RxInt bagsQuantity = 1.obs;
  RxString bagText = 'Bag'.obs;
  RxInt price = 200.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => SearchItem(
              png: widget.png,
              title: widget.txt,
            ));
      },
      child: Container(
        width: double.infinity,
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
              Image.asset("assets/images/${widget.png}.png", height: 97.h),
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
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return bottomSheetContainer();
                          },
                        );
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
                              () => textGreen14(
                                  '${bagsQuantity.value} ${bagText.value}'),
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
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Obx(() => textBlack18W700Center('€ ${price.value}')),
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (counter > widget.minValue) {
                                        counter--;
                                      }
                                    });
                                  },
                                  child: SvgPicture.asset(
                                    "assets/images/minusbutton.svg",
                                    width: 20.w,
                                  )),
                              sizedBoxWidth(12.w),
                              SizedBox(
                                  width: 14.w, child: textblack14M('$counter')),
                              sizedBoxWidth(8.w),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (counter < widget.maxValue) {
                                        counter++;
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
          sizedBoxHeight(18.h),
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
                    Image.asset("assets/images/${widget.png}.png",
                        height: 97.h),
                    sizedBoxWidth(26.w),
                    Flexible(
                      child: textBlack18W5000(widget.txt),
                    ),
                  ],
                ),
                sizedBoxHeight(10.h),
                insideDetContainer(1, 150),
                sizedBoxHeight(10.h),
                insideDetContainer(2, 300),
                sizedBoxHeight(10.h),
                insideDetContainer(1, 50, bag: 'pallet'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget insideDetContainer(int int, int amount, {String bag = 'Bag'}) {
    return GestureDetector(
      onTap: () {
        bagsQuantity.value = int;
        bagText.value = bag;
        price.value = amount;

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
            textGreen14('$int $bag'),
            sizedBoxHeight(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                textBlack18W700Center('€ $amount'),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            if (counter > widget.minValue) {
                              counter--;
                            }
                          });
                        },
                        child:
                            SvgPicture.asset("assets/images/minusbutton.svg")),
                    sizedBoxWidth(12.w),
                    SizedBox(width: 14.w, child: textblack14M('$counter')),
                    sizedBoxWidth(8.w),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            if (counter < widget.maxValue) {
                              counter++;
                            }
                          });
                        },
                        child:
                            SvgPicture.asset("assets/images/plusreorder.svg")),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
