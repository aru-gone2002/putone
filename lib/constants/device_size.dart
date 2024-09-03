import 'package:flutter/material.dart';

class DeviceSize {
  static late Size size;
  static late double screenWidth;
  static late double screenHeight;
  static late double screenWidthWithPadding;

  void init(BuildContext context) {
    size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    screenWidthWithPadding = screenWidth - 56;
  }
}
