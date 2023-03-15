import 'package:flutter/material.dart';

Widget addVerticalSpace(double height){
  return SizedBox(
    height:height
  );
}

Widget addHorizontalSpace(double width){
  return SizedBox(
      width:width
  );
}

double calculatePercentageDifference(double oldValue, double newValue) {
  double difference = newValue - oldValue;
  double percentageDifference = (difference / newValue) * 100;
  return percentageDifference;
}