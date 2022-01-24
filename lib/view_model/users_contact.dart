
import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/models/user_error.dart';
import 'package:bulk_sms/repos/api_status.dart';
import 'package:bulk_sms/services/contact_services.dart';
import 'package:bulk_sms/services/message_services.dart';
import 'package:bulk_sms/view_model/account_provider.dart';

import 'package:flutter/cupertino.dart';


class ContactServicesViewModal extends ChangeNotifier{
  bool _loading  = false;
  UserError? _userError;
  String _infoText = "";
  List<String> _storedContacts = [];
  List<String> _selectedContacts = <String>[];
  List<String> contact = <String>[];
  String _smsSentText = "";
  String _smsSentAllContactText = "";

  bool get loading => _loading;
  String get infoText => _infoText;
  UserError? get userError => _userError;
  String get smsSentText => _smsSentText;
  String get smsSentAllContactText => _smsSentAllContactText;
  List<String> get storedContacts => _storedContacts;
  List<String> get selectedContacts => _selectedContacts;

  setStoredContacts(List<String> storedContacts) {
    _storedContacts = storedContacts;

  }

  setSelectedContacts(List<String> selectedContacts) {
    _selectedContacts = selectedContacts;
    notifyListeners();
  }

  setLoading(bool loading) async{
    _loading = loading;
  }
  setInfoText(String infoText) async{
    _infoText = infoText;
  }

   addSelectedContact(item){
     contact.add(item);
     pickedContacts.add(item);
     newContact.add(item);
    setSelectedContacts(contact);
    //notifyListeners();
}

   removeContact(item){
    contact.remove(item);
    pickedContacts.remove(item);

    setSelectedContacts(contact);
    //notifyListeners();
  }

  setSmsSentText(String smsSentText) async{
    _smsSentText = smsSentText;
    notifyListeners();
  }

 setSmsSentAllContactText(String smsSentAllContactText) async{
   _smsSentAllContactText = smsSentAllContactText;
    notifyListeners();
  }

  getViewContact() async {
    var response = await ContactServices.viewContact();
    if(response.isNotEmpty){
      setStoredContacts(response);
      setInfoText("");
      notifyListeners();
    }else{
      setInfoText("You have no saved contacts");
    }
    }



    //deleting contact

   getDeleteContact() async {
    setLoading(true);
    var response = await ContactServices.deleteContact();
    if(response is Success){
      List<String> usersContact = [];
      setStoredContacts(usersContact);
      notifyFlutterToastSuccess(title: "Contacts deleted successfully");

      setLoading(false);

    }
    if(response is Failure){
      setLoading(false);

       notifyFlutterToastError(title: response.errorResponse);

    }}

  //deleting contact

  removeAContact(contact) async {
    setLoading(true);
    var response = await ContactServices.deleteAContact(contact);
    if(response is Success){
      setLoading(false);
      notifyFlutterToastSuccess(title: "$contact removed successfully");
    }
    if(response is Failure){
      setLoading(false);

      return notifyFlutterToastError(title: response.errorResponse);

    }}





  //adding contact

  getAddContact() async {
    setLoading(true);
    var response = await ContactServices.addContact();
    if(response is Success){
       notifyFlutterToastSuccess(title:"Contacts saved successfully");

      setLoading(false);
    }
    if(response is Failure){
      setLoading(false);

      return notifyFlutterToastError(title: response.errorResponse);

    }}




  //sending bulk sms
  getSendBulkSms(BuildContext context, email, fullName) async {
    sentContacts.clear();
    failedContacts.clear();
    if(newContact.length != 0){
      setLoading(true);
      for(int i = 0; i < newContact.length; i++){
        var response = await SmsMessageServices.sendSms(phoneNumber: newContact[i],message: smsMessage,from: messageTitle);
        if(response is Success){
          //update wallet for sms
         await SmsMessageServices.updateWalletForSms();
          setSmsSentText("Message sent successfully");
          sentContacts.add(newContact[i]);
          Future.delayed(Duration(seconds: 4), () {
            setSmsSentText("");
          });

          removeContact(newContact[i]);

          await AuthProvider().getLoggedInUserDetails(context);

          if( i + 1 == newContact.length){

            //save the message
             await SmsMessageServices.saveUserMessage(email,fullName);
            //save the contact

            await ContactServices.addContact();
            removeContact(newContact[i]);
             setSmsSentAllContactText("Message sent completely to ${sentContacts.length} contact(s)");
            setLoading(false);
          }
        }
        if(response is Failure){
          failedContacts.add(newContact[i]);
          setSmsSentText("${response.errorResponse}");
          if( i + 1 == newContact.length){
             await SmsMessageServices.saveUserMessage(email,fullName);
            //save the contact
            await ContactServices.addContact();
             //selectedContacts.remove(i);
             removeContact(newContact[i]);
            setLoading(false);
          }

        }
      }

    }else{
      setSmsSentText("Please select or add mobile number");
      Future.delayed(Duration(seconds: 4), () {
        setSmsSentText("");
      });
      notifyFlutterToastError(title: "Please select or add mobile number");
    }
  }



}
