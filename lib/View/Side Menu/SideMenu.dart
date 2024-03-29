import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/Utils/texts.dart';
import 'package:farm_flow_sales/View/Cart/cartmain.dart';
import 'package:farm_flow_sales/View/Connectfarmer.dart';
import 'package:farm_flow_sales/View/Order/ordersmain.dart';
import 'package:farm_flow_sales/View/dashboard.dart';
import 'package:farm_flow_sales/View/products.dart';
import 'package:farm_flow_sales/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../Common/dialog/exit_app_dialog.dart';
import 'side_bar.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu>
    with SingleTickerProviderStateMixin {
  bool isSideMenuClosed = true;
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;
  late bool logedIn;

  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  var screens = [
    const OrderMain(),
    const Productspage(),
    const Dashboard(),
    const Cartmain(),
    const Connectfarmer(),
  ];

  final items = <Widget>[
    Column(
      children: [
        Icon(
          Icons.home_rounded,
          size: 25.w,
          color: Colors.white,
        ),
        textBlack10("text")
      ],
    ),
    Icon(
      Icons.smart_display_outlined,
      color: Colors.white,
      size: 25.w,
    ),
    Icon(
      Icons.person_outlined,
      color: Colors.white,
      size: 25.w,
    ),
  ];

  List bottomBarData = [
    {"imageUrl": "assets/images/bottom_icon1.svg", "label": "Order"},
    {"imageUrl": "assets/images/bottom_icon2.svg", "label": "Products"},
    {"imageUrl": "assets/images/bottom_icon3.svg", "label": "Dashbaord"},
    {"imageUrl": "assets/images/bottom_icon4.svg", "label": "Cart"},
    {"imageUrl": "assets/images/bottom_icon5.svg", "label": "Connect"},
  ];

  DashboardController controller = Get.put(DashboardController());

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));

    Future.delayed(const Duration(microseconds: 100), () {
      controller.selectedIndex.value = Get.arguments ?? 2;
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // int activePage = 0;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () => backbuttonpressed(context),
        child: SafeArea(
          child: Scaffold(
              extendBody: true,
              body: Container(
                color: AppColors.transparent,
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.fastOutSlowIn,
                      left: isSideMenuClosed ? -300.w : 0,
                      width: 300.w,
                      height: MediaQuery.of(context).size.height,
                      child: const SideBar(),
                    ),
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(
                            animation.value - 30 * animation.value * pi / 180),
                      child: Transform.translate(
                        offset: Offset(animation.value * 300.w, 0),
                        child: Transform.scale(
                          scale: scaleAnimation.value,
                          child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(isSideMenuClosed ? 0 : 24)),
                              child: screens[controller.selectedIndex.value]
                              // const
                              // Center(child: Home()),
                              ),
                        ),
                      ),
                    ),
                    controller.selectedIndex.value == 2
                        ? AnimatedPositioned(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.fastOutSlowIn,
                            top: 5.h,
                            left: 4.w,
                            child: IconButton(
                              iconSize: 50.h,
                              onPressed: () {
                                if (isSideMenuClosed) {
                                  _animationController.forward();
                                } else {
                                  _animationController.reverse();
                                }
                                setState(() {
                                  isSideMenuClosed = !isSideMenuClosed;
                                });
                              },
                              icon: isSideMenuClosed
                                  ? Container(
                                      height: 42.h,
                                      width: 42.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25.h),
                                        color: AppColors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade400,
                                            blurRadius: 5.h,
                                            spreadRadius: 2.h,
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/images/menu.svg",
                                            height: 18.h,
                                            width: 18.h,
                                            color: AppColors.black,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Icon(
                                      Icons.cancel,
                                      size: 29.w,
                                      color: Colors.white,
                                    ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              bottomNavigationBar: isSideMenuClosed
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Container(
                        height: 70.h,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                blurRadius: 5.h,
                                spreadRadius: 2.h,
                              )
                            ],
                            borderRadius: BorderRadius.circular(35.h)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(bottomBarData.length,
                                  (index) => activeIcon(index))),
                        ),
                      ),
                    )
                  : const SizedBox()),
        ),
      ),
    );
  }

  Widget activeIcon(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          controller.selectedIndex.value = index;
        });
      },
      child: controller.selectedIndex.value == index
          ? Container(
              height: 50.h,
              width: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.h),
                color: AppColors.buttoncolour,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 22.h,
                    width: 22.h,
                    child: SvgPicture.asset(
                      bottomBarData[index]["imageUrl"],
                      color: AppColors.white,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 22.h,
                  width: 22.h,
                  child: SvgPicture.asset(
                    bottomBarData[index]["imageUrl"],
                    color: AppColors.buttoncolour,
                    fit: BoxFit.fill,
                  ),
                ),
                sizedBoxHeight(5.h),
                textGreen14(bottomBarData[index]["label"])
              ],
            ),
    );
  }

  Widget inactiveIcon(String imagePath) {
    return Column(children: [
      SvgPicture.asset(
        imagePath,
        height: 35.h,
        width: 35.h,
        color: AppColors.buttoncolour,
      ),
    ]);
  }
}
