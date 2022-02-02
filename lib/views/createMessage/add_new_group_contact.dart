import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/components/progressIndicator.dart';
import 'package:bulk_sms/components/sms_buttons.dart';
import 'package:bulk_sms/utility/Validators.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/dimen.dart';
import 'package:bulk_sms/view_model/users_contact.dart';
import 'package:bulk_sms/views/createMessage/show_new_contact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class AddNewContactsGroup extends StatefulWidget {
  const AddNewContactsGroup({Key? key}) : super(key: key);

  @override
  _AddNewContactsGroupState createState() => _AddNewContactsGroupState();
}

class _AddNewContactsGroupState extends State<AddNewContactsGroup> {
  TextEditingController _title = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ContactServicesViewModal usersContact = Provider.of<ContactServicesViewModal>(context);

    return AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
    duration: const Duration(milliseconds: 600),
    curve: Curves.decelerate,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: kMargin),
    height: MediaQuery.of(context).size.height * 0.4,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spacing(context),
            Center(
              child: Text("Contact group creation".toUpperCase(),
                style: Theme.of(context).textTheme.bodyText2!.copyWith(color: kAshColor),

              ),
            ),
            spacing(context),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.07,
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  border: Border.all(width: 1.0,color: kHintColor)
              ),
              child:usersContact.enteredContact.length != 0?
              Center(child: NewPhoneNumberList())
                  : Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("Contact(s)", style: Theme.of(context).textTheme.overline),
                  )),
            ),
            spacing(context),
            Text("Enter new group title or existing",
              style: Theme.of(context).textTheme.caption!.copyWith(color: kNavyColor),

            ),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _title,
                cursorColor: (kOrangeColor),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                maxLength: 10,
                validator: Validator.validateContactTitle,

                style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(

                  isDense: true,
                  hintText: 'New group title or existing',
                  hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,

                  errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
                  border: Theme.of(context).inputDecorationTheme.border!.copyWith(borderSide: BorderSide(color: kAshColor)),
                  enabledBorder:Theme.of(context).inputDecorationTheme.enabledBorder,
                  focusedBorder:Theme.of(context).inputDecorationTheme.focusedBorder!.copyWith(borderSide: BorderSide(color: kAshColor)),
                  focusedErrorBorder:Theme.of(context).inputDecorationTheme.focusedErrorBorder,
                  errorBorder:Theme.of(context).inputDecorationTheme.errorBorder,
                  contentPadding: Theme.of(context).inputDecorationTheme.contentPadding,
                ),
                onSaved: (String? value) {
                  contactName = value;
                },
              ),
            ),
            spacing(context),
            usersContact.loading?ShowProgress():Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              SmsButtonsNew(title: "Cancel".toUpperCase(), color: kRedColor, tapSmsButton: (){Navigator.pop(context);}),

    SmsButtonsNew(title: "Save".toUpperCase(), color: kLightBlue, tapSmsButton: () async {
    final form = _formKey.currentState;
    if (form!.validate()) {
    form.save();
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
    }
    await usersContact.getAddGroupContact(context);

    }

                }),
              ],
            )

          ],
        ),
      ),
    ));
  }
}
