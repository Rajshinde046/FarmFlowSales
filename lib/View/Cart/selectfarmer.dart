import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/custom_button.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:google_fonts/google_fonts.dart';



enum ColorLabel {
  blue('Kevin Mounsey'),
  pink('Aron Smith'),
  green('Kevin Mounsey'),
  yellow('Aron Smith'),
  grey('Kevin Mounsey');

  const ColorLabel(this.label);
  final String label;
}

enum addLabel {
  blue(' 64 martens place, dunwich, queensland, 4183, Ireland'),
  pink(' 64 martens place, dunwich, queensland, 4183, Ireland'),
  green(' 64 martens place, dunwich, queensland, 4183, Ireland'),
  yellow(' 64 martens place, dunwich, queensland, 4183, Ireland'),
  grey(' 64 martens place, dunwich, queensland, 4183, Ireland');

  const addLabel(this.label);
  final String label;
}

class selectFarmer extends StatefulWidget {
  const selectFarmer({super.key});

  @override
  State<selectFarmer> createState() => _selectFarmerState();
}

class _selectFarmerState extends State<selectFarmer> {
  ColorLabel? selectedColor;
  addLabel? selectedAdd;
  final TextEditingController colorController = TextEditingController();
final TextEditingController addController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<ColorLabel>> colorEntries =
        <DropdownMenuEntry<ColorLabel>>[];
    for (final ColorLabel color in ColorLabel.values) {
      colorEntries.add(
        DropdownMenuEntry<ColorLabel>(
          value: color,
          label: color.label,
        ),
      );
    }

    final List<DropdownMenuEntry<addLabel>> addEntries =
        <DropdownMenuEntry<addLabel>>[];
    for (final addLabel add in addLabel.values) {
      addEntries.add(
        DropdownMenuEntry<addLabel>(
          value: add,
          label: add.label,
        ),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              SvgPicture.asset(
                "assets/images/selectfarmer.svg",
                width: 360.w,
              ),
              SizedBox(
                height: 25.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Select Farmer",
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              sizedBoxHeight(10.h),
              DropdownMenu<ColorLabel>(
                hintText: "Select Farmer",
                trailingIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.green,
                ),
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: Color(0xFFF1F1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                  ),
                ),
                enabled: true,
                width: 350.w,
                enableSearch: false,
                controller: colorController,
                dropdownMenuEntries: colorEntries,
                onSelected: (ColorLabel? color) {
                  setState(() {
                    selectedColor = color;
                  });
                },
              ),
              sizedBoxHeight(30),
              DropdownMenu<addLabel>(
                hintText: "Select Address",
                trailingIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.green,
                ),
                inputDecorationTheme: InputDecorationTheme(
                  filled: true,
                  fillColor: Color(0xFFF1F1F1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                        color: Color(0xFF707070).withOpacity(0), width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                  ),
                ),
                enabled: true,
                width: 350.w,
                enableSearch: false,
                controller: addController,
                dropdownMenuEntries: addEntries,
                onSelected: (addLabel? add) {
                  setState(() {
                    selectedAdd = add;
                  });
                },
              ),
              sizedBoxHeight(30),
              CustomButton(
                  text: "Deliver To This Address",
                  onTap: () {
                    Get.toNamed("/selectfrequency");
                  }),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  buildcustomnote();
                },
                child: Container(
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.buttoncolour),
                      borderRadius: BorderRadius.circular(25.h),
                      color: AppColors.white),
                  child: Center(
                    child: Text(
                      "Add Delivery Instructions",
                      style: TextStyle(color: AppColors.black, fontSize: 18.sp),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildcustomnote() {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            insetPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
            contentPadding: EdgeInsets.fromLTRB(15, 30, 15, 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(
                  color: Get.isDarkMode ? Colors.grey : Colors.white),
            ),
            // contentPadding:
            //     EdgeInsets.all(
            //         10),
            //   title: ,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Custom Note",
                  style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500),
                ),
                sizedBoxHeight(9.h),
                TextFormField(
                  style: TextStyle(fontSize: 16.sp),
                  cursorColor: const Color(0xFF3B3F43),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontSize: 16.sp),
                    contentPadding: EdgeInsets.all(17.h),
                    filled: true,
                    fillColor: AppColors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          BorderSide(color: Color(0xFF707070), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          BorderSide(color: Color(0xFF707070), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          BorderSide(color: Color(0xFF707070), width: 1),
                    ),
                    hintStyle: TextStyle(
                        color: const Color(0xFF4D4D4D), fontSize: 16.sp),
                    hintText: "",
                  ),
                  minLines: 3,
                  maxLines: null,
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'Message is required';
                  //   }
                  //   return null;
                  // },
                ),
                sizedBoxHeight(41.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        // Get.toNamed("/cancelorder");
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.buttoncolour),
                        child: Center(
                          child: Text(
                            "Add",
                            style: TextStyle(
                                color: AppColors.white, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                    sizedBoxWidth(28.w),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0XFF0E5F02)),
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.white),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: AppColors.buttoncolour, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget newslistCard(
    dynamic recipeimage,
    dynamic title,
    dynamic street,
    int index,
    dynamic city,
    dynamic state,
    dynamic phone,
    dynamic zipcode,
    dynamic country) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: GFAccordion(
          showAccordion: false,
          titleBorderRadius: BorderRadius.circular(5.r),
          contentBorderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5.r),
            bottomRight: Radius.circular(5.r),
          ),
          margin: const EdgeInsets.all(0),
          titlePadding: EdgeInsets.all(10.h),
          contentPadding: EdgeInsets.all(10.w),
          expandedTitleBackgroundColor: Colors.white,
          contentBackgroundColor: Colors.white,
          titleChild: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontFamily: "Poppins",
            ),
          ),
          contentChild: Row(
            children: [
              Icon(
                Icons.radio_button_checked,
                color: AppColors.buttoncolour,
              ),
              sizedBoxWidth(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Address",
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "street: ",
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        street,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "city: ",
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        city,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "state/province/area: ",
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        state,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "phone number: ",
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        phone,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "zip code: ",
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        zipcode,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "country: ",
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        country,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                  sizedBoxHeight(15.h),
                ],
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 15.h,
      ),
    ],
  );
}

List newsData = [
  {
    "recipeimage": "assets/images/cow.png",
    "title": 'Kevin Mounsey',
    "street": "64 martens place",
    "city": "mumbai",
    "state": "punjab",
    "phone": "(07) 3830 6616",
    "zipcode": "4183",
    "country": "ireland"
  },
  {
    "recipeimage": "assets/images/tractor.png",
    "title": 'Aron Smith',
    "street": "85 martens place",
    "city": "mumbai",
    "state": "punjab",
    "phone": "(07) 3830 6616",
    "zipcode": "4156",
    "country": "ireland"
  },
  {
    "recipeimage": "assets/images/cow.png",
    "title": 'Kevin Mounsey',
    "street": "24 martens place",
    "city": "mumbai",
    "state": "punjab",
    "phone": "(07) 3830 6616",
    "zipcode": "6495",
    "country": "ireland"
  },
  {
    "recipeimage": "assets/images/tractor.png",
    "title": 'Aron Smith',
    "street": "84 martens place",
    "city": "mumbai",
    "state": "punjab",
    "phone": "(07) 3830 6616",
    "zipcode": "5144",
    "country": "ireland"
  },
];
