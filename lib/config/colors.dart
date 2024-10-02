import 'package:flutter/material.dart';

class ColorsClass {
  static const Color morningTop = Color.fromRGBO(188, 44, 53, 1);
  static const Color morningBottom = Color.fromRGBO(241, 177, 75, 1);
  static const Color dayTop = Color.fromRGBO(47, 44, 188, 1);
  static const Color dayBottom = Color.fromRGBO(75, 181, 241, 1);
  static const Color nightTop = Color.fromRGBO(6, 5, 14, 1);
  static const Color nightBottom = Color.fromRGBO(34, 48, 118, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color grey = Color.fromRGBO(168, 168, 168, 1);
  // static const Color grey = Colors.white54;

  static const dayList = [ColorsClass.dayTop, ColorsClass.dayBottom];
  static const morningList = [
    ColorsClass.morningTop,
    ColorsClass.morningBottom
  ];
  static const nightList = [ColorsClass.nightTop, ColorsClass.nightBottom];
  
}
