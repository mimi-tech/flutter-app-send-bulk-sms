import 'package:bulk_sms/components/appbar2.dart';
import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/components/modalProgressFunction.dart';
import 'package:bulk_sms/components/progressIndicator.dart';
import 'package:bulk_sms/components/sms_buttons.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/view_model/users_contact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {

  ContactServicesViewModal? notifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final notifier = Provider.of<ContactServicesViewModal>(context);

    if (this.notifier != notifier) {
      this.notifier = notifier;
      Future.microtask(() => notifier.getViewContact());
    }
  }

  @override
  Widget build(BuildContext context) {
    //ContactServicesViewModal usersContact = Provider.of<ContactServicesViewModal>(context);


    return SafeArea(
        child:  Consumer<ContactServicesViewModal>(
            builder: (context, modal, child)
    {
      return Scaffold(
          backgroundColor: kBlackColor,
          appBar: BulkSmsAppbarSecond(
            title: 'Contact( ${modal.storedContacts.length.toString()} )'.toUpperCase(), color: kOrangeColor,
            deleteButton: Row(

              children: [
                SmsButtonsNew(
                  tapSmsButton: () {
                    ContactServicesViewModal().getDeleteContact();
                  },
                  title: 'Delete all',
                  color: kNavyColor,
                ),

                modal.changeIcon?
                IconButton(onPressed: (){
                  modal.changeCheckedIcon();
                  //newContact.clear();
                  for(int i = 0; i < modal.storedContacts.length; i++){
                    modal.removeContact(modal.storedContacts[i]);

                  }
                }, icon: Icon(Icons.check_box,color: kWhiteColor,))
                    :IconButton(onPressed: (){
                  modal.changeCheckedIcon();

                    for(int i = 0; i < modal.storedContacts.length; i++){
                    modal.addSelectedContact(modal.storedContacts[i]);

                  }
                }, icon: Icon(Icons.check_box_outline_blank,color: kWhiteColor,))
              ],
            ),
          ),

          body: ProgressHUDFunction(
            inAsyncCall: modal.loading,
            child: Container(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(modal.infoText,
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: kWhiteColor),
                        ),

                      ],
                    ),

                    FutureBuilder(
                        future: modal.getViewContact(),
                        builder: (context, snapshot) {

                          return Expanded(
                            child: ListView.builder(
                                itemCount: modal.storedContacts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return SingleChildScrollView(

                                      child: Consumer<ContactServicesViewModal>(
                                          builder: (context, modal, child) {
                                            return modal.storedContacts
                                                .length == 0 ? ShowProgress()
                                                : Card(
                                              color: kListView,
                                              child: ListTile(

                                                  leading: Text("${index + 1}",
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                        color: kWhiteColor),

                                                  ),


                                                  trailing: modal
                                                      .selectedContacts
                                                      .contains(modal
                                                      .storedContacts[index]) ?
                                                  IconButton(onPressed: () {
                                                    modal.removeContact(modal
                                                        .storedContacts[index]);
                                                  },
                                                      icon: Icon(
                                                        Icons.check_box,
                                                        color: kOrangeColor,))
                                                      : Row(
                                                    mainAxisSize: MainAxisSize
                                                        .min,
                                                    children: [
                                                      IconButton(onPressed: () {
                                                        modal.addSelectedContact(modal.storedContacts[index]);
                                                      },
                                                          icon: Icon(Icons
                                                              .check_box_outline_blank,
                                                            color: kOrangeColor,)),

                                                      IconButton(onPressed: () {
                                                        modal.removeAContact(modal.storedContacts[index]);
                                                       // modal.storedContacts.remove(modal.storedContacts[index]);
                                                      },
                                                          icon: Icon(
                                                            Icons.delete,
                                                            color: kRedColor,)),
                                                    ],
                                                  ),


                                                  title: Text(
                                                    modal.storedContacts[index],
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                        color: kWhiteColor),

                                                  )
                                              ),
                                            );
                                          }));
                                }
                            ),
                          );
                        }


                    ),


                  ],
                )
            ),
          ));
    }));
  }



}
