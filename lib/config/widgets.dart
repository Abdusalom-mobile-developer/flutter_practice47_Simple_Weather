import 'package:flutter/material.dart';
import 'package:flutter_practice47_weather/config/colors.dart';
import 'package:flutter_practice47_weather/screens/home.dart';

mixin CustomWidgets {
  // Custom Text maker widget
  Widget customText(BuildContext context, String text) {
    return Text(text,
        style: TextStyle(
            color: ColorsClass.white,
            fontSize: MediaQuery.of(context).size.width / 15));
  }

  // Custom Text maker 2 widget
  Widget customText2(BuildContext context, String text,
      {Color color = ColorsClass.white}) {
    return Text(text,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: MediaQuery.of(context).size.width / 17));
  }

  // Custom Height maker widget
  Widget height(double height) {
    return SizedBox(
      height: height,
    );
  }

  // Custom Width maker widget
  Widget width(double width) {
    return SizedBox(
      width: width,
    );
  }

  Widget bottomWeeklyWeatherMaker(BuildContext context, String weekday,
      String imagePath, String dayTemp, String nightTemp,
      {bool addBottomBorder = false}) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(
          color: HomeScreen.isNight ? ColorsClass.grey : ColorsClass.white,
          width: 2,
        ),
        bottom: addBottomBorder
            ? BorderSide(
                color:
                    HomeScreen.isNight ? ColorsClass.grey : ColorsClass.white,
                width: 2,
              )
            : BorderSide.none,
      )),
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 17),
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width / 50,
          horizontal: MediaQuery.of(context).size.width / 70),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customText2(context, weekday),
                Image(
                    image: AssetImage(
                      imagePath,
                    ),
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width / 12,
                    width: MediaQuery.of(context).size.width / 12),
              ],
            ),
          ),
          Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  customText2(context, dayTemp),
                  width(MediaQuery.of(context).size.width / 20),
                  customText2(
                    context,
                    nightTemp,
                    color: HomeScreen.isNight
                        ? ColorsClass.grey
                        : Colors.black.withOpacity(0.35),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
