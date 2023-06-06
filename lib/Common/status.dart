import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget status() {
  return Column(
    children: [
      CircularPercentIndicator(
        center: CircleAvatar(
          radius: 5.h,
          backgroundColor: AppColors.buttoncolour,
          child: const SizedBox(),
        ),
        radius: 10.h,
        lineWidth: 1,
        backgroundColor: const Color(0XFFACC8A8),
      )
    ],
  );
}
