class DailyWeatherInfo {
  String? datetime, conditions;
  double? temp, tempmin;
  List<dynamic>? preciptype;

  DailyWeatherInfo(this.datetime, this.temp, this.tempmin, this.preciptype, this.conditions);

  factory DailyWeatherInfo.fromJson(Map<String, dynamic> json) {
    return DailyWeatherInfo(
        json["datetime"], json["temp"], json["tempmin"], json["preciptype"] ?? ["cloud"], json["conditions"]);
  }
}
