import 'package:farm_flow_sales/Common/custom_appbar.dart';
import 'package:farm_flow_sales/Model/contactListModel/contact_list_model.dart';
import 'package:farm_flow_sales/Utils/api_urls.dart';
import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:farm_flow_sales/Utils/sized_box.dart';
import 'package:farm_flow_sales/view_models/contactUsApi/contact_us_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  RxBool isLoading = true.obs;
  ContactListModel contactListModel = ContactListModel();
  @override
  void initState() {
    ContactUsAPI().getContactListApi().then((value) {
      contactListModel = ContactListModel.fromJson(value.data);
      isLoading.value = false;
    });
    super.initState();
  }

  buildcontentcalldialog(
    context,
    String number,
    String type,
  ) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            backgroundColor:
                Get.isDarkMode ? Colors.black : const Color(0XFFFFFFFF),
            //contentPadding: EdgeInsets.fromLTRB(96, 32, 96, 28),
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              side: BorderSide(
                  color:
                      Get.isDarkMode ? Colors.grey : const Color(0XFFFFFFFF)),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //sizedBoxHeight(32.h),
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/images/contactphone.svg",
                    // "assets/images/call.svg",
                    width: 35.w,
                    height: 35.h,
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Are you sure you want to call $type?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                sizedBoxHeight(21.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        launch("tel://$number");
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.buttoncolour),
                        child: Center(
                          child: Text(
                            "Yes",
                            style: TextStyle(
                                color: AppColors.white, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0XFF0E5F02)),
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.white),
                        child: Center(
                          child: Text(
                            "No",
                            style: TextStyle(
                                color: AppColors.buttoncolour, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildcontentmaildialog(context, String email) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            backgroundColor:
                Get.isDarkMode ? Colors.black : const Color(0XFFFFFFFF),
            //contentPadding: EdgeInsets.fromLTRB(96, 32, 96, 28),
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              side: BorderSide(
                  color:
                      Get.isDarkMode ? Colors.grey : const Color(0XFFFFFFFF)),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBoxHeight(22.h),
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    "assets/images/sendmail.svg",
                    width: 35.w,
                    height: 35.h,
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Send the mail request",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF4D4D4D),
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                sizedBoxHeight(31.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        launch("mailto:$email");
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.buttoncolour),
                        child: Center(
                          child: Text(
                            "Yes",
                            style: TextStyle(
                                color: AppColors.white, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                    const Gap(15),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0XFF0E5F02)),
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.white),
                        child: Center(
                          child: Text(
                            "No",
                            style: TextStyle(
                                color: AppColors.buttoncolour, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildcontentdialog(
    String name,
    String profileImage,
    String phoneNo,
    String email,
    String type,
  ) {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            backgroundColor:
                Get.isDarkMode ? Colors.black : const Color(0XFFFFFFFF),
            //    contentPadding: EdgeInsets.fromLTRB(96, 32, 96, 28),
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              side: BorderSide(
                  color:
                      Get.isDarkMode ? Colors.grey : const Color(0XFFFFFFFF)),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //sizedBoxHeight(32.h),
                profileImage.isEmpty
                    ? Image.asset(
                        "assets/images/Contactoerson.png",
                        // "assets/images/person.png",
                        width: 76.w,
                        height: 76.h,
                      )
                    : Image.network(
                        "${ApiUrls.baseImageUrl}/$profileImage",
                        // "assets/images/person.png",
                        width: 76.w,
                        height: 76.h,
                      ),
                SizedBox(
                  height: 11.h,
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/call.svg",
                      width: 19.w,
                      height: 18.h,
                    ),
                    sizedBoxWidth(5.w),
                    Text(
                      phoneNo,
                      style: TextStyle(
                        color: const Color(0XFF585858),
                        fontSize: 20.sp,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/mail.svg",
                    ),
                    sizedBoxWidth(5.w),
                    Text(
                      email,
                      maxLines: 2,
                      style: TextStyle(
                        color: const Color(0XFF585858),
                        fontSize: 16.sp,
                      ),
                    )
                  ],
                ),
                sizedBoxHeight(25.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        buildcontentcalldialog(context, phoneNo, type);
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.buttoncolour),
                        child: Center(
                          child: Text(
                            "Call",
                            style: TextStyle(
                                color: AppColors.white, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                    sizedBoxWidth(15),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        buildcontentmaildialog(context, email);
                      },
                      child: Container(
                        height: 48.h,
                        width: 140.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.buttoncolour),
                            borderRadius: BorderRadius.circular(10.h),
                            color: AppColors.white),
                        child: Center(
                          child: Text(
                            "Mail",
                            style: TextStyle(
                                color: AppColors.black, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int isConnect = 0;
  int isConnect2 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: AppColors.white,
        title: customAppBar(text: "Contacts"),

        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        // shadowColor: Colors.black,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
      ),
      body: Obx(
        () => isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.buttoncolour,
                ),
              )
            : SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 25, bottom: 25),
                      child: Column(
                        children: [
                          Visibility(
                            visible:
                                contactListModel.data!.deliveryAgents!.isEmpty
                                    ? false
                                    : true,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Delivery Agent",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.sp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible:
                                contactListModel.data!.deliveryAgents!.isEmpty
                                    ? false
                                    : true,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: contactListModel
                                    .data!.deliveryAgents!.length,
                                itemBuilder: (ctx, index) {
                                  return InkWell(
                                    onTap: () {
                                      buildcontentdialog(
                                          contactListModel.data!
                                              .deliveryAgents![index].userName!,
                                          contactListModel
                                              .data!
                                              .deliveryAgents![index]
                                              .profilePhoto!,
                                          contactListModel
                                              .data!
                                              .deliveryAgents![index]
                                              .phoneNumber!,
                                          contactListModel
                                              .data!
                                              .deliveryAgents![index]
                                              .emailAddress!,
                                          "Delivery Agent");
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        border: Border.all(
                                            color: const Color(0XFf0E5F02)
                                                .withOpacity(1),
                                            width: 1),
                                        color: const Color(0xFFFFFFFF),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 11.h,
                                          ),
                                          Row(
                                            //mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 16.w),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100), //<-- SEE HERE
                                                  ),
                                                  child: contactListModel
                                                          .data!
                                                          .deliveryAgents![
                                                              index]
                                                          .profilePhoto!
                                                          .isEmpty
                                                      ? Image.asset(
                                                          "assets/images/Contactoerson.png",
                                                          width: 66.w,
                                                          height: 66.w,
                                                        )
                                                      : Image.network(
                                                          "${ApiUrls.baseImageUrl}/${contactListModel.data!.deliveryAgents![index].profilePhoto}",
                                                          width: 66.w,
                                                          height: 66.w,
                                                        ),
                                                ),
                                              ),
                                              sizedBoxWidth(8.w),
                                              SizedBox(
                                                width: 195.w,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    RichText(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      text: TextSpan(
                                                        text: contactListModel
                                                            .data!
                                                            .deliveryAgents![
                                                                index]
                                                            .userName,
                                                        // "Roma dsouza",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          "assets/images/call.svg",
                                                          width: 13.w,
                                                          height: 13.w,
                                                        ),
                                                        sizedBoxWidth(5.w),
                                                        RichText(
                                                          text: TextSpan(
                                                            text: contactListModel
                                                                .data!
                                                                .deliveryAgents![
                                                                    index]
                                                                .phoneNumber,
                                                            // "0225845855",
                                                            style: TextStyle(
                                                              color: const Color(
                                                                  0XFF585858),
                                                              fontSize: 16.sp,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 3.h),
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/images/locationconnect.svg",
                                                            // "assets/images/mail.png",
                                                            width: 18.w,
                                                            height: 18.h,
                                                          ),
                                                        ),
                                                        sizedBoxWidth(5.w),
                                                        RichText(
                                                          text: TextSpan(
                                                            text:
                                                                "Newton, Athenry",
                                                            // "Canada",
                                                            style: TextStyle(
                                                              color: const Color(
                                                                  0XFF585858),
                                                              fontSize: 16.sp,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 11.h,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          contactListModel.data!.deliveryAgents!.isEmpty
                              ? const SizedBox()
                              : sizedBoxHeight(15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Co-op",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              buildcontentdialog(
                                  contactListModel.data!.coop!.userName!,
                                  contactListModel.data!.coop!.profilePhoto!,
                                  contactListModel.data!.coop!.phoneNumber!,
                                  contactListModel.data!.coop!.emailAddress!,
                                  "Co-op");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
                                border: Border.all(
                                    color:
                                        const Color(0XFf0E5F02).withOpacity(1),
                                    width: 1),
                                color: const Color(0xFFFFFFFF),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 11.h,
                                  ),
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 16.w),
                                        child: contactListModel.data!.coop!
                                                .profilePhoto!.isEmpty
                                            ? Image.asset(
                                                "assets/images/Contactoerson.png",
                                                // image,
                                                // "assets/images/connect2.png",
                                                width: 66.w,
                                                height: 66.w,
                                              )
                                            : Image.network(
                                                "${ApiUrls.baseImageUrl}/${contactListModel.data!.coop!.profilePhoto}",
                                                // image,
                                                // "assets/images/connect2.png",
                                                width: 66.w,
                                                height: 66.w,
                                              ),
                                      ),

                                      sizedBoxWidth(8.w),

                                      SizedBox(
                                        width: 195.w,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            RichText(
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(
                                                text: contactListModel
                                                    .data!.coop!.userName,
                                                // "Roma dsouza",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/images/call.svg",
                                                  width: 13.w,
                                                  height: 13.w,
                                                ),
                                                sizedBoxWidth(5.w),
                                                RichText(
                                                  text: TextSpan(
                                                    text: contactListModel.data!
                                                        .coop!.phoneNumber,
                                                    // "0225845855",
                                                    style: TextStyle(
                                                      color: const Color(
                                                          0XFF585858),
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 3.h),
                                                  child: Image.asset(
                                                    "assets/images/mail.png",
                                                    width: 13.w,
                                                    height: 13.h,
                                                  ),
                                                  // SvgPicture.asset(
                                                  //   "assets/images/mail.svg",
                                                  //   width: 13.w,
                                                  //   height: 13.w,
                                                  // ),
                                                ),
                                                sizedBoxWidth(5.w),
                                                SizedBox(
                                                  width: Get.width / 2.3,
                                                  child: RichText(
                                                    maxLines: 2,
                                                    text: TextSpan(
                                                      text: contactListModel
                                                          .data!
                                                          .coop!
                                                          .emailAddress,
                                                      // "Canada",
                                                      style: TextStyle(
                                                        color: const Color(
                                                            0XFF585858),
                                                        fontSize: 16.sp,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      // sizedBoxWidth(16.w),

                                      // Row(
                                      //     mainAxisAlignment: MainAxisAlignment.end,
                                      //     children: [
                                      //       IconButton(
                                      //         icon: isConnect == 0
                                      //             // _isChecked
                                      //             ? CircleAvatar(
                                      //                 radius: 25.h,
                                      //                 backgroundColor: Color(0XFFF1F1F1),
                                      //                 child: Icon(
                                      //                   Icons.star,
                                      //                   color: Colors.amber,
                                      //                 ),
                                      //               )
                                      //             : Icon(
                                      //                 Icons.star_border,
                                      //                 color: Color(0XFF707070),
                                      //               ),
                                      //         onPressed: () {
                                      //           setState(() {
                                      //             isConnect == 0
                                      //                 ? isConnect = 1
                                      //                 : isConnect = 0;
                                      //             // _isChecked = !_isChecked;
                                      //           });
                                      //         },
                                      //       ),
                                      //     ]),

                                      // SvgPicture.asset(
                                      //   "assets/images/starconnect.svg",
                                      //   width: 38.w,
                                      //   height: 38.w,
                                      // ),

                                      // CircleAvatar(
                                      //   radius: 25.h,
                                      //   backgroundColor: Color(0XFFF1F1F1),
                                      //   child: Center(
                                      //     child: Icon(
                                      //       Icons.star,
                                      //       size: 35.h,
                                      //       color: Color.fromARGB(255, 248, 211, 2),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 11.h,
                                  )
                                ],
                              ),
                            ),
                          ),
                          // sizedBoxHeight(15),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       "Warehouse Manager",
                          //       style: GoogleFonts.poppins(
                          //         textStyle: TextStyle(
                          //             fontWeight: FontWeight.w500,
                          //             fontSize: 18.sp),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // InkWell(
                          //   onTap: () {
                          //     buildcontentdialog();
                          //   },
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       borderRadius:
                          //           const BorderRadius.all(Radius.circular(15)),
                          //       border: Border.all(
                          //           color:
                          //               const Color(0XFf0E5F02).withOpacity(1),
                          //           width: 1),
                          //       color: const Color(0xFFFFFFFF),
                          //     ),
                          //     child: Column(
                          //       children: [
                          //         SizedBox(
                          //           height: 11.h,
                          //         ),
                          //         Row(
                          //           //mainAxisAlignment: MainAxisAlignment.start,
                          //           children: [
                          //             Padding(
                          //               padding: EdgeInsets.only(left: 16.w),
                          //               child: Image.asset(
                          //                 "assets/images/Contactoerson.png",
                          //                 // image,
                          //                 // "assets/images/connect2.png",
                          //                 width: 66.w,
                          //                 height: 66.w,
                          //               ),
                          //             ),

                          //             sizedBoxWidth(8.w),

                          //             SizedBox(
                          //               width: 195.w,
                          //               child: Column(
                          //                 crossAxisAlignment:
                          //                     CrossAxisAlignment.start,
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.start,
                          //                 children: [
                          //                   RichText(
                          //                     overflow: TextOverflow.ellipsis,
                          //                     text: TextSpan(
                          //                       text: "Abigail Laus",
                          //                       // "Roma dsouza",
                          //                       style: TextStyle(
                          //                         color: Colors.black,
                          //                         fontSize: 16.sp,
                          //                         fontWeight: FontWeight.w600,
                          //                       ),
                          //                     ),
                          //                   ),
                          //                   Row(
                          //                     children: [
                          //                       SvgPicture.asset(
                          //                         "assets/images/call.svg",
                          //                         width: 13.w,
                          //                         height: 13.w,
                          //                       ),
                          //                       sizedBoxWidth(5.w),
                          //                       RichText(
                          //                         text: TextSpan(
                          //                           text: "0825463597",
                          //                           // "0225845855",
                          //                           style: TextStyle(
                          //                             color: const Color(
                          //                                 0XFF585858),
                          //                             fontSize: 16.sp,
                          //                           ),
                          //                         ),
                          //                       )
                          //                     ],
                          //                   ),
                          //                   Row(
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.center,
                          //                     children: [
                          //                       Padding(
                          //                         padding:
                          //                             EdgeInsets.only(top: 3.h),
                          //                         child: Image.asset(
                          //                           "assets/images/mail.png",
                          //                           width: 13.w,
                          //                           height: 13.h,
                          //                         ),
                          //                         // SvgPicture.asset(
                          //                         //   "assets/images/mail.svg",
                          //                         //   width: 20.w,
                          //                         //   height: 20.w,
                          //                         // ),
                          //                       ),
                          //                       sizedBoxWidth(5.w),
                          //                       RichText(
                          //                         text: TextSpan(
                          //                           text: "abigail@gmail.com",
                          //                           // "Canada",
                          //                           style: TextStyle(
                          //                             color: const Color(
                          //                                 0XFF585858),
                          //                             fontSize: 16.sp,
                          //                           ),
                          //                         ),
                          //                       )
                          //                     ],
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),

                          //             // sizedBoxWidth(16.w),

                          //             // Row(
                          //             //     mainAxisAlignment: MainAxisAlignment.end,
                          //             //     children: [
                          //             //       IconButton(
                          //             //         icon: isConnect == 0
                          //             //             // _isChecked
                          //             //             ? CircleAvatar(
                          //             //                 radius: 25.h,
                          //             //                 backgroundColor: Color(0XFFF1F1F1),
                          //             //                 child: Icon(
                          //             //                   Icons.star,
                          //             //                   color: Colors.amber,
                          //             //                 ),
                          //             //               )
                          //             //             : Icon(
                          //             //                 Icons.star_border,
                          //             //                 color: Color(0XFF707070),
                          //             //               ),
                          //             //         onPressed: () {
                          //             //           setState(() {
                          //             //             isConnect == 0
                          //             //                 ? isConnect = 1
                          //             //                 : isConnect = 0;
                          //             //             // _isChecked = !_isChecked;
                          //             //           });
                          //             //         },
                          //             //       ),
                          //             //     ]),
                          //           ],
                          //         ),
                          //         SizedBox(
                          //           height: 11.h,
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // sizedBoxHeight(15),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       "Inventory Manager Contact",
                          //       style: GoogleFonts.poppins(
                          //         textStyle: TextStyle(
                          //             fontWeight: FontWeight.w500,
                          //             fontSize: 18.sp),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // InkWell(
                          //   onTap: () {
                          //     buildcontentdialog();
                          //   },
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       borderRadius:
                          //           const BorderRadius.all(Radius.circular(15)),
                          //       border: Border.all(
                          //           color:
                          //               const Color(0XFf0E5F02).withOpacity(1),
                          //           width: 1),
                          //       color: const Color(0xFFFFFFFF),
                          //     ),
                          //     child: Column(
                          //       children: [
                          //         SizedBox(
                          //           height: 11.h,
                          //         ),
                          //         Row(
                          //           //mainAxisAlignment: MainAxisAlignment.start,
                          //           children: [
                          //             Padding(
                          //               padding: EdgeInsets.only(left: 16.w),
                          //               child: Image.asset(
                          //                 "assets/images/Contactoerson.png",
                          //                 // image,
                          //                 // "assets/images/connect2.png",
                          //                 width: 66.w,
                          //                 height: 66.w,
                          //               ),
                          //             ),

                          //             sizedBoxWidth(8.w),

                          //             SizedBox(
                          //               width: 195.w,
                          //               child: Column(
                          //                 crossAxisAlignment:
                          //                     CrossAxisAlignment.start,
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.start,
                          //                 children: [
                          //                   RichText(
                          //                     overflow: TextOverflow.ellipsis,
                          //                     text: TextSpan(
                          //                       text: "James Seymour",
                          //                       // "Roma dsouza",
                          //                       style: TextStyle(
                          //                         color: Colors.black,
                          //                         fontSize: 16.sp,
                          //                         fontWeight: FontWeight.w600,
                          //                       ),
                          //                     ),
                          //                   ),
                          //                   Row(
                          //                     children: [
                          //                       SvgPicture.asset(
                          //                         "assets/images/call.svg",
                          //                         width: 13.w,
                          //                         height: 13.w,
                          //                       ),
                          //                       sizedBoxWidth(5.w),
                          //                       RichText(
                          //                         text: TextSpan(
                          //                           text: "085634826",
                          //                           // "0225845855",
                          //                           style: TextStyle(
                          //                             color: const Color(
                          //                                 0XFF585858),
                          //                             fontSize: 16.sp,
                          //                           ),
                          //                         ),
                          //                       )
                          //                     ],
                          //                   ),
                          //                   Row(
                          //                     crossAxisAlignment:
                          //                         CrossAxisAlignment.center,
                          //                     children: [
                          //                       Padding(
                          //                         padding:
                          //                             EdgeInsets.only(top: 3.h),
                          //                         child: Image.asset(
                          //                           "assets/images/mail.png",
                          //                           width: 13.w,
                          //                           height: 13.h,
                          //                         ),
                          //                         // SvgPicture.asset(
                          //                         //   "assets/images/mail.svg",
                          //                         //   width: 20.w,
                          //                         //   height: 20.w,
                          //                         // ),
                          //                       ),
                          //                       sizedBoxWidth(5.w),
                          //                       RichText(
                          //                         text: TextSpan(
                          //                           text: "james@gmail.com",
                          //                           // "Canada",
                          //                           style: TextStyle(
                          //                             color: const Color(
                          //                                 0XFF585858),
                          //                             fontSize: 16.sp,
                          //                           ),
                          //                         ),
                          //                       )
                          //                     ],
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),

                          //             // sizedBoxWidth(16.w),

                          //             // Row(
                          //             //     mainAxisAlignment: MainAxisAlignment.end,
                          //             //     children: [
                          //             //       IconButton(
                          //             //         icon: isConnect == 0
                          //             //             // _isChecked
                          //             //             ? CircleAvatar(
                          //             //                 radius: 25.h,
                          //             //                 backgroundColor: Color(0XFFF1F1F1),
                          //             //                 child: Icon(
                          //             //                   Icons.star,
                          //             //                   color: Colors.amber,
                          //             //                 ),
                          //             //               )
                          //             //             : Icon(
                          //             //                 Icons.star_border,
                          //             //                 color: Color(0XFF707070),
                          //             //               ),
                          //             //         onPressed: () {
                          //             //           setState(() {
                          //             //             isConnect == 0
                          //             //                 ? isConnect = 1
                          //             //                 : isConnect = 0;
                          //             //             // _isChecked = !_isChecked;
                          //             //           });
                          //             //         },
                          //             //       ),
                          //             //     ]),
                          //           ],
                          //         ),
                          //         SizedBox(
                          //           height: 11.h,
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // sizedBoxHeight(10.h),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
