import 'dart:convert';
import 'dart:developer';

import 'package:farm_flow_sales/Utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/base_manager.dart';
import '../../View/ErrorScreen/error_screen.dart';
import 'base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  Dio dio = Dio();

  String basicAuth = 'Basic ' +
      base64.encode(utf8.encode(
          '+2\$qPbJR36w&he(jS&WDzfJjtEhJUKUp:t\$Bdq&Jt&sv4yGjcEUq89hEYduRjXH2u'));

  @override
  Future<ResponseData> getApi1(String url) async {
    if (kDebugMode) {
      print("api url is >>> $url");
    }
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token').toString();
    log(token);
    try {
      response = await dio.get(url,
          options: Options(headers: {
            'authorization': "Bearer $token",

            // "device-id": deviceId
          }));
      log(response.toString());
    } on Exception catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 403) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', "");
          Get.offAndToNamed("/loginScreen");
        } else if (e.response!.statusCode == 500) {
          Get.to(() => const ErrorScreen());
        }
      }

      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }
    if (response.statusCode == 200) {
      return ResponseData<dynamic>(
        "success",
        data: response.data,
        ResponseStatus.SUCCESS,
      );
    } else if (response.statusCode == 403) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', "");
      Get.offAndToNamed("/loginScreen");
      return ResponseData<dynamic>(
          response.statusMessage!, ResponseStatus.FAILED);
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

  @override
  Future<ResponseData> postApi(data, String url,
      {bool optionalpar = false}) async {
    if (kDebugMode) {
      print("data >>> $data");
      print("api url is >>> $url");
    }
    Response response;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      response = await dio.post(url,
          data: data,
          options: optionalpar
              ? Options(
                  headers: {
                    "authorization": basicAuth,
                  },
                )
              : (token == null || token == "")
                  ? Options(
                      headers: {
                        "authorization": basicAuth,
                      },
                    )
                  : Options(headers: {
                      "Authorization": "Bearer $token",
                      //'access-token': token,
                    }));
    } on Exception catch (e) {
      if (e is DioException) {
        if (e.response!.statusCode == 403) {
          Get.back();
          Map<String, dynamic> responseData =
              Map<String, dynamic>.from(e.response!.data);
          if (responseData["message"] == "Kindly Contact your Co-Op") {
            Get.dialog(Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.warning,
                            color: AppColors.buttoncolour,
                            size: 40,
                          ),
                          Expanded(
                            child: Text(
                              "Access Denied",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        responseData["message"],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                      const Spacer(),
                      const Divider(
                        color: AppColors.buttoncolour,
                        height: 15,
                      ),
                      SizedBox(
                        width: 320.0,
                        child: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "OK",
                            style: GoogleFonts.montserrat(
                              color: AppColors.buttoncolour,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
          } else {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('token', "");
            Get.offAndToNamed("/loginScreen");
          }
        } else if (e.response!.statusCode == 500) {
          Get.to(() => const ErrorScreen());
        }
      }
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      return ResponseData<dynamic>("success", ResponseStatus.SUCCESS,
          data: response.data);
    } else if (response.statusCode == 201) {
      return ResponseData<dynamic>("success", ResponseStatus.SUCCESS,
          data: response.data);
    } else if (response.statusCode == 203) {
      print(response.data);
      return ResponseData<dynamic>("success", ResponseStatus.PRIVATE,
          data: response.data);
    } else if (response.statusCode == 403) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', "");
      Get.offAndToNamed("/loginScreen");
      return ResponseData<dynamic>(
          response.statusMessage!, ResponseStatus.FAILED);
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }

  @override
  Future<ResponseData> deleteApi(String url, data) async {
    if (kDebugMode) {
      print("api url is >>> $url");
    }
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token').toString();
    log(token);
    try {
      response = await dio.delete(url,
          data: data,
          options: Options(headers: {
            'authorization': "Bearer $token",

            // "device-id": deviceId
          }));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }
    if (response.statusCode == 200) {
      return ResponseData<dynamic>(
        "success",
        data: response.data,
        ResponseStatus.SUCCESS,
      );
    } else if (response.statusCode == 403) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', "");
      Get.offAndToNamed("/loginScreen");
      return ResponseData<dynamic>(
          response.statusMessage!, ResponseStatus.FAILED);
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }
}
