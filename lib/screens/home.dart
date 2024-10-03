import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_practice47_weather/config/colors.dart';
import 'package:flutter_practice47_weather/config/img_paths.dart';
import 'package:flutter_practice47_weather/config/texts.dart';
import 'package:flutter_practice47_weather/config/widgets.dart';
import 'package:flutter_practice47_weather/models/daily_weather_info.dart';
import 'package:flutter_practice47_weather/services/api_requests.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "/home_screen";
  static bool isNight = false;
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with CustomWidgets {
  List<DailyWeatherInfo> listOfWeatherInfo = [];
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
      const Duration(seconds: 2),
      () {
        if (listOfWeatherInfo.isNotEmpty) {
          setState(() {
            _isLoading = false;
          });
        }
      },
    );
  }

  void getInfo() async {
    listOfWeatherInfo.clear();
    listOfWeatherInfo.addAll(await ApiRequests.GET());
  }

  String getCurrentWeatherImgPath() {
    String weatherType = listOfWeatherInfo[0].preciptype!.first;
    String condition = listOfWeatherInfo[0].conditions!;
    if (weatherType == "cloud") {
      if (condition == "clear") {
        return ImgPaths.sun;
      }
      return ImgPaths.dayCloud;
    } else if (weatherType == "rain") {
      return ImgPaths.dayRain;
    }
    return ImgPaths.dayWindy;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              colors: HomeScreen.isNight
                  ? ColorsClass.nightList
                  : ColorsClass.dayList),
        ),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
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
                                      MediaQuery.of(context).size.width / 7)),
                          //Text that shows the current weather type in text form
                          customText(context, listOfWeatherInfo[0].conditions!),
                          height(MediaQuery.of(context).size.width / 30),
                          //Image that shows the current weather type in img form
                          Image(
                              image: AssetImage(
                                getCurrentWeatherImgPath(),
                              ),
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.width / 4.4,
                              width: MediaQuery.of(context).size.width / 4.4),
                          //Image that shows the current
                          Text(listOfWeatherInfo[0].temp!.toString(),
                              style: TextStyle(
                                  color: ColorsClass.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width / 6,
                                  fontWeight: FontWeight.bold)),
                          customText(context, listOfWeatherInfo[0].datetime!),
                        ],
                      )),
                  // Weather bottom part
                  Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          bottomWeeklyWeatherMaker(context, Texts.monday,
                              ImgPaths.dayCloud, "26", "19"),
                          bottomWeeklyWeatherMaker(
                              context, Texts.tuesday, ImgPaths.sun, "20", "13"),
                          bottomWeeklyWeatherMaker(context, Texts.wednesday,
                              ImgPaths.dayWindy, "23", "16"),
                          bottomWeeklyWeatherMaker(context, Texts.thursday,
                              ImgPaths.dayRain, "18", "09"),
                          bottomWeeklyWeatherMaker(
                              context, Texts.friday, ImgPaths.sun, "28", "22"),
                          bottomWeeklyWeatherMaker(
                            context,
                            Texts.saturday,
                            ImgPaths.daySnow,
                            "13",
                            "02",
                          ),
                          bottomWeeklyWeatherMaker(context, Texts.sunday,
                              ImgPaths.dayCloud, "13", "05",
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
