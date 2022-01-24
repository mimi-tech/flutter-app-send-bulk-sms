import 'dart:convert';
import 'dart:io';

import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/models/new_user.dart';

import 'package:bulk_sms/repos/api_status.dart';
import 'package:bulk_sms/utility/generateCode.dart';
import 'package:bulk_sms/utility/shared_prefrences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as https;
import 'package:http/http.dart';



class SmsMessageServices{
  //For sending sms

  static Future <Object> sendSms({required phoneNumber, required message, required from})async{
    try {
      var url = Uri.parse("${dotenv.env['SEND_SMS']}");

      Map<String, String> headers = {
        "Content-type": "application/json",
        "authorization": "12345" //"${dotenv.env['SECRETE']}"
      };
      var body = json.encode({
        'phoneNumber': phoneNumber,
        'message': message,
        'from':from
      });
// make POST request
      var response = await https.post(url, headers: headers, body: body);
      final Map<String, dynamic> responseData = json.decode(response.body);


      if (response.statusCode == 200) {

        //notifyFlutterToastSuccess(title: messageError);

        return Success(response: responseData);

      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: "Sorry an error occurred");
    }on HttpException{
      return Failure(code: NO_INTERNET, errorResponse: "No internet");
    }on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid format");
    }on SocketException {
      return Failure(code: INVALID_FORMAT, errorResponse: "No internet connection");

    } catch(e){
      return Failure(code: UNKNOWN_ERROR, errorResponse: "Unknown error");

    }
  }


  //For sending email code

  static Future<Object> sendEmail()async{
    try {
      GenerateCode.generateCode();
      var url = Uri.parse("${dotenv.env['SEND_EMAIL']}");

      Map<String, String> headers = {
        "Content-type": "application/json",
        "authorization": "12345" //"${dotenv.env['SECRETE']}"
      };

      var body = json.encode({
        "subject": "BULK SMS email verification code",
        "message":  "Email verification code $codeSent",
        "email": emailAddress,
      });
// make POST request
      Response response = await post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return Success(response: response);

      }

      throw Failure(code: USER_INVALID_RESPONSE, errorResponse: "Sorry error occurred");
    }on HttpException{
      throw Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    }on FormatException{
      throw Failure(code: INVALID_FORMAT, errorResponse: "Invalid format");
    }on SocketException {
      throw Exception("No internet connection");
    } catch(e){
      throw Failure(code: UNKNOWN_ERROR, errorResponse: "Unknown error");

    }}


    //For sending bulk sms

    static Future<Object> updateWalletForSms()async{
      try {
        String userId = await UserPreferences().getUserId();
        String token = await UserPreferences().getToken();

        var url = Uri.parse("${dotenv.env['UPDATE_WALLET_FOR_SMS']}");
        Map<String, String> headers = {
          "Content-type": "application/json",
          "authorization": token
        };

        var body = json.encode({
          "authId": userId,
        });
// make POST request
        Response response = await https.put(url, headers: headers, body: body);
        final Map<String,dynamic> jsonDecoded = json.decode(response.body);
        print("update wallet");
        print(jsonDecoded);
        if (jsonDecoded["data"] == true) {
          return Success(response: response);

        }
        //46d9eedc-ecfe-4a0e-83bb-00bec5d2c865
        return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
      }on HttpException{
        return Failure(code: NO_INTERNET, errorResponse: "No internet");
      }on FormatException{
        return Failure(code: INVALID_FORMAT, errorResponse: "Invalid format");
      } catch(e){
        return Failure(code: UNKNOWN_ERROR, errorResponse: "Unknown error");

      }
  }

//save user message

  static  saveUserMessage(String email, String fullName)async{

    try {
      String userId = await UserPreferences().getUserId();
      String token = await UserPreferences().getToken();

      var url = Uri.parse("${dotenv.env['SAVE_BULK_SMS_MESSAGE']}");
      Map<String, String> headers = {
        "Content-type": "application/json",
        "authorization": token
      };
      var smsCost = sentContacts.length * double.parse("${dotenv.env['SMS_AMOUNT']}");

      var body = json.encode({
        "senderId": userId,
        "title":messageTitle,
        "receiversNumber": sentContacts,
        "failedContacts":failedContacts,
        "count":sentContacts.length + failedContacts.length,
        "message":smsMessage,
        "fullName":fullName,
        "email":email,
        "amount":smsCost.roundToDouble()


      });
// make POST request
      Response response = await post(url, headers: headers, body: body);
      final Map<String,dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response);

      }

      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    }on HttpException{
      return Failure(code: NO_INTERNET, errorResponse: "Internal server error");
    }on FormatException{
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid format");
    }on SocketException {
      return Failure(code: NO_INTERNET, errorResponse: "No internet connection");

    }  catch(e){
      print(e);
      return Failure(code: UNKNOWN_ERROR, errorResponse: "Unknown error");

    }
  }

//save user message

  static Future<List<dynamic>> userMessage()async{
     //var result = await UserPreferences().getUser();

    try {
      String userId = await UserPreferences().getUserId();
      String token = await UserPreferences().getToken();

      var url = Uri.parse("${dotenv.env['GET_USER_MESSAGES']}$userId");
      Map<String, String> headers = {
        "Content-type": "application/json",
        "authorization": token
      };

// make GET request
      Response response = await https.get(url, headers: headers);
      final Map<String,dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {
        return json.decode(response.body)['data'];

      }

      throw Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    }on HttpException{
      throw Failure(code: NO_INTERNET, errorResponse: "Internal error server");
    }on FormatException{
      throw Failure(code: INVALID_FORMAT, errorResponse: "Invalid format");
    }on SocketException {
      throw Failure(code: NO_INTERNET, errorResponse: "No internet connection");

    } catch(e){
      throw Failure(code: UNKNOWN_ERROR, errorResponse: "Unknown error");

    }
  }



//delete user message

  static Future<Object> deleteUserMessage(String messageId)async{
    //var result = await UserPreferences().getUser();

    try {
      String token = await UserPreferences().getToken();
      String userId = await UserPreferences().getUserId();

      var url = Uri.parse("${dotenv.env['DELETE_USER_MESSAGE']}");
      Map<String, String> headers = {
        "Content-type": "application/json",
        "authorization": token
      };
      var body = json.encode({
        "msgId":messageId,
        "authId":userId
      });
// make DELETE request
      Response response = await https.delete(url, headers: headers,body: body);
      final Map<String,dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {
        return Success(response: jsonDecoded);

      }

      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    }on HttpException{
      return Failure(code: NO_INTERNET, errorResponse: "Internal error server");
    }on FormatException{
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid format");
    }on SocketException {
      return Failure(code: NO_INTERNET, errorResponse: "No internet connection");

    } catch(e){
      return Failure(code: UNKNOWN_ERROR, errorResponse: "Unknown error");

    }
  }


//delete all messages
  static Future<Object> deleteAllMessages()async{
    //var result = await UserPreferences().getUser();

    try {
      String token = await UserPreferences().getToken();
      String userId = await UserPreferences().getUserId();

      var url = Uri.parse("${dotenv.env['DELETE_ALL_MESSAGE']}");
      Map<String, String> headers = {
        "Content-type": "application/json",
        "authorization": token
      };
      var body = json.encode({

        "authId":userId
      });
// make DELETE request
      Response response = await https.delete(url, headers: headers,body: body);
      final Map<String,dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {
        return Success(response: jsonDecoded);

      }

      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    }on HttpException{
      return Failure(code: NO_INTERNET, errorResponse: "Internal error server");
    }on FormatException{
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid format");
    }on SocketException {
      return Failure(code: NO_INTERNET, errorResponse: "No internet connection");

    } catch(e){
      return Failure(code: UNKNOWN_ERROR, errorResponse: "Unknown error");

    }
  }

}