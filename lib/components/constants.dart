import 'dart:math';

import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

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
String? binCardNumber;
var authorizationCode;
//List<dynamic> selectedContacts = <dynamic>[];
List<dynamic>  allList = [];
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
//List<String> newContact = <String>[];
 TextEditingController searchController = TextEditingController();

List<String> enteredContact = <String>[];

String? contactName;
List<SelectedContactGroup> userGroupContacts= [];
//var userGroupContacts = [];
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


 final searchInput = InputDecoration(
 prefixIcon: Icon(Icons.search,color: kOrangeColor,),
 hintText: "Search...",

 hintStyle:GoogleFonts.oxanium(
  fontSize: ScreenUtil().setSp(kFontSize16, ),
  color: kHintColor,
 ),
 enabledBorder: UnderlineInputBorder(
  borderSide:
  BorderSide(color: kOrangeColor),
 ),
 focusedBorder: UnderlineInputBorder(
  borderSide: BorderSide(color: kOrangeColor),


 ),
 border:
 OutlineInputBorder(borderSide: BorderSide(color: kOrangeColor)),
);


class SelectedContactGroup {
 String name;
 List contact;

 SelectedContactGroup({
  required this.name,
  required this.contact,
 });
}