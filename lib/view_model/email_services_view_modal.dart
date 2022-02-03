import 'dart:math';

import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/components/validation_dialog.dart';
import 'package:bulk_sms/models/user_error.dart';
import 'package:bulk_sms/repos/api_status.dart';
import 'package:bulk_sms/utility/generateCode.dart';
import 'package:bulk_sms/utility/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bulk_sms/services/message_services.dart';
import 'package:flutter/cupertino.dart';

class MessageServicesEmail extends ChangeNotifier{
  bool _loading  = false;
  UserError? _userError;
  UserSuccess? _userSuccess;

  bool get loading => _loading;
  UserError? get userError => _userError;
  UserSuccess? get userSuccess => _userSuccess;



  setLoading(bool loading) async{
    _loading = loading;
    notifyListeners();
  }

  setUserError(UserError userError) {
    _userError = userError;
  }

  setUserSuccess(UserSuccess userSuccess) {
    _userSuccess = userSuccess;
  }

  emailMessageService({required context}) async {
    setLoading(true);
    GenerateCode.generateCode();

    var response = await SmsMessageServices.sendEmail();
    if(response is Success){

      setLoading(false);

      ValidationDialog.validateMe(
          title: AppLocalizations.of(context)!.validateEmailTitle2,
          context: context,
          subtitle: AppLocalizations.of(context)!.emailSubtitle,
          data: emailAddress,
          subtitle2: '',
          onPressedDone: ()=>verifyUserCode(context)
      );

    }

    if(response is Failure){
      setLoading(false);

    }


  }

  verifyUserCode(BuildContext context) {

    if(codeSent == int.parse(phoneCode)){
      Navigator.pop(context);
      //check if user is coming from forgot password screen
      if(isForgotPassword == true){
        changePasswordScreen(context);
      }else{
      passwordScreen(context);
      notifyFlutterToastSuccess(title: AppLocalizations.of(context)!.successful);

    }}else{
      notifyFlutterToastError(title: "Sorry incorrect code");
    }
  }



}
