import 'dart:math';

import 'package:bulk_sms/utility/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget space(BuildContext context)=> SizedBox(height: MediaQuery.of(context).size.height * 0.08);

Widget spacing(BuildContext context)=> SizedBox(height: MediaQuery.of(context).size.height * 0.02);

String? fullName = '';
String? phoneNumber = '';
String? emailAddress = '';
String? password = '';
String phoneCode = '';
dynamic codeSent;
bool isForgotPassword = false;
String messageFrom = "BULK SMS";

const USER_INVALID_RESPONSE = 101;
const NO_INTERNET = 102;
const INVALID_FORMAT = 103;
const UNKNOWN_ERROR = 104;

/*This is for the funding */
String cardNumber = '';
String cvv = '';
String cardName = '';
int? expiryMonth;
int? expiryYear;
int? amount;
var binCardNumber;
var authorizationCode;
//List<dynamic> selectedContacts = <dynamic>[];

String? bankName;
String? bankCode;
String? bankAccountNumber;
String? otpText;

//sending message
String? messageTitle;
String? smsMessage;
List<dynamic> sentContacts = <dynamic>[];
List<dynamic> failedContacts = <dynamic>[];
List<dynamic> pickedContacts = <dynamic>[];
List<String> newContact = <String>[];


 notifyFlutterToastSuccess({required title})async{
  // String title;
  Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: kBlackColor,
      textColor: Colors.greenAccent);
}

 notifyFlutterToastError({required title})async{
  // String title;
  Fluttertoast.showToast(
      timeInSecForIosWeb: 10,
      msg: title,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: kBlackColor,
      textColor: kRedColor);
}