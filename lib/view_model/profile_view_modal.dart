
import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/components/validation_dialog.dart';
import 'package:bulk_sms/repos/api_status.dart';
import 'package:bulk_sms/services/logout.dart';
import 'package:bulk_sms/services/message_services.dart';
import 'package:bulk_sms/services/profile_services.dart';
import 'package:bulk_sms/utility/routes.dart';
import 'package:bulk_sms/view_model/account_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileViewModal extends ChangeNotifier{
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  getUpdateFullName(context) async{

      setLoading(true);
      var response = await ProfileServices.updateFullName();
      if( response is Success ){
        AuthProvider().getLoggedInUserDetails(context);
        setLoading(false);
        notifyFlutterToastSuccess(title: "Full name updated successful");

      }
      if(response is Failure) {
        setLoading(false);
        notifyFlutterToastError(title: "${response.errorResponse}");

      }


  }


//sending otp to phone number
  getUpdatePhoneNumber(context) async{


      setLoading(true);
      //send sms to the phone number
      var smsResponse = await SmsMessageServices.sendSms(
          phoneNumber: phoneNumber,
          message:  "${AppLocalizations.of(context)!.emailCodeSentText} $codeSent",
          from: messageFrom

      );
      if(smsResponse is Success){
        setLoading(false);
        ValidationDialog.validateMe(
            title: AppLocalizations.of(context)!.validateTitle,
            context: context,
            subtitle: AppLocalizations.of(context)!.phoneNumberCodeSent,
            data: phoneNumber,
            subtitle2: AppLocalizations.of(context)!.phoneNumberCodeSent2,
            onPressedDone: ()=>verifyUserCode(context)
        );

      }

      if(smsResponse is Failure) {
        setLoading(false);
        notifyFlutterToastError(title: "Error sending otp");

      }


  }

  verifyUserCode(context) async {
    if(codeSent == int.parse(phoneCode)){

      setLoading(true);
      //update the user phone number
      var response = await ProfileServices.updatePhoneNumber();
      if( response is Success ){

        AuthProvider().getLoggedInUserDetails(context);
        setLoading(false);
        notifyFlutterToastSuccess(title: "Phone number updated successful");

      }
      if(response is Failure) {
        setLoading(false);
        notifyFlutterToastError(title: "${response.errorResponse}");

      }


    }

  }




  //send email code

//sending otp to phone number
getUpdateEmailAddress(context) async{

    setLoading(true);
    print("nice");

    //send sms to the phone number
    var response = await SmsMessageServices.sendEmail();
    if(response is Success){
      setLoading(false);
      ValidationDialog.validateMe(
          title: AppLocalizations.of(context)!.validateTitle,
          context: context,
          subtitle: AppLocalizations.of(context)!.phoneNumberCodeSent,
          data: emailAddress,
          subtitle2:  AppLocalizations.of(context)!.phoneNumberCodeSent2,
          onPressedDone: ()=>verifyUserEmailCode(context)
      );
    }
    if(response is Failure){
      print("good");
      setLoading(false);
      notifyFlutterToastError(title: "Error sending otp");

    }







}

  verifyUserEmailCode(context) async {
    if(codeSent == int.parse(phoneCode)){
      Navigator.pop(context);

        setLoading(true);
        //update the user phone number
        var response = await ProfileServices.updateEmailAddress();
        if( response is Success ){

          setLoading(false);
          notifyFlutterToastSuccess(title: "Email address updated successful");
         //log the user out
          LogOutUser().logoutUser(context);
          homeScreenPage(context);
        }
        if(response is Failure) {
          setLoading(false);
          notifyFlutterToastError(title: "${response.errorResponse}");

        }



  }else{
      notifyFlutterToastError(title: "Invalid code");

    }

  }}

