import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/base_manager.dart';
import 'base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  Dio dio = Dio();

  getApiResponse() async {
    print("getApiResponse");
    var headers = {
      'Authorization':
          'Basic KzIkcVBiSlIzNncmaGUoalMmV0R6ZkpqdEVoSlVLVXA6dCRCZHEmSnQmc3Y0eUdqY0VVcTg5aEVZZHVSalhIMnU='
    };
    var data = FormData.fromMap(
        {'email': 'subfarmer@wdimails.com', 'password': 'User@123'});

    var dio = Dio();
    var response = await dio.request(
      'https://farmflow.betadelivery.com/api/login',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  String basicAuth = 'Basic ' +
      base64.encode(utf8.encode(
          '+2\$qPbJR36w&he(jS&WDzfJjtEhJUKUp:t\$Bdq&Jt&sv4yGjcEUq89hEYduRjXH2u'));
  @override
  Future<ResponseData> getApi(String url) async {
    if (kDebugMode) {
      print("api url is >>> $url");
    }
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token').toString();
    try {
      response = await dio.get(url,
          options: Options(headers: {
            'method': 'POST',
            "authorization": basicAuth,
            'access-token': token

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
            'authorization':
                "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiYjI0OTIzNTc0ZmVhZjM1MzA1ODE1ZGY4Y2FjNjU1MzVjYTgxMDU4YWM2NGI2ZjNkZjYxYjU4YTliNDlhM2EwOTAyZjQyY2ZmNTg0YTBiMTQiLCJpYXQiOjE2OTg3NDk0NzEuMzA0NjA5MDYwMjg3NDc1NTg1OTM3NSwibmJmIjoxNjk4NzQ5NDcxLjMwNDYxMDk2NzYzNjEwODM5ODQzNzUsImV4cCI6MTczMDM3MTg3MS4zMDMzODE5MTk4NjA4Mzk4NDM3NSwic3ViIjoiMTcyIiwic2NvcGVzIjpbIioiXX0.Hu49xgbGPnzh4U5kFF7xePfO4NhbnvT6gWzipfsrM_fGo57uAuJcN73DoX0ixMpycE7RP2t1uSxHk_mZumZ8aIeFA077zwDOz-irJOfEZjsjLuFJijet_LpMN6V56TvYRRN1F-sb1k8QJVuHJdp5tgNo40SLyLFSnxqzqmCuTEDrLGC5U7Gh2iRjnKWiFqrbOSbALyKi9If5KPH9ZtlOGqFAz3D64bb1dkw_wq8UO47enCGqedvJOwYiAYdIJD_UxmwBA1cUbYfz9w4EPyWlNrJ7iqrYu_I0dRTIwq0CeZ1X-L3G4H0f56NPoTsZAj_A0uxUeYan4Gbe32B_ebuLAmyXW0QyiBelfCmIOT3xxpqwLJdSBgG_evBQiQ3TNmwsfDNKQljCoiuU1qK0JqMrQVV_BICeuOYB_wMnBgg91Rf0TIt4knlGxyhQXLLQjdtKa41l-I4E8X7YEkDQbNnFbD4zAdgKd1KZi3zDdhQCoXGiwYuFHMorYvT_6GIiPYJsMpQV_B3C3pTcKcT-kC8tvtlnhRQLuOze0sRgkpACIccNCUPmq2dWzQTK7DWLqS3JNAaT-DOKuu7qfmlG9ZWwbAw5m-wYRveDTCAdFSkuxK30Jdsu9HOk9SRLnV7YCEe6LbonHO_5j7Ej10a3jR0RfiCC-mRjTL3E1sWhh0_1-5s",

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
  Future<ResponseData> postApi(data, String url) async {
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
          options: (token == null || token == "")
              ? Options(
                  headers: {
                    "Authorization":
                        "Basic KzIkcVBiSlIzNncmaGUoalMmV0R6ZkpqdEVoSlVLVXA6dCRCZHEmSnQmc3Y0eUdqY0VVcTg5aEVZZHVSalhIMnU=",
                  },
                )
              : Options(headers: {
                  "Authorization": "Bearer $token",
                  //'access-token': token,
                }));
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      return ResponseData<dynamic>("success", ResponseStatus.SUCCESS,
          data: response.data);
    } else if (response.statusCode == 203) {
      print(response.data);
      return ResponseData<dynamic>("success", ResponseStatus.PRIVATE,
          data: response.data);
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
  Future<ResponseData> deleteApi(String url) async {
    if (kDebugMode) {
      print("api url is >>> $url");
    }
    Response response;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token').toString();
    log(token);
    try {
      response = await dio.delete(url,
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
