import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/components/sms_buttons.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/dimen.dart';
import 'package:bulk_sms/view_model/users_contact.dart';
import 'package:bulk_sms/views/contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SelectedPhoneNumberList extends StatefulWidget {
  const SelectedPhoneNumberList({Key? key}) : super(key: key);

  @override
  _SelectedPhoneNumberListState createState() => _SelectedPhoneNumberListState();
}

class _SelectedPhoneNumberListState extends State<SelectedPhoneNumberList> {
  @override
  Widget build(BuildContext context) {
    //ContactServices usersContact = Provider.of<ContactServices>(context);

    return Consumer<ContactServicesViewModal>(
        builder: (context, modal, child){
      return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [

    Container(
    height:25.h,

        child: Row(
          children: [
            Expanded(
              child: ListView.builder(
              physics:  BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    itemCount:modal.selectedContacts.length,
    shrinkWrap: true,
    itemBuilder: (BuildContext ctxt, int index) {
    return Padding(
    padding: EdgeInsets.symmetric(horizontal: 2.0, ),
    child:OutlinedButton.icon(

      icon: Icon(Icons.cancel,color: kBlackColor,),
      onPressed: () {
              modal.removeContact(modal.selectedContacts[index]);
              //newContact.remove(modal.selectedContacts[index]);
      },
      style: OutlinedButton.styleFrom(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),

              side: BorderSide(color: kBlackColor, width: 1),
      ),
    label: Text(modal.selectedContacts[index],
      style: Theme.of(context).textTheme.subtitle1!.copyWith(color: kBlackColor,fontSize: kFontSize12)
      ),

      )
    );
              }),
            ),

            Material(
              borderRadius: BorderRadius.circular(4),
              color: kRedColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("+ ${modal.selectedContacts.length}".toString(),
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(color: kWhiteColor,fontSize: kFontSize12,fontWeight: FontWeight.bold)
                ),
              ),
            )
          ],
        )),



      ],
    );
    });
        }
}
