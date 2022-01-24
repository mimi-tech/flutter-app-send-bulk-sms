import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/components/sms_buttons.dart';
import 'package:bulk_sms/utility/colors.dart';
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
        modal.selectedContacts.length == 0?
    Text("Please select Contact or add new contact. Note: Maximum of 50 contacts at a time",
    style: Theme.of(context).textTheme.bodyText1!.apply(color: kTextColor)
    )
            :Text("${modal.selectedContacts.length.toString()} Contact(s)",
            style: Theme.of(context).textTheme.bodyText1!.apply(color: kTextColor)
        ),
    Container(
    height:50.h,

        child: ListView.builder(
        physics:  BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    itemCount:modal.selectedContacts.length,
    shrinkWrap: true,
    itemBuilder: (BuildContext ctxt, int index) {
    return Padding(
    padding: EdgeInsets.symmetric(horizontal: 2.0, ),
    child: GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: kLightBlue,
          borderRadius: BorderRadius.circular(30.0)
        ),
      width: 180.w,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            Text(modal.selectedContacts[index],
                style: Theme.of(context).textTheme.bodyText1!.apply(color: kWhiteColor)
            ),

            Expanded(

                child: IconButton(

                    onPressed: (){
                      modal.removeContact(modal.selectedContacts[index]);
                      newContact.remove(modal.selectedContacts[index]);
                    }, icon:Icon(Icons.cancel,size: 30,color: kWhiteColor,))),

          ],
        )
      ),
    ));
        })),


      ],
    );
    });
        }
}
