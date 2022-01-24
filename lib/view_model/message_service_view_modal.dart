import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/components/validation_dialog.dart';
import 'package:bulk_sms/models/user_error.dart';
import 'package:bulk_sms/repos/api_status.dart';
import 'package:bulk_sms/utility/routes.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bulk_sms/services/message_services.dart';
import 'package:flutter/cupertino.dart';

class MessageServices extends ChangeNotifier{
  bool _loading  = false;
  bool _messageSent  = false;
  UserError? _userError;
  UserSuccess? _userSuccess;
 String _smsSentText = "";
  List<String> _storedMessages = [];

  bool get loading => _loading;
  bool get messageSent => _messageSent;
  UserError? get userError => _userError;
  UserSuccess? get userSuccess => _userSuccess;
  String get smsSentText => _smsSentText;
  List<String> get storedMessages => _storedMessages;



  setLoading(bool loading) async{
    _loading = loading;
    notifyListeners();
  }

  setMessageSent(bool messageSent) async{
    _messageSent = messageSent;
    //notifyListeners();
  }

  setSmsSentText(String smsSentText) async{
    _smsSentText = smsSentText;
    notifyListeners();
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  setUserSuccess(UserSuccess userSuccess) {
    _userSuccess = userSuccess;
  }

  setStoredMessage(List<String> storedMessages) {
    _storedMessages = storedMessages;
  }
  smsMessageService({required context}) async {
    setLoading(true);



    var response = await SmsMessageServices.sendSms(
      phoneNumber: phoneNumber,
      message:  "${AppLocalizations.of(context)!.emailCodeSentText} + $codeSent",
      from: messageFrom
    );
    if(response is Success){
      setMessageSent(true);
      UserSuccess userSuccess = UserSuccess(
          message: "Message sent",
          code: response.code,
          data: phoneNumber.toString()
      );
      setUserSuccess(userSuccess);

      ValidationDialog.validateMe(
          title: AppLocalizations.of(context)!.validateTitle,
          context: context,
          subtitle: AppLocalizations.of(context)!.phoneText,
          data: phoneNumber,
          subtitle2: '',
          onPressedDone: ()=>verifyUserCode(context)
      );
      setLoading(false);

    }

    if(response is Failure){
      UserError userError = UserError(
          message: response.errorResponse.toString(),
          code: 101
      );
      setUserError(userError);
    }
    setLoading(false);


  }

  verifyUserCode(context) {
    if(codeSent == phoneCode){
      emailScreen(context);
    }else{
      notifyFlutterToastError(title: "Sorry incorrect code");
    }
  }






//get user messages
   getUserSavedMessages() async {
    var response = await SmsMessageServices.userMessage();
    if(response.isNotEmpty){
      setStoredMessage(response.cast<String>());
      return response;
    }
}

//get user messages
  getDeleteUserSavedMessages(String messageId) async {

    setLoading(true);
    var response = await SmsMessageServices.deleteUserMessage(messageId);
    if(response is Success){
      setLoading(false);
      notifyFlutterToastSuccess(title: "Message deleted successfully");
    }
    if(response is Failure){
      setLoading(false);
      notifyFlutterToastError(title: response.errorResponse);

    }
  }


  //delete all user messages
  getDeleteAllSavedMessages() async {

    setLoading(true);
    var response = await SmsMessageServices.deleteAllMessages();
    if(response is Success){
      setLoading(false);
      notifyFlutterToastSuccess(title: "Messages deleted successfully");
    }
    if(response is Failure){
      setLoading(false);
      notifyFlutterToastError(title: response.errorResponse);

    }
  }




}
