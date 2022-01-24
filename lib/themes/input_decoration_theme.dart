import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


InputDecorationTheme kInputDecorationTheme() {
  return InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),

    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.0,
        color: kTextFieldBorderColor,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.0,
        color: kOrangeColor,
      ),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        width: 0.0,
        color: kRedColor,
      ),
    ),
    contentPadding: EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 18.0),

    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.0,
        color: kRedColor,
      ),
    ),
    hintStyle: TextStyle(
      fontSize: kFontSize16.sp,
      color: kHintColor,
    ),
    labelStyle: TextStyle(
      fontSize: kFontSize16.sp,
      color: kAshColor,
    ),
    errorStyle: TextStyle(
      fontSize: kFontSize13.sp,
      color: kRedColor,
    ),
  );
}
