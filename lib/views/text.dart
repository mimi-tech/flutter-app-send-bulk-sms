// import 'package:bulk_sms/components/appbar.dart';
// import 'package:bulk_sms/components/progressIndicator.dart';
// import 'package:bulk_sms/models/new_user.dart';
// import 'package:bulk_sms/services/save_messages.dart';
// import 'package:bulk_sms/utility/colors.dart';
// import 'package:bulk_sms/view_model/users_Auth_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';
// class SavedMessageScreen extends StatefulWidget {
//   const SavedMessageScreen({Key? key}) : super(key: key);
//
//   @override
//   _SavedMessageScreenState createState() => _SavedMessageScreenState();
// }
//
// class _SavedMessageScreenState extends State<SavedMessageScreen> {
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     SavedMessages notifier = Provider.of<SavedMessages>(context);
//
//     if (notifier != notifier) {
//       notifier = notifier;
//       Future.microtask(() => notifier.getUserSavedMessages());
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     NewUser user = Provider.of<UserProvider>(context).user;
//
//     return ChangeNotifierProvider<SavedMessages>(
//         create: (_) => SavedMessages(),
//         child: Scaffold(
//           backgroundColor: Colors.blueGrey,
//           appBar: BulkSmsAppbar(title: '${user.fullName} Messages',color:kBlackColor,
//
//           ),
//           body: Consumer<SavedMessages>(
//               builder: (context, savedMessages, child){
//                 return Container(
//                   child: Column(
//                     children: [
//
//                       FutureBuilder<List<dynamic>>(
//                         future: savedMessages.getUserSavedMessages(),
//                         builder: (BuildContext context, AsyncSnapshot snapshot) {
//                           if (snapshot.connectionState == ConnectionState.waiting) {return ShowProgress();}
//                           if (snapshot.connectionState == ConnectionState.none && snapshot.hasData == false) {
//                             return Container(
//                               child: Center(
//                                 child: Text("You have no saved message yet",
//                                   style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kWhiteColor),
//
//                                 ),
//                               ),
//                             );}
//                           return Expanded(
//                             child: ListView.builder(
//                                 padding: EdgeInsets.all(8),
//                                 itemCount: savedMessages.storedMessages.length,//snapshot.data.length,
//                                 itemBuilder: (BuildContext context, int index){
//                                   List<dynamic> messageReceivers = snapshot.data[index]["recieversNumber"];
//                                   return SingleChildScrollView(
//                                     child: Card(
//                                       elevation: 5.0,
//                                       child: ExpansionTile(
//                                         iconColor: kLightBlue,
//                                         collapsedIconColor: kOrangeColor,
//                                         backgroundColor: Colors.white70,
//                                         collapsedBackgroundColor: kBlackColor,
//                                         title: Column(
//                                           children: [
//                                             ListTile(
//
//                                               title:Text(snapshot.data[index]['messageTitle']??'Title',
//                                                 style: Theme.of(context).textTheme.caption!.copyWith(color: kLightBlue),
//
//                                               ),
//
//                                               subtitle:Text(snapshot.data[index]['dateSent']??'Date sent',
//                                                 style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kAshColor),
//
//                                               ),
//
//                                               trailing: Container(
//
//                                                   decoration: BoxDecoration(
//                                                       shape: BoxShape.circle,
//                                                       border: Border.all(color: kLightBlue, width: 1.0)
//                                                   ),
//                                                   child: Padding(
//                                                       padding: const EdgeInsets.all(14.0),
//                                                       child: Text(snapshot.data[index]['count'].toString(),
//                                                         style: Theme
//                                                             .of(context)
//                                                             .textTheme
//                                                             .bodyText1!
//                                                             .copyWith(color: Colors.blueGrey,fontWeight: FontWeight.bold),
//
//                                                       )
//                                                   )),
//
//
//                                             ),
//                                             Divider(),
//
//
//                                           ],
//                                         ),
//                                         children: <Widget>[
//                                           ExpansionTile(
//                                             title: Text(
//                                               'Contact(s)',
//                                               style: Theme.of(context).textTheme.caption!.copyWith(color: kLightBlue),
//
//                                             ),
//                                             children: <Widget>[
//                                               Container(
//                                                 height:MediaQuery.of(context).size.height * 0.5,
//                                                 child: ListView.builder(
//                                                     padding: EdgeInsets.all(8),
//                                                     itemCount: messageReceivers.length,
//                                                     itemBuilder: (BuildContext context, int index){
//                                                       return snapshot.data[index]["recieversNumber"]== null?Text('No contact seen',
//                                                         style: Theme.of(context).textTheme.bodyText1,
//                                                       )
//
//                                                           :ListTile(
//
//                                                           leading: Text("${index + 1}".toString(),
//                                                             style: Theme.of(context).textTheme.bodyText1,
//
//                                                           ),
//                                                           trailing: IconButton(onPressed: (){}, icon: Icon(Icons.check,color: Colors.green,)),
//                                                           title:Text(messageReceivers[index],
//                                                             style: Theme.of(context).textTheme.bodyText1,
//
//                                                           )
//                                                       );
//                                                     }
//                                                 ),
//                                               ),
//
//                                             ],
//                                           ),
//                                           ListTile(
//                                             title: Text('Sender: ${snapshot.data[index]['fullName']}',
//                                               style: Theme.of(context).textTheme.caption!.copyWith(color: kLightBlue),
//
//                                             ),
//                                             subtitle: Text('Amount: ${snapshot.data[index]['amount']??'0.00'}'.toString(),
//                                               style: Theme.of(context).textTheme.caption!.copyWith(color: kGreenColor),
//
//                                             ),
//
//                                             trailing: IconButton(onPressed: (){
//                                               SavedMessages().deleteSavedMessages(snapshot.data[index]['msgId']);
//                                               //after deleting the message remove it from the list
//                                               savedMessages.storedMessages.removeAt(index);
//                                             }, icon: Icon(Icons.cancel,size: 25,color: kRedColor,)),
//                                           )
//                                         ],
//                                       ),
//
//                                     ),
//                                   );
//
//
//                                 }),
//                           );
//
//                         },
//
//
//                       )
//
//
//
//
//                     ],
//                   ),
//                 );
//               }),
//
//
//         ));
//   }
// }






//
//
// import 'dart:convert';
// import 'dart:io';
// import 'package:bulk_sms/models/card_details.dart';
// import 'package:bulk_sms/models/new_user.dart';
// import 'package:bulk_sms/repos/api_status.dart';
//
//
// import 'package:bulk_sms/components/constants.dart';
// import 'package:bulk_sms/utility/shared_prefrences.dart';
// import 'package:bulk_sms/views/otp_screen.dart';
// import 'package:flutter/material.dart';
//
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';
// import 'package:http/http.dart' as https;
// import 'package:http/http.dart';
// class FServices {
//
//   var publicKey = "${dotenv.env['RESOLVE_ACCOUNT']}";
//   var client = HttpClient();
//
//   static Future<Map<String, dynamic>> verifyCardBin() async {
//     try {
//       var binCardNumber = 468219; //cardNumber.substring(0,6);
//       var url = Uri.parse("${dotenv.env['RESOLVE_CARD_BIN']}/$binCardNumber");
//       Response response = await https.get(url, headers: {
//         'Authorization': "Bearer ${dotenv.env['PAYSTACK_SECRETE_KEY']}"
//       });
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         Success(response: responseData);
//         print("ggg2");
//         return responseData;
//       }
//       throw Exception("Invalid response");
//     } on HttpException {
//       throw Exception("No internet");
//     } on FormatException {
//       throw Exception("Invalid format");
//     } catch (e) {
//       throw Exception("Unknown error");
//     }
//   }
//
//
//   static fundCard(context, email) async {
//     print(PaystackPlugin().sdkInitialized);
//     try {
//       //First initialize payment
//       var body = json.encode({
//         'email': email,
//         'amount': amount,
//       });
//       var url = Uri.parse("${dotenv.env['INITIALIZE_PAYMENT']}");
//       Response response = await https.post(url, headers: {
//         'Authorization': "Bearer ${dotenv.env['PAYSTACK_SECRETE_KEY']}"
//       }, body: body);
//
//       if (response.statusCode == 200) {
//         print("rrrrrrr ${response.body}");
//         final Map<String, dynamic> jsonDecoded = json.decode(response.body);
//         PaymentCard _getCardFromUI() {
//           return PaymentCard(
//             number: cardNumber,
//             cvc: cvv,
//             expiryMonth: expiryMonth,
//             expiryYear: expiryYear,
//           );
//         }
//
//         //CHARGE THE CARD
//         var charge = Charge()
//           ..accessCode = jsonDecoded['data']['access_code']
//           ..card = _getCardFromUI();
//
//         final result = await PaystackPlugin().chargeCard(
//             context, charge: charge);
//         // Use the result
//         if (result.status == true) {
//           print("bbbb");
//           //verify the transaction
//           var url = Uri.parse(
//               "${dotenv.env['VERIFY_TRANSACTION']}/${result.reference}");
//           Response response = await https.get(url, headers: {
//             'Authorization': "Bearer ${dotenv.env['PAYSTACK_SECRETE_KEY']}"
//           });
//           if (response.statusCode == 200) {
//             final Map<String, dynamic> jsonDecoded = json.decode(response.body);
//             var cardData = jsonDecoded['data']['authorization'];
//
//             CardDetailsModal cardDetailsModal = CardDetailsModal.fromJson(
//                 cardData);
//             //Save the user card details with shared pref
//             UserPreferences().cardDetails(cardDetailsModal);
//             UserPreferences().saveCustomerId(
//                 jsonDecoded['data']['customer']['id']);
//             //update the users wallet
//             updateWallet();
//           }
//         }
//       }
//       print("tttttttt");
//       throw Exception("There is an error funding your wallet");
//     } on HttpException {
//       throw Exception("No internet");
//     } on FormatException {
//       throw Exception("Invalid format");
//     } catch (e) {
//       print('ee $e');
//       throw Exception(e);
//     }
//   }
//
//   static Future<Object> updateWallet() async {
//     String userId = await UserPreferences().getUserId();
//
//     try {
//       var body = json.encode({
//         'authId': userId,
//         'amount': amount,
//       });
//       var url = Uri.parse("${dotenv.env['UPDATE_WALLET']}");
//       Response response = await https.put(url, headers: {
//         'Authorization': "Bearer ${dotenv.env['PAYSTACK_SECRETE_KEY']}",
//         body: body
//       });
//       if (response.statusCode == 200) {
//         Success(response: response);
//         print("ggg2");
//         return Success(response: response);
//       }
//       throw Exception("There is an error");
//     } on HttpException {
//       throw Exception("No internet");
//     } on FormatException {
//       throw Exception("Invalid format");
//     } catch (e) {
//       throw Exception(e);
//     }
//   }
//
//
//   static Future<List<GetBanksResponse>> getBanks(
//       final https.Client client) async {
//     try {
//       var url = Uri.parse("${dotenv.env['GET_BANKS_URL']}");
//       Response response = await client.get(url);
//       if (response.statusCode == 200) {
//         final List<dynamic> jsonDecoded = jsonDecode(response.body);
//         final banks = jsonDecoded.map((json) => GetBanksResponse.fromJson(json))
//             .toList();
//
//         // final Map<String, dynamic> data = json.decode(response.body);
//         //
//         // final List<dynamic> responseData = data['data'];//json.decode(response.body);
//         // final banks = responseData.map((json) => GetBanksResponse.fromJson(json)).toList();
//
//         return banks;
//       }
//       throw Exception("There is an error");
//     } on HttpException {
//       throw Exception("No internet");
//     } on FormatException {
//       throw Exception("Invalid format");
//     } catch (e) {
//       throw Exception(e);
//     } finally {
//       client.close();
//     }
//   }
//
//
//   static Future<Map<String, dynamic>> resolveAccountNumber() async {
//     try {
//
//       var url = Uri.parse("${dotenv.env['RESOLVE_ACCOUNT']}");
//       var body = json.encode ({
//         'account_number': bankAccountNumber,
//         'account_bank': bankCode});
//
//       Response response = await https.post(url, headers: {
//         'Authorization': "Bearer ${dotenv.env['FLUTTER_WAVE_SECRETE_KEY']}",
//         body:body
//       });
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         Success(response: responseData);
//         return responseData;
//       }
//       throw Exception("There is an error");
//     } on HttpException {
//       throw Exception("No internet");
//     } on FormatException {
//       throw Exception("Invalid format");
//     } catch (e) {
//       throw Exception(e);
//     }
//   }
//
//
//   static Future<Map<String, dynamic>> chargeAccount(context, email, phoneNumber, fullName) async {
// //resolve the account number
//     try {
//       var url = Uri.parse("${dotenv.env['RESOLVE_ACCOUNT']}");
//       Map<String, String> headersCheck = {
//         "Content-type": "application/json",
//         "Authorization": 'Bearer ${dotenv.env['FLUTTER_WAVE_SECRETE_KEY']}'
//       };
//       var body = json.encode(
//           {'account_number': bankAccountNumber, 'account_bank': bankCode});
//       Response responseCheck = await post(
//           url, headers: headersCheck, body: body);
//       print(responseCheck.body);
//       if (responseCheck.statusCode == 200) {
//         final Map<String, dynamic> jsonDecoded = json.decode(
//             responseCheck.body);
//
//         //initiatePayment(jsonDecoded, context, email, phoneNumber, fullName);
//       }
//       throw Exception("There is an error");
//     } on HttpException {
//       throw Exception("No internet");
//     } on FormatException {
//       throw Exception("Invalid format");
//     } catch (e) {
//       throw Exception(e);
//     }
//   }
//
//   static  Future<Map<String, dynamic>>  initiatePayment( context, email, phoneNumber, fullName) async {
//     //After resolving account number , Initiate payment
//     try {
//       var url = Uri.parse("${dotenv.env['INITIATE_PAYMENTS']}");
//
//       var body = json.encode({
//         'account_number': bankAccountNumber,
//         'account_bank': bankCode,
//         "tx_ref": DateTime.now().toIso8601String(),
//         "amount": amount.toString(),
//         "currency": "NGN",
//         "email": email,
//         "phone_number": phoneNumber,
//         "fullname": fullName
//       });
//       Map<String, String> headers = {
//         "Content-type": "application/json",
//         "Authorization": 'Bearer ${dotenv.env['FLUTTER_WAVE_SECRETE_KEY']}'
//       };
//
//       Response response = await post(url, headers: headers, body: body);
//       print(response.body);
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonDecoded = json.decode(response.body);
//         callOtp(jsonDecoded, context);
//       }
//       throw Exception("There is an error");
//     } on HttpException {
//       throw Exception("No internet");
//     } on FormatException {
//       throw Exception("Invalid format");
//     } catch (e) {
//       throw Exception(e);
//     }
//   }
//
//
//   static void callOtp(Map<String, dynamic> jsonDecoded, BuildContext context) {
//     showModalBottomSheet(
//         isDismissible: false,
//         isScrollControlled: true,
//         context: context,
//         builder: (context) =>
//             RequestForOTP(next: () {
//               _validateOtp(jsonDecoded, context);
//             },)
//     );
//   }
//
//   static Future<void> _validateOtp(Map<String, dynamic> jsonDecoded,
//       BuildContext context) async {
//     FocusScopeNode currentFocus = FocusScope.of(context);
//     if (!currentFocus.hasPrimaryFocus) {
//       currentFocus.unfocus();
//     }
//     Navigator.pop(context);
//
//     try {
//       var url = Uri.parse("${dotenv.env['FLUTTER_WAVE_SECRETE_KEY']}");
//       Map<String, String> headers = {
//         "Content-type": "application/json",
//         "Authorization": 'Bearer ${dotenv.env['FLUTTER_WAVE_SECRETE_KEY']}'
//       };
//       var body = json.encode({
//         'otp': otpText,
//         'flw_ref': jsonDecoded['data']['flw_ref'],
//         'type': 'account'
//       });
//       Response response = await post(url, headers: headers, body: body);
//
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonDecoded = json.decode(response.body);
//
//         verifySuccessTxn(jsonDecoded);
//       } else {
//         notifyFlutterToastError(title: 'OTP error');
//       }
//       throw Exception("There is an error");
//     } on HttpException {
//       throw Exception("No internet");
//     } on FormatException {
//       throw Exception("Invalid format");
//     } catch (e) {
//       throw Exception(e);
//     }
//   }
//
//   static Future<Map<String, dynamic>>  verifySuccessTxn(Map<String, dynamic> jsonDecoded) async {
//     try {
//       var url = Uri.parse("${dotenv.env['VERIFY_PAYMENT']}${jsonDecoded['data']['id']}/verify");
//       Response res = await https.get(url, headers: {
//         "Authorization": 'Bearer ${dotenv.env['FLUTTER_WAVE_SECRETE_KEY']}'
//       });
//       if (res.statusCode == 200) {
//         //Save the user card details with shared pref
//         UserPreferences().saveCustomerId(jsonDecoded['data']['customer']['id']);
//         //update the users wallet
//         updateWallet();
//
//         return jsonDecoded;
//       }
//       throw Exception("There is an error");
//     } on HttpException {
//       throw Exception("No internet");
//     } on FormatException {
//       throw Exception("Invalid format");
//     } catch (e) {
//       throw Exception(e);
//     }
//   }
// }
//
//
