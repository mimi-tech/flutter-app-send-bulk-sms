
import 'package:bulk_sms/components/appbar2.dart';
import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/components/modalProgressFunction.dart';
import 'package:bulk_sms/components/sms_buttons.dart';
import 'package:bulk_sms/models/new_user.dart';
import 'package:bulk_sms/services/message_services.dart';
import 'package:bulk_sms/utility/cardMonthInputFormatter.dart';
import 'package:bulk_sms/view_model/message_service_view_modal.dart';
import 'package:bulk_sms/view_model/users_Auth_provider.dart';
import 'package:bulk_sms/view_model/users_contact.dart';
import 'package:bulk_sms/views/contacts.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/dimen.dart';
import 'package:bulk_sms/utility/routes.dart';
import 'package:bulk_sms/views/selected_phone_number_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class CreateMessage extends StatefulWidget {
  const CreateMessage({Key? key}) : super(key: key);

  @override
  _CreateMessageState createState() => _CreateMessageState();
}

class _CreateMessageState extends State<CreateMessage> {
  String from = '';
  String message = '';
  String _countryCode = '';



  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _from = TextEditingController();
  TextEditingController _message = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    ContactServicesViewModal usersContact = Provider.of<ContactServicesViewModal>(context);
    NewUser user = Provider.of<UserProvider>(context).user;

    return SafeArea(
        child:  Scaffold(

            appBar: BulkSmsAppbarSecond(
                deleteButton: SmsButtonsNew(
                  tapSmsButton: (){},
                  title: "NGN ${user.wallet.toString()}",
                  color: kNavyColor,
                ),
                color:kBlackColor,
                title: '${AppLocalizations.of(context)!.appName}'

            ),

            body: ProgressHUDFunction(
              inAsyncCall: usersContact.loading,
              child: CustomScrollView(slivers: <Widget>[
                SliverAppBar(
                forceElevated: true,
                shape:  RoundedRectangleBorder(
                borderRadius:  BorderRadius.only(bottomRight: Radius.circular(10.0),bottomLeft: Radius.circular(10.0),
                )
                ),
                backgroundColor: kNavyColor,
                pinned: true,
                automaticallyImplyLeading: false,
                floating: true,
                title:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap:(){
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: ContactScreen()));
                      },
                      child: Text("Select Contact(s)",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(color: kLightBlue),

                      ),
                    ),

                    SmsButtons(title: AppLocalizations.of(context)!.sendMessage.toUpperCase(),
                        color: kLightBlue,
                        tapSmsButton: ()async {
                          final form = _formKey.currentState;
                          if (form!.validate()) {
                            form.save();
                            FocusScopeNode currentFocus = FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }

                            await usersContact.getSendBulkSms(context,user.email,user.fullName);
                          }
                        } ),
                  ],
                )

                ),
                SliverList(delegate: SliverChildListDelegate([
                Container(
                  margin: EdgeInsets.symmetric(horizontal: kMargin),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      spacing(context),

                      Center(
                        child: Text(
                            AppLocalizations.of(context)!.createMessage.toUpperCase(),
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold,color: kNavyColor)
                        ),
                      ),
                      spacing(context),
                      spacing(context),

                      SelectedPhoneNumberList(),
                      //spacing(context),


                      Form(
                        key: _formKey,
                        child: Column(
                          children: [

                            TextFormField(
                              controller: _phoneNumber,
                              autocorrect: true,
                              autofocus: true,
                              cursorColor: (kOrangeColor),
                              keyboardType: TextInputType.number,
                              style: Theme.of(context).textTheme.bodyText1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                 prefix:  CountryCodePicker(

                                   textStyle:  GoogleFonts.oxanium(
                                     fontSize: ScreenUtil().setSp(kFontSize16),
                                     fontWeight: FontWeight.bold,
                                     color: kTextColor,

                                   ),
                                   dialogTextStyle: Theme.of(context).textTheme.bodyText1,

                                   onInit: (code) {
                                     _countryCode = code.toString();
                                   },
                                   onChanged: (code){
                                     _countryCode = code.toString();
                                   },
                                   // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                   initialSelection: 'NG',
                                   favorite: ['+234','NG'],
                                   // optional. Shows only country name and flag
                                   showCountryOnly: false,
                                   // optional. Shows only country name and flag when popup is closed.
                                   showOnlyCountryWhenClosed: false,
                                   // optional. aligns the flag and the Text left
                                   alignLeft: false,
                                 ),

                                suffix: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: kLightBlue, width: 1.0)
                                    ),
                                    child: IconButton(onPressed: (){
                                      usersContact.addSelectedContact(_countryCode + _phoneNumber.text);
                                      _phoneNumber.clear();
                                    }, icon: Icon(Icons.add,color: kLightBlue,size: 20,))),

                                labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                                 hintText: "Recipient mobile number",
                                errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
                                border: Theme.of(context).inputDecorationTheme.border,
                                enabledBorder:Theme.of(context).inputDecorationTheme.enabledBorder,
                                focusedBorder:Theme.of(context).inputDecorationTheme.focusedBorder,
                                focusedErrorBorder:Theme.of(context).inputDecorationTheme.focusedErrorBorder,
                                errorBorder:Theme.of(context).inputDecorationTheme.errorBorder,
                                contentPadding: Theme.of(context).inputDecorationTheme.contentPadding,
                              ),
                              onChanged: (String value) {

                              },
                            ),
                            spacing(context),

                            TextFormField(
                              controller: _from,
                              cursorColor: (kOrangeColor),
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.sentences,
                              maxLength: 15,
                              style: Theme.of(context).textTheme.bodyText1,
                              decoration: InputDecoration(
                                labelText: 'From',
                                labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,

                                errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
                                border: Theme.of(context).inputDecorationTheme.border,
                                enabledBorder:Theme.of(context).inputDecorationTheme.enabledBorder,
                                focusedBorder:Theme.of(context).inputDecorationTheme.focusedBorder,
                                focusedErrorBorder:Theme.of(context).inputDecorationTheme.focusedErrorBorder,
                                errorBorder:Theme.of(context).inputDecorationTheme.errorBorder,
                                contentPadding: Theme.of(context).inputDecorationTheme.contentPadding,
                              ),
                              onSaved: (String? value) {
                                messageTitle = value;
                              },
                            ),
                            spacing(context),

                            TextFormField(
                              controller: _message,
                              autocorrect: true,
                              cursorColor: (kOrangeColor),
                              keyboardType: TextInputType.text,
                              style: Theme.of(context).textTheme.bodyText1,
                              textCapitalization: TextCapitalization.sentences,
                              maxLength: 150,
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: 'Message',
                                labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                                errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
                                border: Theme.of(context).inputDecorationTheme.border,
                                enabledBorder:Theme.of(context).inputDecorationTheme.enabledBorder,
                                focusedBorder:Theme.of(context).inputDecorationTheme.focusedBorder,
                                focusedErrorBorder:Theme.of(context).inputDecorationTheme.focusedErrorBorder,
                                errorBorder:Theme.of(context).inputDecorationTheme.errorBorder,
                                contentPadding: Theme.of(context).inputDecorationTheme.contentPadding,
                              ),
                              onSaved: (String? value) {
                                smsMessage = value;
                              },
                            ),


                            spacing(context),
                          ],
                        ),
                      ),

                      Text(
                          AppLocalizations.of(context)!.sendMessageText,
                          style: Theme.of(context).textTheme.subtitle2
                      ),
                      Center(
                        child: Text(usersContact.smsSentAllContactText,
                            style:Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold,color: kGreenColor)
                        ),
                      ),
                      Center(
                        child: Text(usersContact.smsSentText,
                            style:usersContact.smsSentText == "Message sent successfully"?

                            Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold,color: kGreenColor)
                                : Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold,color: kRedColor)

                        ),
                      ),

                    ],
                  ),




                )
    ]))]),
            ))


    );
  }
}
