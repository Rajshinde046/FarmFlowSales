import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Notification extends StatefulWidget {
  const Notification({Key? key}) : super(key: key);

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  List<Map<String, String>> _data = [];
  @override
  void initState() {
    _data = [
      {
        "image": "assets/images/Notification.svg",
        "title": "Your feed is getting low!.",
        "subtitle":
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        "text": "12.00 PM",
      },
      {
        "image": "assets/images/notificationtruck.svg",
        "title": "Order is arriving soon.",
        "subtitle":
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        "text": "11.00 PM",
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child:
            // CustomScrollView(
            //   slivers: [
            //     SliverToBoxAdapter(
            // child:
            SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 18.w, top: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                                color: const Color(0xFF141414),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Text(
                      "Notification",
                      style: TextStyle(
                          color: const Color(0xFF141414),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        "Yesterday",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.nunito(
                            fontSize: 22.sp,
                            color: Color(0xff131313),
                            fontWeight: FontWeight.w500),
                      )),
                ],
              ),
              sizedBoxHeight(15.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                _data[index]['image']!,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: 18.w,
                              ),
                              Expanded(
                                child: Text(
                                  _data[index]['subtitle']!,
                                  style: TextStyle(
                                    color: const Color(0xFF131313),
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                    // );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 40.h,
                      thickness: 1,
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text("Wednesday",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.nunito(
                            fontSize: 22.sp,
                            color: Color(0xff131313),
                            fontWeight: FontWeight.w500)
                        // TextStyle(
                        //     fontSize: 16.sp,
                        //     color: Colors.black,
                        //     fontWeight: FontWeight.w400),
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                _data[index]['image']!,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                width: 18.w,
                              ),
                              Expanded(
                                child: Text(
                                  _data[index]['subtitle']!,
                                  style: TextStyle(
                                    color: const Color(0xFF131313),
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                    // );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 40.h,
                      thickness: 1,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        // ),
        //],
        //),
      ),
    );
  }
}
