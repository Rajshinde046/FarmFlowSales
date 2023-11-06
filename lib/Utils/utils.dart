import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' as getx;
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'dart:typed_data';
import 'package:farm_flow_sales/Utils/colors.dart';

class Utils {
  static Future<MultipartFile> networkImageToMultipartFile(
      String imageUrl) async {
    Dio dio = Dio();

    Response<Uint8List> response = await dio.get<Uint8List>(imageUrl,
        options: Options(responseType: ResponseType.bytes));

    MultipartFile multipartFile = MultipartFile.fromBytes(
      response.data!,
      filename: imageUrl.substring(imageUrl.lastIndexOf("/") + 1),
    );

    return multipartFile;
  }

  static Future<MultipartFile> assetImageToMultipartFile(
      String assetImagePath, String fileName) async {
    ByteData assetByteData = await rootBundle.load(assetImagePath);
    List<int> assetBytes = assetByteData.buffer.asUint8List();

    MultipartFile file = MultipartFile.fromBytes(
      assetBytes,
      filename: fileName,
    );

    return file;
  }

  static loader() {
    getx.Get.dialog(
      Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: WillPopScope(
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: AppColors.pistaE3FFE9,
                ),
              ],
            ),
            onWillPop: () async => false),
      ),
      barrierDismissible: false,
    );
  }

  static String formattedTimeAgo(String dateTime) {
    final dateTimeV = DateTime.parse(dateTime);
    final now = DateTime.now();
    final difference = now.difference(dateTimeV);
    return timeago.format(now.subtract(difference), locale: 'en');
  }

  static String formattedDate(String dateTime) {
    final inputDate = DateTime.parse(dateTime);
    return DateFormat('d MMM y').format(inputDate);
  }

  static String convertISOToFormattedDate(String isoDateString) {
    try {
      DateTime isoDate = DateTime.parse(isoDateString);

      String formattedDate = DateFormat('MM/dd/yyyy').format(isoDate);

      return formattedDate;
    } catch (e) {
      // Handle any errors, e.g., invalid date format
      return 'Invalid Date';
    }
  }
}