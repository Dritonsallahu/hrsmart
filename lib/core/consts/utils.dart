import 'dart:io';

import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String getDateFormat(String updatedAt) {
  // Parse the input date string
  DateTime parsedDate = DateTime.parse(updatedAt).add(const Duration(hours: 2));
  String time = DateFormat("HH:mm:ss").format(parsedDate);
  String myDate =
      "${getMonthName(parsedDate.month)} ${parsedDate.day}, ${parsedDate.year} - $time";
  return myDate;
}

String getDateFormat2(String updatedAt) {
  // Parse the input date string
  DateTime parsedDate = DateTime.parse(updatedAt).add(const Duration(hours: 2));
  String myDate =
      "${getMonthName(parsedDate.month)} ${parsedDate.day}, ${parsedDate.year}";
  return myDate;
}

String getTimeFormat(String updatedAt) {
  // Parse the input date string
  DateTime parsedDate = DateTime.parse(updatedAt).add(const Duration(hours: 2));
  String time = DateFormat("HH:mm:ss").format(parsedDate);
  return time;
}

String getDateOnlyFormat(String updatedAt) {
  // Parse the input date string
  DateTime parsedDate = DateTime.parse(updatedAt).add(const Duration(hours: 2));
  String time = DateFormat("yyyy-MM-dd").format(parsedDate);
  return time;
}

String getMonthOnlyFormat(String updatedAt) {
  // Parse the input date string
  DateTime parsedDate = DateTime.parse(updatedAt).add(const Duration(hours: 2));
  return getMonthName(parsedDate.month);
}

String getMonthName(int monthNumber) {
  if (monthNumber >= 1 && monthNumber <= 12) {
    return months[monthNumber - 1];
  } else {
    return "Muaji i pavlefshëm";
  }
}

Future<DateTime> searchDate(context) async {
  if (Platform.isAndroid) {
    DateTime? pickedDate = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(
          2000), //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime(2101),
      initialDatePickerMode: DatePickerMode.year, // Set initial mode to year
    );
    return pickedDate!;
  } else {
    var pickedDate = DateTime.now();
    showCupertinoModalPopup(
        context: context,
        builder: (builder) {
          return Container(
            width: getPhoneWidth(context),
            height: 200,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.monthYear,
              onDateTimeChanged: (date) {
                pickedDate = date;
              },
              minimumDate: DateTime.now(),
            ),
          );
        });
    return pickedDate;
  }
}

List<String> months = [
  "Janar",
  "Shkurt",
  "Mars",
  "Prill",
  "Maj",
  "Qershor",
  "Korrik",
  "Gusht",
  "Shtator",
  "Tetor",
  "Nentor",
  "Dhjetor",
];

List<String> getStatisticsSearchMethodArray() {
  return ["1D", "1W", "1M", "1V", "Te Gjitha"];
}

convertToFlag(countryCode){
  String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
          (match) => String.fromCharCode(match.group(0).codeUnitAt(0) + 127397));
  return flag;
}
