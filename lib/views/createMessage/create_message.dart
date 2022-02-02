
import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/components/modalProgressFunction.dart';

import 'package:bulk_sms/utility/Validators.dart';

import 'package:bulk_sms/view_model/users_contact.dart';
import 'package:bulk_sms/views/createMessage/add_new_group_contact.dart';
import 'package:bulk_sms/views/createMessage/selected_contact_group.dart';
import 'package:bulk_sms/views/createMessage/send_sms_preview.dart';
import 'package:bulk_sms/views/createMessage/show_new_contact.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/dimen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
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
  var height = 50;


  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _from = TextEditingController();
  TextEditingController _message = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ContactServicesViewModal usersContact = Provider.of<ContactServicesViewModal>(context);
    return SafeArea(
      child:  Scaffold(
        backgroundColor: kLightAsh,
        bottomNavigationBar: GestureDetector(
          onTap: (){
      final form = _formKey.currentState;

      if (form!.validate()) {
        form.save();
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        showModalBottomSheet(

                isScrollControlled: true,
                context: context,
                isDismissible: false,
                builder: (context) => SmsPreview()
            );
          }
      },
          child: Container(
            color: kRedColor,
            height: 56.sp,
            child: Center(
              child: Text('Send'.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kWhiteColor,fontWeight: FontWeight.bold)

              ),
            ),
          ),
        ),
          body: ProgressHUDFunction(
              inAsyncCall: usersContact.loading,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: kMargin),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      spacing(context),
                      usersContact.allContact.length == 0?
                      Text("No contact selected",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kLightBlue,fontSize: kFontSize12,fontWeight: FontWeight.normal)
                      )
                          :Text("${ usersContact.allContact.toSet().length.toString()} Contact(s)",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kLightBlue,fontSize: kFontSize12,fontWeight: FontWeight.bold)
                      ),
                      GestureDetector(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                              color: kWhiteColor,
                              border: Border.all(width: 1.0,color: kHintColor)
                          ),
                          child: usersContact.selectedContactGroup != null?
                          Center(child: SelectedContactGroupList())
                              :Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text("contact group", style: Theme.of(context).textTheme.overline),
                              )),
                        ),
                      ),

                      // spacing(context),
                      // GestureDetector(
                      //   onTap: (){contactGroupScreenRoute(context);},
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     height: MediaQuery.of(context).size.height * 0.07,
                      //     decoration: BoxDecoration(
                      //         color: kWhiteColor,
                      //         border: Border.all(width: 1.0,color: kHintColor)
                      //     ),
                      //     child: Align(
                      //         alignment: Alignment.centerLeft,
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(12.0),
                      //           child: Text("Select contact", style: Theme.of(context).textTheme.overline),
                      //         )),
                      //   ),
                      // ),

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


                      //spacing(context),


                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [

                            Container(
                              height:MediaQuery.of(context).size.height * 0.07,
                              child: TextFormField(
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

                                  suffixIcon: GestureDetector(
                                      onTap: (){
                                        usersContact.addEnteredContact(_countryCode + _phoneNumber.text);

                                        _phoneNumber.clear();
                                      },
                                      child: SvgPicture.asset('assets/add_contact.svg')),

                                  isDense: true,
                                  hintText: "Add recipient number",
                                  hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
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
                            ),
                            spacing(context),

                            TextFormField(
                              controller: _from,
                              cursorColor: (kOrangeColor),
                              keyboardType: TextInputType.text,
                              validator: Validator.validateFrom,
                              textCapitalization: TextCapitalization.sentences,
                              maxLength: 15,
                              style: Theme.of(context).textTheme.bodyText1,
                              decoration: InputDecoration(
                                hintText: 'From',
                                hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,

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

                            Container(
                              //height: MediaQuery.of(context).size.height * 0.4,
                              child: TextFormField(
                                controller: _message,
                                textAlign: TextAlign.center,
                                autocorrect: true,
                                cursorColor: (kOrangeColor),
                                keyboardType: TextInputType.text,
                                validator: Validator.validateMessage,
                                style: Theme.of(context).textTheme.bodyText1,
                                textCapitalization: TextCapitalization.sentences,
                                maxLength: 150,
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: 'Type your text here'.toUpperCase(),
                                  hintStyle: Theme.of(context).inputDecorationTheme.hintStyle!.copyWith(color: kTextColor,),
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




                ),
              )
          )),



    );
  }
}
