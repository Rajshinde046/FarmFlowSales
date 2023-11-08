import 'package:farm_flow_sales/Common/CommonTextFormField.dart';
import 'package:farm_flow_sales/Common/custom_button_curve.dart';
import 'package:farm_flow_sales/Common/getx_controller.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/Utils/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Common/limit_range.dart';
import '../../Model/cartModel/cartModel.dart';
import '../../controller/cart_controller.dart';
import '../../controller/inventories_controller.dart';
import '../../view_models/cartApi/cartApi.dart';

class Discount extends StatelessWidget {
  Discount({super.key});

  final CommonGetXController discountController =
      Get.put(CommonGetXController());
  final TextEditingController discountValueConttroller =
      TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final RxBool discountBool = true.obs;
  final RxDouble finalAmount = 0.0.obs;
  double mRP = 0.0;

  CartController cartController = Get.put(CartController());

  InventoriesController inventoriesController =
      Get.put(InventoriesController());

  @override
  Widget build(BuildContext context) {
    discountValueConttroller.text = "0";
    mRP = inventoriesController.cartSubTotalValue.value.toDouble();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 44.h),
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset("assets/images/discountimage.svg"),
                sizedBoxHeight(28.h),
                textBlack20W7000('Discount'),
                sizedBoxHeight(9.h),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          discountBool.value = true;
                          if (double.parse(discountValueConttroller.text) >
                              100) {
                            discountValueConttroller.text = "100";
                            discountController.changeValue(100);
                          }
                        },
                        child: Container(
                          width: 179.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.buttoncolour),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                              color: discountBool.value
                                  ? AppColors.buttoncolour
                                  : AppColors.white),
                          child: Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                                "assets/images/percentage-svgrepo-com.svg",
                                color: discountBool.value
                                    ? AppColors.white
                                    : AppColors.black),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          discountBool.value = false;
                        },
                        child: Container(
                          width: 179.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: discountBool.value
                                  ? AppColors.white
                                  : AppColors.buttoncolour,
                              border:
                                  Border.all(color: AppColors.buttoncolour)),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text("€",
                                  style: GoogleFonts.poppins(
                                      fontSize: 28.sp,
                                      color: discountBool.value
                                          ? AppColors.black
                                          : AppColors.white,
                                      fontWeight: FontWeight.w500))),
                        ),
                      ),
                    ],
                  ),
                ),
                sizedBoxHeight(21.h),
                textGrey4D4D4D_16W500('Enter Value'),
                sizedBoxHeight(7.h),
                Obx(
                  () => CustomTextFormField(
                      onChanged: (p0) {
                        // CommonGetXController
                        double doubleValue = double.tryParse(p0) ?? 0;
                        discountController.changeValue(doubleValue);
                      },
                      hintText: "Enter value",
                      texttype: TextInputType.phone,
                      textEditingController: discountValueConttroller,
                      inputFormatters: discountBool.value
                          ? [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                              LimitRange(0, 100)
                            ]
                          : [
                              FilteringTextInputFormatter.digitsOnly,
                              LimitRange(0, mRP.toInt())
                            ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a value";
                        }
                        return null;
                      },
                      validatorText: "Enter your value"),
                ),
                sizedBoxHeight(23.h),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text18w5004D4D4D('Total MRP'),
                      text18w5004D4D4D('€ $mRP'),
                    ]),
                sizedBoxHeight(15.h),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text18w5004D4D4D("Discount on MRP"),
                      GetBuilder<CommonGetXController>(builder: (context) {
                        return Obx(() => text18w5004D4D4D(discountBool.value
                            ? "- ${discountController.discountValue} %"
                            : '€ ${discountValueConttroller.text}'));
                      }),
                    ]),
                sizedBoxHeight(3.h),
                const Divider(thickness: 1, color: AppColors.buttoncolour),
                sizedBoxHeight(3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text18w5004D4D4D("Total Amount"),
                    GetBuilder<CommonGetXController>(
                      builder: (controller) {
                        return Obx(
                          () => text18w5004D4D4D(discountBool.value
                              ? "€ ${(mRP - ((mRP * discountController.discountValue!) / 100)).toStringAsFixed(2)}"
                              : "€ ${mRP - discountController.discountValue!}"),
                        );
                      },
                    ),
                  ],
                ),
                sizedBoxHeight(179.h),
                customButtonCurve(
                    text: "Proceed",
                    onTap: () {
                      if (_form.currentState!.validate()) {
                        cartController.discountTypeId =
                            discountBool.value ? 0 : 1;
                        cartController.discountValue = discountBool.value
                            ? discountController.discountValue!
                            : double.parse(discountValueConttroller.text);
                        cartController.netValue = discountBool.value
                            ? double.parse((mRP -
                                    ((mRP * discountController.discountValue!) /
                                        100))
                                .toStringAsFixed(2))
                            : (mRP - discountController.discountValue!);

                        CartApi().getViewCartData().then((value) {
                          inventoriesController.viewCartModel =
                              ViewCartModel.fromJson(value.data);
                        }).then((value) {
                          Get.toNamed("/placeordermain", arguments: {
                            "bool": discountBool.value,
                          });
                        });

                        // investAmountPopUp();
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
