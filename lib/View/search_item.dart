import 'package:farm_flow_sales/Common/custom_button_curve.dart';
import 'package:farm_flow_sales/Model/inventoriesModel/inventories_model.dart';
import 'package:farm_flow_sales/Utils/api_urls.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchItem extends StatelessWidget {
  final InventoriesData data;
  const SearchItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 30.w),
        child: customButtonCurve(
            text: 'Add to Cart',
            onTap: () {
              Get.toNamed('/sideMenu', arguments: 3);
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
                        // sizedBoxWidth(10.w),
                        // Expanded(
                        //     child: CupertinoSearchTextField(
                        //   prefixInsets:
                        //       EdgeInsetsDirectional.fromSTEB(15.w, 0, 0, 0),
                        //   prefixIcon: const Icon(
                        //     CupertinoIcons.search,
                        //     color: Colors.black,
                        //   ),
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(20),
                        //       border:
                        //           Border.all(color: AppColors.buttoncolour)),
                        // )),
                      ],
                    ),
                  ),
                  sizedBoxHeight(20.h),
                  Text(
                    data.title!,
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: const Color(0XFF141414),
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins"),
                  ),
                  // sizedBoxHeight(5.h),
                  // textGrey4D4D4D_16(
                  //     'lorem ipsum is simply dummy text of the printing and typesetting industry. lorem ipsum has been the industry'),
                  sizedBoxHeight(20.h),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xffF1F1F1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Image.network(
                      "${ApiUrls.baseImageUrl}/${data.smallImageUrl}",
                      height: 200.w,
                    ),
                  ),
                ],
              ),
            ),
            sizedBoxHeight(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                indicatorRow(),
                sizedBoxWidth(5.w),
                indicatorRow(indexBool: true),
                sizedBoxWidth(5.w),
                indicatorRow(),
                sizedBoxWidth(5.w),
                indicatorRow(),
                sizedBoxWidth(5.w),
                indicatorRow(),
                Icon(Icons.play_arrow_outlined,
                    color: AppColors.buttoncolour, size: 22.h)
              ],
            ),
            sizedBoxHeight(10.h),
            // Divider(thickness: 1.h),
            // textGreen18W5000('   € 500'),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        "General information",
                        style: GoogleFonts.poppins(
                            fontSize: 22.sp,
                            color: AppColors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    sizedBoxHeight(11.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Product Number ",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            ": ",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "2000278",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff4D4D4D)),
                          ),
                        ],
                      ),
                    ),
                    sizedBoxHeight(3.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Quantity                ",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            ": ",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "6.280 TO",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff4D4D4D)),
                          ),
                        ],
                      ),
                    ),
                    sizedBoxHeight(3.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Batch                     ",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            ": ",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            data.batch!,
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff4D4D4D)),
                          ),
                        ],
                      ),
                    ),
                    sizedBoxHeight(3.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Gross                      ",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            ": ",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "24920",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff4D4D4D)),
                          ),
                        ],
                      ),
                    ),
                    sizedBoxHeight(3.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Tare                        ",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            ": ",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "18640",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff4D4D4D)),
                          ),
                        ],
                      ),
                    ),
                    sizedBoxHeight(3.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Net                          ",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            ": ",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "6280",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff4D4D4D)),
                          ),
                        ],
                      ),
                    ),
                    sizedBoxHeight(3.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Section                  ",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            ": ",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "1",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff4D4D4D)),
                          ),
                        ],
                      ),
                    ),
                    sizedBoxHeight(3.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Daycode               ",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            ": ",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "123",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff4D4D4D)),
                          ),
                        ],
                      ),
                    ),
                    sizedBoxHeight(3.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Wbridge No          ",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            ": ",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "3",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff4D4D4D)),
                          ),
                        ],
                      ),
                    ),
                    sizedBoxHeight(3.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Manufactured     ",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            ": ",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp, fontWeight: FontWeight.w500),
                          ),
                          Flexible(
                            child: Text(
                              "At DOC Feeds,",
                              style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff4D4D4D)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        "Ballysimon Rd, Limerick Aielk000192 UFAS Approved Compounder. Reg No 4050.",
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff4D4D4D)),
                      ),
                    ),
                    sizedBoxHeight(3.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        "Elite Dairy 15% Nut(2 To 8) Best before And Added Mineral And Vit Expiry Date:01/08/23 No:!TM",
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff4D4D4D)),
                      ),
                    ),
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
                        "Crude Protein 15.00%, Crude Oils & Fats 4.88%, Crude Fibre 10.07%. \nCrude Ash 8.76% Sodium 0.21% Magnesium Oxide Added To Give 2Oz in 4Kgs Of Feed, Magnesium 1% As An Aid To Preventing Grass Tetany",
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
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
                        "Vitamin A (3A672a Retinyl Acetate)\n 10,000Iu,\nVitamin D3 (3A671 Chloecalciferol)\n2,000 Iu,\nVitamin E (3A700 All-Rac\nAlphatocopheral Acetate)10 Iu/Kg",
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
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
                        "Iodine (3B202 Calcium Iodate Anhydrous) : 8Mg,\nCobalt (3B304 Cobalt Carbonate,\nCoated Granulated ):1.0Mg\nCopper (3B405 Cupric Sulphate Pentahydrate) :50Mg\nManganese (3B502 Manganous Oxide):40Mg\nZinc (3B502 Zinc Oxide) : 100 Mg\nSelenium (E8 Sodium Selenite) : 0.7Mg\nMax Feeding Rate 9Kg\nE1710 Vistacell To Provide6.25*10^9Cfu/\nKg Saccharomyces\nCervisiae (4B1710) ",
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
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
                        "Maize, Dried Beet Pulp, Barley, Soya(Bean) Hulls(Prod From G M Soya)",
                        style: GoogleFonts.poppins(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff4D4D4D)),
                      ),
                    ),
                    sizedBoxHeight(80.h),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 16.w),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       customButtonCurve(
                    //           text: 'Add to Cart',
                    //           onTap: () {
                    //             Get.toNamed('/sideMenu', arguments: 3);
                    //           })
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
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
