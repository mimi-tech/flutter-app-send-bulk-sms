import 'dart:io';
import 'dart:convert';
import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/models/contact_modal.dart';
import 'package:bulk_sms/repos/api_status.dart';
import 'package:bulk_sms/utility/shared_prefrences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as https;
import 'package:http/http.dart';

class ContactServices{

  static Future <List<String>> viewContact() async {
    try{

      String userId = await UserPreferences().getUserId();
      String token = await UserPreferences().getToken();

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'authorization':token
      };
      var url = Uri.parse("${dotenv.env['VIEW_CONTACT']}$userId");

      Response response = await https.get(url, headers:headers);
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['status'] == true) {
        var userData = responseData['data'];

        List<String> usersContact = userData[0]['contacts'].cast<String>();
        return usersContact;
      }

      throw Exception("No data found");

    } on HttpException {
      throw Exception("Internal server error");
    } on FormatException {
      throw Exception("Invalid format");
    }on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      throw Exception(e);
    }
  }


  //deleting all contact

  static Future <Object> deleteContact() async {
    try{

      String userId = await UserPreferences().getUserId();
      String token = await UserPreferences().getToken();
      var url = Uri.parse("${dotenv.env['DELETE_CONTACT']}");
      var body = json.encode({
      "authId":userId
      });
      Response response = await https.delete(url, headers: {'authorization': token,'Content-Type': 'application/json'},body: body);
      final Map<String,dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response);
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



  //deleting a contact

  static Future <Object> deleteAContact(String contact) async {
    try{

      String userId = await UserPreferences().getUserId();
      String token = await UserPreferences().getToken();
      var url = Uri.parse("${dotenv.env['REMOVE_A_CONTACT']}");
      var body = json.encode({
        "authId":userId,
        "contact":contact
      });
      Response response = await https.put(url, headers: {'authorization': token,'Content-Type': 'application/json'},body: body);
      final Map<String,dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response);
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


  //adding contact

  static Future <Object> addContact() async {
    try{

      String userId = await UserPreferences().getUserId();
      String token = await UserPreferences().getToken();
      var url = Uri.parse("${dotenv.env['ADD_CONTACT']}");
      var body = json.encode({
        "authId":userId,
        "contact":pickedContacts

      });
     Response response = await https.post(url, headers: {'authorization': token,'Content-Type': 'application/json'},body: body);
      final Map<String,dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {
        return Success(response: response);

      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    }on HttpException{
      return Failure(code: NO_INTERNET, errorResponse: "Internal error server");
    }on FormatException{
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid format");
    }on SocketException {
      return Failure(code: NO_INTERNET, errorResponse: "No internet connection");

    } catch(e){
      print("contact $e");
      return Failure(code: UNKNOWN_ERROR, errorResponse: "Unknown error");

    }
  }

//get user group contact
  static Future<List<GetUserContact>> userContactGroup(final https.Client client) async {

    try {

      String userId = await UserPreferences().getUserId();
      String token = await UserPreferences().getToken();

      var url = Uri.parse("${dotenv.env['GET_USER_GROUP_CONTACT']}$userId");
      Response response = await client.get(url, headers: {'authorization': token});
      final Map<String,dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded["status"] == true) {

        final List<dynamic> responseData = jsonDecoded['data'];
        final contacts = responseData.map((json) => GetUserContact.fromJson(json)).toList();

        return contacts;
      }
      throw Exception("There is an error");
    } on HttpException {
      throw Exception("Internal server error");
    } on FormatException {
      throw Exception("Invalid format");

    }on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      throw Exception(e);
    }finally {
      client.close();
    }

  }



  static Future<Object> userGroupContact() async {

    try {

      String userId = await UserPreferences().getUserId();
      String token = await UserPreferences().getToken();
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'authorization':token
      };

      var url = Uri.parse("${dotenv.env['ADD_USER_GROUP_CONTACT']}");
      var body = json.encode({
        "authId":userId,
        "contact":pickedContacts,
        "contactName":contactName,

      });

      Response response = await https.post(url,headers: headers,body:body);
      final Map<String,dynamic> jsonDecoded = json.decode(response.body);
print(jsonDecoded);
      if (jsonDecoded["status"] == true) {

        return Success(response: response);
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: jsonDecoded['message']);
    }on HttpException{
      return Failure(code: NO_INTERNET, errorResponse: "Internal error server");
    }on FormatException{
      return Failure(code: INVALID_FORMAT, errorResponse: "Invalid format");
    }on SocketException {
      return Failure(code: NO_INTERNET, errorResponse: "No internet connection");

    } catch(e){
      print("contact $e");
      return Failure(code: UNKNOWN_ERROR, errorResponse: "Unknown error");

    }

  }
  //delete user contact group
  static Future <Object> deleteUserContactGroup(String contactNameBYID) async {
    try{

      String userId = await UserPreferences().getUserId();
      String token = await UserPreferences().getToken();
      var url = Uri.parse("${dotenv.env['DELETE_USER_GROUP_CONTACT']}");
      var body = json.encode({
        "authId":userId,
        "contactName":contactNameBYID
      });

      Response response = await https.delete(url, headers: {'authorization': token,'Content-Type': 'application/json'},body: body);
      final Map<String,dynamic> jsonDecoded = json.decode(response.body);
      print(contactNameBYID);
      print(jsonDecoded);
      if (jsonDecoded['status'] == true) {

        return Success(response: response);
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


  static Future <Object> deleteASingleGroupContact(String contactNameById, String contact) async {
    try{

      String userId = await UserPreferences().getUserId();
      String token = await UserPreferences().getToken();
      var url = Uri.parse("${dotenv.env['DELETE_A_USER_GROUP_CONTACT']}");
      var body = json.encode({
        "authId":userId,
        "contactName":contactNameById,
        "contact":contact
      });
      Response response = await https.put(url, headers: {'authorization': token,'Content-Type': 'application/json'},body: body);
      final Map<String,dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {

        return Success(response: response);
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