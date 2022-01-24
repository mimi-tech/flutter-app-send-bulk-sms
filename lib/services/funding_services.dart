import 'dart:convert';
import 'dart:io';
import 'package:bulk_sms/models/card_details.dart';
import 'package:bulk_sms/models/transaction_model.dart';
import 'package:bulk_sms/repos/api_status.dart';


import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/utility/shared_prefrences.dart';
import 'package:bulk_sms/view_model/account_provider.dart';
import 'package:flutter/material.dart';


import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as https;
import 'package:http/http.dart';
class FServices {
  //create customer
  static Future<Map<String, dynamic>> createCustomer(BuildContext context,String phoneNumber,String email,String fullName) async {
    try {

      var body = json.encode({
        'email': email,
        'first_name': fullName,
        'last_name':'',
        'phone':phoneNumber,
      });
      var url = Uri.parse("${dotenv.env['CREATE_CUSTOMER']}");
      Response response = await https.post(url, headers: {'Authorization': "Bearer ${dotenv.env['PAYSTACK_SECRETE_KEY']}"},body: body);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        UserPreferences().saveCustomerCode(responseData['data']['customer_code']);
        UserPreferences().saveCustomerId(responseData['data']['id']);

        Success(response: responseData);
        return responseData;
      }
      throw Exception("Invalid response");
    } on HttpException {
      throw Exception("No internet");
    } on FormatException {
      throw Exception("Invalid format");
    }on SocketException {
      throw Exception("Internal server error");
    } catch (e) {
      notifyFlutterToastSuccess(title: "Error creating virtual account");
      Navigator.pop(context);
      throw Exception(e);
    }
  }


  static Future<Map<String, dynamic>> verifyCardBin(context) async {
    try {
      var url = Uri.parse("${dotenv.env['RESOLVE_CARD_BIN']}/$binCardNumber");
      Response response = await https.get(url, headers: {
        'Authorization': "Bearer ${dotenv.env['PAYSTACK_SECRETE_KEY']}"
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        Success(response: responseData);
        return responseData;
      }
      throw Exception("Invalid response");
    } on HttpException {
      throw Exception("No internet");
    } on FormatException {
      throw Exception("Invalid format");
    }on SocketException {
        throw Exception("Internal server error");
    } catch (e) {
      notifyFlutterToastError(title: "Error resolving card");
      // Navigator.pop(context);
      throw Exception(e);
    }
  }


  static Future<Map<String, dynamic>> initializePayment(BuildContext context,String email) async {
    try {
      //First initialize payment

      var body = json.encode({
        'email': email,
        'amount': amount,
      });
      var url = Uri.parse("${dotenv.env['INITIALIZE_PAYMENT']}");
      Response response = await https.post(url, headers: {
        'Authorization': "Bearer ${dotenv.env['PAYSTACK_SECRETE_KEY']}"
      }, body: body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonDecoded = json.decode(response.body);

        return jsonDecoded;
      }
      throw Exception("There is an initializing payment");
    } on HttpException {
      throw Exception("No internet");
    } on FormatException {
      throw Exception("Invalid format");
    }on SocketException {
      throw Exception("Internal server error");
    } catch (e) {
      notifyFlutterToastError(title: "Error initializing payment");
      Navigator.pop(context);
      throw Exception(e);
    }
  }


  static Future<Map<String, dynamic>>  verifySuccessTxn(reference, context) async {
    try {
      var url = Uri.parse("${dotenv.env['VERIFY_TRANSACTION']}$reference");
      Response res = await https.get(url, headers: {
        "Authorization": 'Bearer ${dotenv.env['PAYSTACK_SECRETE_KEY']}'
      });
      print(res.body);
      if (res.statusCode == 200) {
        final Map<String,dynamic> jsonDecoded = json.decode(res.body);
        var cardData = jsonDecoded['data']['authorization'];

        CardDetailsModal cardDetailsModal = CardDetailsModal.fromJson(cardData);

        //Save the user card details with shared pref
        UserPreferences().cardDetails(cardDetailsModal);
        UserPreferences().saveCustomerId(jsonDecoded['data']['customer']['id']);


        return jsonDecoded;
      }

    throw Exception("There is an error funding your wallet");
  } on HttpException {
  throw Exception("No internet");
} on FormatException {
throw Exception("Invalid format");
    }on SocketException {
      throw Exception("Internal server error");
    } catch (e) {
      notifyFlutterToastSuccess(title: "Error verifying payment");
      Navigator.pop(context);
throw Exception(e);
}
}

  static Future<Object> updateWallet(context) async {

    String userId = await UserPreferences().getUserId();
    String token = await UserPreferences().getToken();

    try {
      var body = json.encode({
        'authId': userId,
        'amount': amount!
      });
      var url = Uri.parse("${dotenv.env['UPDATE_WALLET']}");
     Response response = await https.put(url, headers: {'authorization': token,'Content-Type': 'application/json'}, body: body);
      if (response.statusCode == 200) {
        //get the users data
        AuthProvider().getLoggedInUserDetails(context);
        Success(response: response);
        return Success(response: response);
      }
      throw Exception("There is an error");
    } on HttpException {
      throw Exception("No internet");
    } on FormatException {
      throw Exception("Invalid format");

    }on SocketException {
      throw Exception("Internal server error");
    } catch (e) {
      notifyFlutterToastSuccess(title: "Error updating wallet");
      Navigator.pop(context);
      throw Exception(e);
    }



  }

  static Future<Map<String, dynamic>> chargeAuthorization(BuildContext context,String email) async {

    try {

      var body = json.encode({
        'email': email,
        'amount': amount,
        'authorization_code':authorizationCode
      });
      var url = Uri.parse("${dotenv.env['CHARGE_AUTHORIZATION']}");
      Response response = await https.post(url, headers: {'Authorization': "Bearer ${dotenv.env['PAYSTACK_SECRETE_KEY']}"}, body: body);

      print("charge ${response.body}");
      if (response.statusCode == 200) {
        final Map<String,dynamic> jsonDecoded = json.decode(response.body);
        //save customer id in pref
        UserPreferences().saveCustomerId(jsonDecoded['data']['customer']['id']);
        UserPreferences().saveCustomerCode(jsonDecoded['data']['customer']['customer_code']);


        return jsonDecoded;
      }
      throw Exception("There is an error");
    } on HttpException {
      throw Exception("No internet");
    } on FormatException {
      throw Exception("Invalid format");

    }on SocketException {
      throw Exception("Internal server error");
    } catch (e) {
      notifyFlutterToastSuccess(title: "Error updating wallet");
      Navigator.pop(context);
      throw Exception(e);
    }

  }

  //fetching users transactions

  static Future<List<TransactionModel>> customerTransactions(final https.Client client) async {

    try {
      //get customer id

      int customerId = await UserPreferences().getCustomerId();
      var url = Uri.parse("${dotenv.env['CUSTOMER_TRANSACTION']}$customerId");
      Response response = await client.get(url, headers: {'Authorization': "Bearer ${dotenv.env['PAYSTACK_SECRETE_KEY']}"});
      if (response.statusCode == 200) {
        final Map<String,dynamic> jsonDecoded = json.decode(response.body);

        final List<dynamic> responseData = jsonDecoded['data'];
         final transactions = responseData.map((json) => TransactionModel.fromJson(json)).toList();

        return transactions;
      }
      throw Exception("There is an error");
    } on HttpException {
      throw Exception("No internet");
    } on FormatException {
      throw Exception("Invalid format");

    }on SocketException {
      throw Exception("Internal server error");
    } catch (e) {
      notifyFlutterToastSuccess(title: "Error getting your transactions");
      throw Exception(e);
    }finally {
       client.close();
     }

  }

//transferring funds
  static Future<Object> transferFunds(BuildContext context) async {
try{
    String userId = await UserPreferences().getUserId();
    String token = await UserPreferences().getToken();

      var body = json.encode({
        'senderAuthId': userId,
        'amount': amount!,
        'receiverEmail':emailAddress
      });
      var url = Uri.parse("${dotenv.env['TRANSFER_FUNDS']}");
      Response response = await https.put(url, headers: {'authorization': token,'Content-Type': 'application/json'}, body: body);
      final Map<String,dynamic> jsonDecoded = json.decode(response.body);

      if (jsonDecoded['status'] == true) {
        //get the users data
        AuthProvider().getLoggedInUserDetails(context);
        Success(response: response);

        return Success(response: response);
      }
    return Failure(code: response.statusCode,errorResponse: jsonDecoded['message']);

}on HttpException {
  return Failure(code: NO_INTERNET,errorResponse: "Internal server error");
} on FormatException {
  return Failure(code: INVALID_FORMAT,errorResponse: "Invalid format");
}on SocketException {
  return Failure(code: INVALID_FORMAT,errorResponse: "No internet connection");
} catch (e) {
  return Failure(code: UNKNOWN_ERROR,errorResponse: "Unknown error");
}


  }


}
