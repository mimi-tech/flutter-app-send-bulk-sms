import 'dart:convert';
import 'dart:io';
import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/models/new_user.dart';
import 'package:bulk_sms/repos/api_status.dart';
import 'package:bulk_sms/utility/shared_prefrences.dart';
import 'package:bulk_sms/view_model/users_Auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as https;
import 'package:provider/provider.dart';


class AuthServices {
  //for login

  static Future<Object> loginUser() async {
    try {

      var body = json.encode({
        'email': emailAddress,
        'password': password
      });
      var url = Uri.parse("${dotenv.env['LOGIN']}");

      Response response = await https.post(url, headers: {'Content-Type': 'application/json'}, body: body);
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);
      if (jsonDecoded['status'] == true) {
        var userData = jsonDecoded['data'];
        var token = jsonDecoded['token'];
        NewUser authUser = NewUser.fromJson(userData);
        UserPreferences().saveUser(authUser);
        UserPreferences().saveToken(token);
        UserPreferences().saveAuthId(userData['id']);
        return Success(response: response);
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e);
    }
  }


  static Future<Object> registerUser() async {
    try {

      var body = json.encode({
        'fullName':fullName,
        'phoneNumber':phoneNumber,
        'email': emailAddress,
        'password': password,
      });
      var url = Uri.parse("${dotenv.env['REGISTRATION']}");
      Response response = await https.post(url, headers: {'Content-Type': 'application/json'}, body: body);
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response);
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");

    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e);
    }
  }

  //reset password
  static Future<Object> resetPassword() async {
    try {

      var body = json.encode({
        'email': emailAddress,
        'password': password
      });
      var url = Uri.parse("${dotenv.env['RESET_PASSWORD']}");
      Response response = await https.put(url, headers: {'Content-Type': 'application/json'}, body: body);
      final Map<String, dynamic> jsonDecoded = json.decode(response.body);

      if (response.statusCode == 200) {

        return Success(response: response);
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    } on FormatException {
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: "Invalid format");
    } on SocketException {
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "No internet connection");
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: e);
    }
  }

  //getting logged in user
  static Future <Object> getUser(BuildContext context)async{
    try{
      String userId = await UserPreferences().getUserId();
      String token = await UserPreferences().getToken();
      var url = Uri.parse("${dotenv.env['GET_USER_BY_ID']}$userId");

      var response = await https.get(url, headers: {'authorization': token});
      final Map<String,dynamic> responseData = json.decode(response.body);

      if(responseData["status"] == true){
        var userData = responseData['data'];
        NewUser authUser = NewUser.fromJson(userData);
        Provider.of<UserProvider>(context, listen: false).setUser(authUser);

        return Success(response: authUser);
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Invalid response");
    }on HttpException{
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    }on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid format");
    }on SocketException {
        return Failure(code: NO_INTERNET, errorResponse: "No internet connection");

      } catch(e){
      print("unknjdhjhd $e");
      return Failure(code: UNKNOWN_ERROR, errorResponse: "Unknown error");
    }

  }

}