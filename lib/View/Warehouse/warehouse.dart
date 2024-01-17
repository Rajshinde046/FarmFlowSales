import 'package:farm_flow_sales/Common/custom_appbar.dart';
import 'package:farm_flow_sales/Model/WarehouseModel.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/view_models/WarehouseAPI.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/inventories_controller.dart';

class Warehouse extends StatefulWidget {
  const Warehouse({super.key});

  @override
  State<Warehouse> createState() => _WarehouseState();
}

class _WarehouseState extends State<Warehouse> {
  InventoriesController inventoriesController =
      Get.put(InventoriesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: customAppBar(text: "Warehouse"),
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 20.h),
          child: SingleChildScrollView(
            child: FutureBuilder<WarehouseModel>(
              future: WarehouseAPI().warehouseApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: AppColors.buttoncolour,
                  ));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data?.data == null ||
                    snapshot.data!.data!.isEmpty) {
                  return const Center(child: Text('No warehouse available'));
                }
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return sizedBoxHeight(13.h);
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, index) {
                    Data warehouseData = snapshot.data!.data![index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            inventoriesController.fromWarehouse = true;
                            inventoriesController.wareHouseId =
                                warehouseData.id!;
                            Get.toNamed('/searchnmain');
                          },
                          child: SizedBox(
                            width: 358.w,
                            child: Card(
                              elevation: 2,
                              // shadowColor: Color(0XFF00000029),
                              color: const Color(0xffF1F1F1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  sizedBoxHeight(11.h),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 21.w),
                                        child: Image.asset(
                                          "assets/images/warehouse.png",
                                          width: 47.w,
                                          height: 47.h,
                                        ),
                                      ),
                                      sizedBoxWidth(24.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          RichText(
                                            // overflow: TextOverflow.ellipsis,
                                            text: TextSpan(
                                              text: warehouseData.title,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 3.h),
                                                child: SvgPicture.asset(
                                                  "assets/images/locationconnect.svg",
                                                  width: 11.w,
                                                  height: 15.w,
                                                ),
                                              ),
                                              sizedBoxWidth(7.w),
                                              SizedBox(
                                                width: Get.width / 1.7,
                                                child: RichText(
                                                  maxLines: 3,
                                                  text: TextSpan(
                                                      text: warehouseData
                                                          .location!.name,
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 14.sp,
                                                          color: const Color(
                                                              0xff4D4D4D),
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 11.h,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
