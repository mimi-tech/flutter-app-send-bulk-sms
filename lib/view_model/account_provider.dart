
import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/repos/api_status.dart';
import 'package:bulk_sms/services/auth_services.dart';
import 'package:bulk_sms/utility/routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthProvider with ChangeNotifier {


  bool _loading  = false;


  bool get loading => _loading;


  setLoading(bool loading) async{
    _loading = loading;
    notifyListeners();
  }

   getLogin(BuildContext context) async {

    setLoading(true);
    var response = await AuthServices.loginUser();
    if (response is Success) {
      setLoading(false);
      bottomBar(context);
    }
    if(response is Failure){
      setLoading(false);
      notifyFlutterToastError(title: "${response.errorResponse}");
    }

  }

 userRegistration(BuildContext context) async {

   try{
     setLoading(true);
     var response = await AuthServices.registerUser();
     if (response is Success) {
       setLoading(false);

     }
     if(response is Failure){
       setLoading(false);
       notifyFlutterToastError(title: "${response.errorResponse}");
     }
   }catch(e){
     setLoading(false);
     return notifyFlutterToastError(title: AppLocalizations.of(context)!.loginNotSuccess);

   }}




  //reset password services


  resetPassword(BuildContext context) async {

    try{
      setLoading(true);
      var response = await AuthServices.resetPassword();
      if (response is Success) {
        setLoading(false);
        loginScreen(context);
        notifyFlutterToastSuccess(title: AppLocalizations.of(context)!.successful);

      }
      if(response is Failure){
        setLoading(false);
        notifyFlutterToastError(title: "${response.errorResponse}");
      }
    }catch(e){
      setLoading(false);
      return notifyFlutterToastError(title: AppLocalizations.of(context)!.loginNotSuccess);

    }}


    getLoggedInUserDetails(BuildContext context) async {


        setLoading(true);
        var response = await AuthServices.getUser(context);
        if (response is Success) {
          setLoading(false);

        }
        if(response is Failure){
          setLoading(false);
          //notifyFlutterToastError(title: "${response.errorResponse}");
        }


  }


}

