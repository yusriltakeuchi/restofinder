import 'package:flutter/material.dart';

//* Constant Color
Color primaryColor = Color(0xffFF8554);

//* Device size
double deviceWith(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}