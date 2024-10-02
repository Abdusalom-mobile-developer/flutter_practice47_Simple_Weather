import 'package:flutter/material.dart';
import 'package:flutter_practice47_weather/config/colors.dart';
import 'package:flutter_practice47_weather/config/img_paths.dart';
import 'package:flutter_practice47_weather/config/texts.dart';
import 'package:flutter_practice47_weather/config/widgets.dart';

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
        child: Column(
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
                            fontSize: MediaQuery.of(context).size.width / 7)),
                    //Text that shows the current weather type in text form
                    customText(context, "Clear"),
                    height(MediaQuery.of(context).size.width / 30),
                    //Image that shows the current weather type in img form
                    Image(
                        image: const AssetImage(
                          ImgPaths.nightCloud,
                        ),
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.width / 4.4,
                        width: MediaQuery.of(context).size.width / 4.4),
                    //Image that shows the current
                    Text("11",
                        style: TextStyle(
                            color: ColorsClass.white,
                            fontSize: MediaQuery.of(context).size.width / 6,
                            fontWeight: FontWeight.bold)),
                    customText(context, "October 02, 2024"),
                  ],
                )),
            // Weather bottom part
            Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    bottomWeeklyWeatherMaker(
                        context, Texts.monday, ImgPaths.dayCloud, "26", "19"),
                    bottomWeeklyWeatherMaker(
                        context, Texts.tuesday, ImgPaths.sun, "20", "13"),
                    bottomWeeklyWeatherMaker(context, Texts.wednesday,
                        ImgPaths.dayWindy, "23", "16"),
                    bottomWeeklyWeatherMaker(
                        context, Texts.thursday, ImgPaths.dayRain, "18", "09"),
                    bottomWeeklyWeatherMaker(
                        context, Texts.friday, ImgPaths.sun, "28", "22"),
                    bottomWeeklyWeatherMaker(
                      context,
                      Texts.saturday,
                      ImgPaths.daySnow,
                      "13",
                      "02",
                    ),
                    bottomWeeklyWeatherMaker(
                        context, Texts.sunday, ImgPaths.dayCloud, "13", "05",
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
