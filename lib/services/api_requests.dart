// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter_practice47_weather/models/daily_weather_info.dart';
import 'package:flutter_practice47_weather/services/log_service.dart';
import 'package:http/http.dart';

class ApiRequests {
  static Future<List<DailyWeatherInfo>> GET() async {
    List<DailyWeatherInfo> list = [];
    final response = await get(Uri.parse(
        "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Tashkent?unitGroup=metric&include=days&key=ZSHHM497RFY6TDYWX8QS5HZ9B&contentType=json"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var weatherInfo = data["days"];
  
      for (var elem in weatherInfo) {
       list.add(DailyWeatherInfo.fromJson(elem));
      }
      
      return list;
    } else {
      LogService.w(response.statusCode.toString());
      return [];
    }
  }
}
