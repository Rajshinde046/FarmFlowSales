import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/custom_button.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/View/LoginScreen.dart';
import 'package:farm_flow_sales/controller/inventories_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Common/custom_dropdown.dart';
import '../../controller/cart_controller.dart';
import '../../view_models/farmer/FarmerListAPI.dart';
import 'package:farm_flow_sales/Common/limit_range.dart';

class selectFrequency extends StatefulWidget {
  const selectFrequency({super.key});

  @override
  State<selectFrequency> createState() => _selectFrequencyState();
}

class _selectFrequencyState extends State<selectFrequency> {
  DateTime? _selectedDate;
  TextEditingController datecontroller = TextEditingController();
  String? selectedFrequency;
  List<String> frequencyList = [];
  List<int> frequencyId = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CartController cartController = Get.put(CartController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await FarmerListAPI().getFrequencyApi().then((value) {
        for (var a in value.data!) {
          frequencyList.add(a.name!);
          frequencyId.add(a.id!);
        }
        setState(() {});
      });
    });

    super.initState();
  }

  @override
  void _presentDatePicker() {
    // showDatePicker is a pre-made funtion of Flutter
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3000),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.buttoncolour,
                onPrimary: AppColors.white,
                onSurface: Colors.blueAccent,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.buttoncolour,
                ),
              ),
            ),
            child: child!);
      },
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        datecontroller.text =
            "${_selectedDate!.day.toString()}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year.toString().padLeft(2, '0')}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                SvgPicture.asset(
                  "assets/images/frequency.svg",
                  width: 360.w,
                ),
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Set As Recurring Order",
                      style: GoogleFonts.poppins(
                          fontSize: 20.sp, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Select Frequency",
                      style: GoogleFonts.poppins(
                          fontSize: 18.sp, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                sizedBoxHeight(10.h),
                DropdownBtn(
                  hint: "Select Frequency",
                  // items: ,
                  items: frequencyList
                      .map((e) => DropdownMenuItem(
                            value: e,
                            onTap: () {
                              setState(() {
                                selectedFrequency = e;
                              });
                            },
                            child: Text(
                              e,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4D4D4D),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: selectedFrequency,
                ),
                sizedBoxHeight(25.h),
                selectedFrequency == "One Time"
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Select Start Date",
                            style: GoogleFonts.poppins(
                                fontSize: 18.sp, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                selectedFrequency == "One Time"
                    ? const SizedBox()
                    : Form(
                        key: _formKey,
                        child: Personaldatepicker(
                          datecontroller: datecontroller,
                          ontap: () => _presentDatePicker(),
                        ),
                      ),
                sizedBoxHeight(150.h),
                CustomButton(
                    text: "Confirm",
                    onTap: () {
                      if (selectedFrequency == null) {
                        utils.showToast("Please Select Frequency");
                      } else if (datecontroller.text.isEmpty &&
                          selectedFrequency != "One Time") {
                        utils.showToast("Please Select Start Date");
                      } else {
                        cartController.selectedFrequencyId = frequencyId[
                            frequencyList.indexOf(selectedFrequency!)];
                        cartController.selectedStartDate = datecontroller.text;

                        Get.toNamed("/discountpage");
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

class Personaldatepicker extends StatelessWidget {
  Personaldatepicker({
    Key? key,
    required this.datecontroller,
    required this.ontap,
    this.validator,
    this.inputFormatters,
    this.textEditingController,
    this.leadingIcon,
    this.onTap,
    this.eyeIcon = false,
    this.onChanged,
    this.suffixIcon,
    this.readonly = false,
    this.isInputPassword = false,
    this.outlineColor = const Color(0xFFFFB600),
    // this.keyboardType,
    this.suffixIconConstraints,
    this.texttype,
  }) : super(key: key);

  final TextEditingController datecontroller;
  final GestureTapCallback ontap;
  final dynamic validator;
  final TextEditingController? textEditingController;
  final Widget? leadingIcon;
  final bool eyeIcon;
  final Widget? suffixIcon;
  final bool isInputPassword;
  void Function(String)? onChanged;
  void Function()? onTap;
  final bool readonly;
  final dynamic inputFormatters;
  final Color outlineColor;
  final BoxConstraints? suffixIconConstraints;

  final TextInputType? texttype;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(
        fontSize: 16.sp,
      ),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: datecontroller,
      onTap: (() => ontap()),
      readOnly: true,
      cursorColor: const Color(0xFF3B3F43),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: 14.sp),
          contentPadding: EdgeInsets.all(17.h),
          filled: true,
          fillColor: const Color(0xFFF1F1F1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
                color: const Color(0xFF707070).withOpacity(0), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
                color: const Color(0xFF707070).withOpacity(0), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
                color: const Color(0xFF707070).withOpacity(0), width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 5.w),
            child: CircleAvatar(
              radius: 20.h,
              backgroundColor: const Color(0xffF1F1F1),
              child: Center(
                child: SvgPicture.asset(
                  "assets/images/datepicker.svg",
                  // width: 7.w,
                  // height: 7.h,
                ),
              ),
            ),
          ),
          hintStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Get.isDarkMode
                  ? Colors.white
                  : const Color(0xFF4D4D4D).withOpacity(0.3)),
          hintText: "Select Date"),
    );
  }
}
