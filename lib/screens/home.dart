import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_practice47_weather/config/colors.dart';
import 'package:flutter_practice47_weather/config/img_paths.dart';
import 'package:flutter_practice47_weather/config/widgets.dart';
import 'package:flutter_practice47_weather/models/daily_weather_info.dart';
import 'package:flutter_practice47_weather/services/api_requests.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "/home_screen";
  static bool isNight = true;
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with CustomWidgets {
  List<DailyWeatherInfo> listOfWeatherInfo = [];
  bool _hadAnError = false;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    DateTime currentTime = DateTime.now();
    if (currentTime.hour >= 6 && currentTime.hour <= 18) {
      setState(() {
        HomeScreen.isNight = false;
      });
    } else {
      setState(() {
        HomeScreen.isNight = true;
      });
    }
    getInfo();
    Timer(
      const Duration(milliseconds: 1900),
      () {
        if (listOfWeatherInfo.isNotEmpty) {
          setState(() {
            _isLoading = false;
          });
        }
      },
    );

    Timer(
      const Duration(seconds: 4),
      () {
        if (_isLoading == true) {
          setState(() {
            _isLoading = false;
            _hadAnError = true;
          });
        }
      },
    );
  }

  void getInfo() async {
    listOfWeatherInfo.clear();
    listOfWeatherInfo.addAll(await ApiRequests.GET());
  }

  String returnMonth(String value) {
    if ("${value[5]}" "${value[6]}" == "01") {
      return "January ${int.parse("${value[8]}${value[9]}")}";
    } else if ("${value[5]}" "${value[6]}" == "02") {
      return "February ${int.parse("${value[8]}${value[9]}")}";
    } else if ("${value[5]}" "${value[6]}" == "03") {
      return "March ${int.parse("${value[8]}${value[9]}")}";
    } else if ("${value[5]}" "${value[6]}" == "04") {
      return "April ${int.parse("${value[8]}${value[9]}")}";
    } else if ("${value[5]}" "${value[6]}" == "05") {
      return "May ${int.parse("${value[8]}${value[9]}")}";
    } else if ("${value[5]}" "${value[6]}" == "06") {
      return "June ${int.parse("${value[8]}${value[9]}")}";
    } else if ("${value[5]}" "${value[6]}" == "07") {
      return "July ${int.parse("${value[8]}${value[9]}")}";
    } else if ("${value[5]}" "${value[6]}" == "08") {
      return "August ${int.parse("${value[8]}${value[9]}")}";
    } else if ("${value[5]}" "${value[6]}" == "09") {
      return "September ${int.parse("${value[8]}${value[9]}")}";
    } else if ("${value[5]}" "${value[6]}" == "10") {
      return "October ${int.parse("${value[8]}${value[9]}")}";
    } else if ("${value[5]}" "${value[6]}" == "11") {
      return "November ${int.parse("${value[8]}${value[9]}")}";
    } else {
      return "December ${int.parse("${value[8]}${value[9]}")}";
    }
  }

  String returnImg(String weatherCondition) {
    if (weatherCondition.contains("clear")) {
      return ImgPaths.sun;
    } else if (weatherCondition.contains("rain")) {
      return ImgPaths.dayRain;
    } else if (weatherCondition.contains("snow")) {
      return ImgPaths.daySnow;
    } else if (weatherCondition.contains("wind")) {
      return ImgPaths.dayWindy;
    }
    return ImgPaths.dayCloud;
  }

  String getCurrentWeatherImgPath(String weatherCondition) {
    if (weatherCondition.contains("clear")) {
      if (HomeScreen.isNight) {
        return ImgPaths.moon;
      }
      return ImgPaths.sun;
    } else if (weatherCondition.contains("rain")) {
      if (HomeScreen.isNight) {
        return ImgPaths.nightRain;
      }
      return ImgPaths.dayRain;
    } else if (weatherCondition.contains("snow")) {
      if (HomeScreen.isNight) {
        return ImgPaths.nightSnow;
      }
      return ImgPaths.daySnow;
    } else if (weatherCondition.contains("wind")) {
      if (HomeScreen.isNight) {
        return ImgPaths.nightWindy;
      }
      return ImgPaths.dayWindy;
    }
    if (HomeScreen.isNight) {
      return ImgPaths.nightCloud;
    }
    return ImgPaths.dayCloud;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _hadAnError
          ? Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    colors: HomeScreen.isNight
                        ? ColorsClass.nightList
                        : ColorsClass.dayList),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                      image: const AssetImage(ImgPaths.noIdeaPerson),
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width / 1.5),
                  height(MediaQuery.of(context).size.width / 20),
                  customText(context, "Something went wrong"),
                  customText(context, "Try again!"),
                ],
              ))
          : Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    colors: HomeScreen.isNight
                        ? ColorsClass.nightList
                        : ColorsClass.dayList),
              ),
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        strokeAlign: MediaQuery.of(context).size.width / 58,
                        color: ColorsClass.white,
                      ),
                    )
                  : Column(
                      children: [
                        // Weather top part
                        Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Top text that shows the city
                                Text("Tashkent",
                                    style: TextStyle(
                                        color: ColorsClass.white,
                                        fontFamily: "Calistoga",
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                7)),
                                //Text that shows the current weather type in text form
                                customText(
                                    context, listOfWeatherInfo[0].conditions!),
                                height(MediaQuery.of(context).size.width / 30),
                                //Image that shows the current weather type in img form
                                Image(
                                    image: AssetImage(
                                      getCurrentWeatherImgPath(
                                          listOfWeatherInfo[0]
                                              .conditions!
                                              .toLowerCase()),
                                    ),
                                    fit: BoxFit.cover,
                                    height:
                                        MediaQuery.of(context).size.width / 4.4,
                                    width: MediaQuery.of(context).size.width /
                                        4.4),
                                //Image that shows the current
                                Text(listOfWeatherInfo[0].temp!.toString(),
                                    style: TextStyle(
                                        color: ColorsClass.white,
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                6,
                                        fontWeight: FontWeight.bold)),
                                customText(
                                    context,
                                    returnMonth(
                                        listOfWeatherInfo[0].datetime!)),
                              ],
                            )),
                        // Weather bottom part
                        Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                bottomWeeklyWeatherMaker(
                                  context,
                                  returnMonth(listOfWeatherInfo[0].datetime!),
                                  returnImg(listOfWeatherInfo[0]
                                      .conditions!
                                      .toLowerCase()),
                                  listOfWeatherInfo[0].temp!.toString(),
                                  listOfWeatherInfo[0].tempmin!.toString(),
                                ),
                                bottomWeeklyWeatherMaker(
                                  context,
                                  returnMonth(listOfWeatherInfo[1].datetime!),
                                  returnImg(listOfWeatherInfo[1]
                                      .conditions!
                                      .toLowerCase()),
                                  listOfWeatherInfo[1].temp!.toString(),
                                  listOfWeatherInfo[1].tempmin!.toString(),
                                ),
                                bottomWeeklyWeatherMaker(
                                  context,
                                  returnMonth(
                                    listOfWeatherInfo[2].datetime!,
                                  ),
                                  returnImg(listOfWeatherInfo[2]
                                      .conditions!
                                      .toLowerCase()),
                                  listOfWeatherInfo[2].temp!.toString(),
                                  listOfWeatherInfo[2].tempmin!.toString(),
                                ),
                                bottomWeeklyWeatherMaker(
                                  context,
                                  returnMonth(
                                    listOfWeatherInfo[3].datetime!,
                                  ),
                                  returnImg(listOfWeatherInfo[3]
                                      .conditions!
                                      .toLowerCase()),
                                  listOfWeatherInfo[3].temp!.toString(),
                                  listOfWeatherInfo[3].tempmin!.toString(),
                                ),
                                bottomWeeklyWeatherMaker(
                                  context,
                                  returnMonth(
                                    listOfWeatherInfo[4].datetime!,
                                  ),
                                  returnImg(listOfWeatherInfo[4]
                                      .conditions!
                                      .toLowerCase()),
                                  listOfWeatherInfo[4].temp!.toString(),
                                  listOfWeatherInfo[4].tempmin!.toString(),
                                ),
                                bottomWeeklyWeatherMaker(
                                  context,
                                  returnMonth(
                                    listOfWeatherInfo[5].datetime!,
                                  ),
                                  returnImg(listOfWeatherInfo[5]
                                      .conditions!
                                      .toLowerCase()),
                                  listOfWeatherInfo[5].temp!.toString(),
                                  listOfWeatherInfo[5].tempmin!.toString(),
                                ),
                                bottomWeeklyWeatherMaker(
                                    context,
                                    returnMonth(listOfWeatherInfo[6].datetime!),
                                    returnImg(listOfWeatherInfo[6]
                                        .conditions!
                                        .toLowerCase()),
                                    listOfWeatherInfo[6].temp!.toString(),
                                    listOfWeatherInfo[6].tempmin!.toString(),
                                    addBottomBorder: true),
                                height(MediaQuery.of(context).size.width / 16)
                              ],
                            )),
                      ],
                    ),
            ),
    );
  }
}
