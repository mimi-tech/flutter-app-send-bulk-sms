import 'dart:convert';
import 'dart:io';
import 'package:bulk_sms/components/constants.dart';
import 'package:http/http.dart' as https;

import 'package:bulk_sms/repos/api_status.dart';
import 'package:bulk_sms/utility/shared_prefrences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class ProfileServices{


//update your firstname
  static Future<Object> updateFullName() async {
try{
    String userId = await UserPreferences().getUserId();
    String token = await UserPreferences().getToken();

    var body = json.encode({
      'authId': userId,
      'fullName': fullName,
    });
    var url = Uri.parse("${dotenv.env['UPDATE_USER_DATA']}");
    Response response = await https.put(url, headers: {'authorization': token,'Content-Type': 'application/json'}, body: body);
    final Map<String,dynamic> jsonDecoded = json.decode(response.body);

    if (jsonDecoded['status'] == true) {
      //get the users data
     // UsersViewModal().getUser(context);
      Success(response: response);

      return Success(response: response);
    }
    return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
  } on HttpException {
  return Failure(code: NO_INTERNET,errorResponse:"Internal server error");
} on FormatException {
return Failure(code: USER_INVALID_RESPONSE,errorResponse:"Invalid format");
}on SocketException {
throw Exception("No internet connection");
} catch (e) {
return Failure(code: UNKNOWN_ERROR,errorResponse:e);

}



  }




//update your phoneNumber
  static Future<Object> updatePhoneNumber() async {
    try{
    String userId = await UserPreferences().getUserId();
    String token = await UserPreferences().getToken();

    var body = json.encode({
      'authId': userId,
      'phoneNumber': phoneNumber,
    });
    var url = Uri.parse("${dotenv.env['UPDATE_PHONE_NUMBER']}");
    Response response = await https.put(url, headers: {'authorization': token,'Content-Type': 'application/json'}, body: body);
    final Map<String,dynamic> jsonDecoded = json.decode(response.body);

    if (jsonDecoded['status'] == true) {
      //get the users data
      Success(response: response);

      return Success(response: response);
    }
    return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
  } on HttpException {
  return Failure(code: NO_INTERNET,errorResponse:"Internal server error");
} on FormatException {
return Failure(code: USER_INVALID_RESPONSE,errorResponse:"Invalid format");
}on SocketException {
throw Exception("No internet connection");
} catch (e) {
return Failure(code: UNKNOWN_ERROR,errorResponse:e);

}

  }




//update your email address
  static Future<Object> updateEmailAddress() async {
    try{
    String userId = await UserPreferences().getUserId();
    String token = await UserPreferences().getToken();

    var body = json.encode({
      'authId': userId,
      'email': emailAddress,
    });
    var url = Uri.parse("${dotenv.env['UPDATE_EMAIL_ADDRESS']}");
    Response response = await https.put(url, headers: {'authorization': token,'Content-Type': 'application/json'}, body: body);
    final Map<String,dynamic> jsonDecoded = json.decode(response.body);

    if (jsonDecoded['status'] == true) {
      //get the users data
      Success(response: response);

      return Success(response: response);
    }
    return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
  } on HttpException {
      return Failure(code: NO_INTERNET,errorResponse:"No internet");
  } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE,errorResponse:"Invalid format");
    }on SocketException {
throw Exception("Internal server error");
} catch (e) {
      return Failure(code: UNKNOWN_ERROR,errorResponse:e);

}

  }

}