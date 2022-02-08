
import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/models/user_error.dart';
import 'package:bulk_sms/repos/api_status.dart';
import 'package:bulk_sms/services/contact_services.dart';
import 'package:bulk_sms/services/message_services.dart';
import 'package:bulk_sms/view_model/account_provider.dart';
import 'package:bulk_sms/views/createMessage/add_new_group_contact.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ContactServicesViewModal extends ChangeNotifier{
  bool _loading  = false;
  bool _changeIcon = false;
  UserError? _userError;
  String _infoText = "";
  List<String> _storedContacts = [];
  List<String> _selectedContacts = <String>[];
  List<String> _enteredContact = <String>[];
  List<String> contact = <String>[];
  List<dynamic> _allContact = <dynamic>[];
  String _smsSentText = "";
  String _smsSentAllContactText = "";
  Map<String, List<dynamic>>? _selectedContactGroup;

  bool get loading => _loading;
  bool get changeIcon => _changeIcon;
  String get infoText => _infoText;
  UserError? get userError => _userError;
  String get smsSentText => _smsSentText;
  String get smsSentAllContactText => _smsSentAllContactText;
  List<String> get storedContacts => _storedContacts;
  List<dynamic> get allContact => _allContact;
  List<String> get selectedContacts => _selectedContacts;
  List<String> get enteredContact => _enteredContact;
  Map<String, List<dynamic>>? get selectedContactGroup => _selectedContactGroup;

  setStoredContacts(List<String> storedContacts) {
    _storedContacts = storedContacts;

  }

  setSelectedContacts(List<String> selectedContacts) {
    _selectedContacts = selectedContacts;
    notifyListeners();
  }
  setEnteredContacts(List<String> enteredContact) {
    _enteredContact = enteredContact;
    notifyListeners();
  }

  setLoading(bool loading) async{
    _loading = loading;
  }
  setChangeIcon(bool changeIcon) async{
    _changeIcon = changeIcon;
    notifyListeners();
  }
  setInfoText(String infoText) async{
    _infoText = infoText;
  }

  changeCheckedIcon(){
    setChangeIcon(!changeIcon);
  }

   addSelectedContact(item){
     contact.add(item);
     pickedContacts.add(item);
     //newContact.add(item);
    setSelectedContacts(contact);
    //notifyListeners();
}

  addEnteredContact(item){
    enteredContact.add(item);
    allContact.add(item);
    pickedContacts.add(item);
    //remove duplicate
   allContact.toSet().toList();

    setEnteredContacts(enteredContact);
    notifyListeners();
  }
  removeEnteredContact(item){
    enteredContact.remove(item);
    allContact.remove(item);
    pickedContacts.remove(item);
    //remove duplicate
    allContact.toSet().toList();
    setEnteredContacts(enteredContact);
    notifyListeners();
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

  setSelectedContactGroup(Map<String, List<dynamic>> selectedContactGroup) {
    _selectedContactGroup = selectedContactGroup;
    notifyListeners();
  }

  addGroupContact({required name, required contact}){

    List<SelectedContactGroup> contacts= [];
    contacts.add(SelectedContactGroup(name:name,contact: contact));
    userGroupContacts.addAll(contacts);
    var map1 = {for (var e in userGroupContacts) e.name: e.contact};
    setSelectedContactGroup(map1);

    List<dynamic>  allList = [];

    for(int i = 0; i <selectedContactGroup!.values.toList().length; i++){
      allList.addAll(selectedContactGroup!.values.toList()[i]);
    }


  allContact.clear();
   allContact.addAll(allList);
   allContact.addAll(pickedContacts);
    notifyListeners();
  }

  void removeGroupContact({required name,}){
     selectedContactGroup!.removeWhere((key, value) => key.contains(name));

     List<dynamic>  allList = [];

     for(int i = 0; i <selectedContactGroup!.values.toList().length; i++){
       allList.addAll(selectedContactGroup!.values.toList()[i]);
     }
     allContact.clear();
     allContact.addAll(allList.toSet());
     allContact.addAll(pickedContacts);
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

  //adding group contact

  getAddGroupContact(BuildContext context) async {
    if(enteredContact.length != 0){
      print(enteredContact);
    setLoading(true);
    var response = await ContactServices.userGroupContact();
    if(response is Success){
      notifyFlutterToastSuccess(title:"Contacts grouped successfully");

      setLoading(false);
    }
    if(response is Failure){
      setLoading(false);

       notifyFlutterToastError(title: response.errorResponse);

    }}else{
       notifyFlutterToastError(title: "Please add contacts");

    }
  }

//delete contact group
  getDeleteGroupContact({required contactNameBYID}) async {

      setLoading(true);
      var response = await ContactServices.deleteUserContactGroup(contactNameBYID);
      if(response is Success){
        notifyFlutterToastSuccess(title:"Contacts grouped deleted successfully");

        setLoading(false);
      }
      if(response is Failure){
        setLoading(false);

        notifyFlutterToastError(title: response.errorResponse);

      }

  }


//delete contact group
  getDeleteSingleGroupContact({required contactNameBYID,required contact}) async {

    setLoading(true);
    var response = await ContactServices.deleteASingleGroupContact(contactNameBYID,contact);
    if(response is Success){
      notifyFlutterToastSuccess(title:"Contact removed successfully");

      setLoading(false);
    }
    if(response is Failure){
      setLoading(false);

      notifyFlutterToastError(title: response.errorResponse);

    }

  }




  //sending bulk sms
  getSendBulkSms({required context, required fullName,required email}) async {

    setLoading(true);
    sentContacts.clear();
    failedContacts.clear();


      for(int i = 0; i < allContact.length; i++){
        var response = await SmsMessageServices.sendSms(phoneNumber: allContact[i],message: smsMessage,from: messageTitle);
        if(response is Success){
          //update wallet for sms
         await SmsMessageServices.updateWalletForSms();
          setSmsSentText("Message sent successfully");
          sentContacts.add(allContact[i]);
          Future.delayed(Duration(seconds: 4), () {
            setSmsSentText("");
          });

          //removeContact(newContact[i]);

          await AuthProvider().getLoggedInUserDetails(context);

          if( i + 1 == allContact.length){

            //save the message
             await SmsMessageServices.saveUserMessage(email,fullName);
            //save the contact

            await ContactServices.addContact();

            //update message count for user
             await SmsMessageServices.updateUserMessageCount();
            //removeContact(allContact[i]);
             setSmsSentAllContactText("Message sent completely to ${sentContacts.length} contact(s)");
            setLoading(false);

            //show bottom sheet to add contact list if new contact where add

            if(pickedContacts.length != 0){
              showModalBottomSheet(

                  isScrollControlled: true,
                  context: context,
                  builder: (context) => AddNewContactsGroup()
              );
            }

          }
        }
        if(response is Failure){
          failedContacts.add(allContact[i]);
          setSmsSentText("${response.errorResponse}");
          if( i + 1 == allContact.length){
             await SmsMessageServices.saveUserMessage(email,fullName);
            //save the contact
            await ContactServices.addContact();

             //update message count for user
             await SmsMessageServices.updateUserMessageCount();
             //removeContact(newContact[i]);
            setLoading(false);
          }

        }
      }


  }



}
