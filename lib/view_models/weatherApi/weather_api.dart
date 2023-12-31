import 'dart:convert';

import 'package:dio/dio.dart';

import '../../Utils/base_manager.dart';

const String weatherApiKey = "d743674f9a39471fa10103429231810";

class WeatherApi {
  Dio dio = Dio();
  Future<ResponseData<dynamic>> getWeatherData(double lat, lng) async {
    try {
      var response = await dio.get(
        "http://api.weatherapi.com/v1/current.json?key=$weatherApiKey&q=$lat,$lng&aqi=yes",
      );
      // log(response.toString());
      final responseData = jsonDecode(response.toString());

      return ResponseData<dynamic>("success", ResponseStatus.SUCCESS,
          data: responseData);
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Oops something Went Wrong', ResponseStatus.FAILED);
    }
  }
}
