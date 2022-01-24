// import 'dart:convert';
// import 'package:bulk_sms/components/constants.dart';
// import 'package:bulk_sms/utility/app_urls.dart';
// import 'package:bulk_sms/utility/shared_prefrences.dart';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as https;
//
//
//
// class SavedMessages extends ChangeNotifier{
//   List<String> _storedMessages = [];
//   bool _loading  = false;
//
//
//   List<String> get storedMessages => _storedMessages;
//   bool get loading => _loading;
//
//   setStoredMessage(List<String> storedMessages) {
//     _storedMessages = storedMessages;
//   }
//   setLoading(bool loading) async{
//     _loading = loading;
//   }
//
//    Future<List<dynamic>> getUserSavedMessages()async {
//     try {
//       String userId = await UserPreferences().getUserId();
//       String token = await UserPreferences().getToken();
//       var url = Uri.parse('${AppUrls.getUserMessage}$userId');
//       var response = await https.get(url, headers: {'authorization': token});
//       if(response.statusCode == 200){
//         setStoredMessage(json.decode(response.body)['data'].cast<String>());
//       return json.decode(response.body)['data'];
//       }
//       throw Exception("Invalid response");
//     }on HttpException{
//       throw Exception("No internet");
//     }on FormatException{
//       throw Exception("Invalid format");
//     } catch (e) {
//   throw Exception( "Unknown error");
//
//     }
//   }
//
//
//   //deleting user messages
//
//   Future<List<dynamic>> deleteSavedMessages(messageId)async {
//     try {
//       setLoading(true);
//       String token = await UserPreferences().getToken();
//       var url = Uri.parse('${AppUrls.deleteUserMessage}$messageId');
//       var response = await https.delete(url, headers: {'authorization': token});
//       if(response.statusCode == 200){
//         notifyFlutterToastSuccess(title: "Message deleted successfully");
//         setLoading(false);
//       }
//       setLoading(false);
//       throw Exception("Invalid response");
//     }on HttpException{
//       throw Exception("No internet");
//     }on FormatException{
//       throw Exception("Invalid format");
//     } catch (e) {
//       notifyFlutterToastError(title: "There is an error deleting this message");
//
//       setLoading(false);
//       throw Exception( "Unknown error");
//
//     }
//   }
//
//   }