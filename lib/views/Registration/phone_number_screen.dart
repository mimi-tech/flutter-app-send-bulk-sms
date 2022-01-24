import 'package:bulk_sms/components/appbar.dart';
import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/components/modalProgressFunction.dart';
import 'package:bulk_sms/components/sms_buttons.dart';
import 'package:bulk_sms/components/validation_dialog.dart';
import 'package:bulk_sms/utility/Validators.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/dimen.dart';
import 'package:bulk_sms/utility/routes.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:bulk_sms/view_model/message_service_view_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {

  TextEditingController _phoneNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _countryCode = '';

  @override
  Widget build(BuildContext context) {

    return SafeArea(child:

    ChangeNotifierProvider<MessageServices>(
        create: (context)=> MessageServices(),
    builder: (context,child){
          return

          Consumer<MessageServices>(
          builder: (context, modal, child){
            return Scaffold(
                appBar: BulkSmsAppbar(color:kOrangeColor,title: '${AppLocalizations.of(context)!.appName} ${AppLocalizations.of(context)!.appbarRegText}'),
                body: ProgressHUDFunction(
                inAsyncCall: modal.loading,
            child: SingleChildScrollView(
            child: Container(
            margin: EdgeInsets.symmetric(horizontal: kMargin),
            child: Column(
            children: [
            spacing(context),

            Center(
            child: Text(
            AppLocalizations.of(context)!.phoneErrorText,
            style:Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold)
                    ),
                  ),

                 modal.userError != null?
                  Text( modal.userError!.message,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kRedColor),
                  )
                      :Text(''),
                    modal.userSuccess != null?
                  Text( modal.userSuccess!.message,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.green),
                  )
                      :Text(''),
                  spacing(context),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      controller: _phoneNumber,
                      autocorrect: true,
                      autofocus: true,
                      cursorColor: (kOrangeColor),
                      keyboardType: TextInputType.number,
                      textCapitalization: TextCapitalization.sentences,
                      style: Theme.of(context).textTheme.bodyText1,
                      validator: Validator.validatePhoneNumber,
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

                        hintText: AppLocalizations.of(context)!.phoneNumber,
                        hintStyle: Theme.of(context).inputDecorationTheme.helperStyle,
                        errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
                        border: Theme.of(context).inputDecorationTheme.border,
                        enabledBorder:Theme.of(context).inputDecorationTheme.enabledBorder,
                        focusedBorder:Theme.of(context).inputDecorationTheme.focusedBorder,
                        focusedErrorBorder:Theme.of(context).inputDecorationTheme.focusedErrorBorder,
                        errorBorder:Theme.of(context).inputDecorationTheme.errorBorder,
                        contentPadding: Theme.of(context).inputDecorationTheme.contentPadding,
                      ),
                      onSaved: (String? value) {
                        phoneNumber = _countryCode + value!;
                      },
                    ),
                  ),
                  spacing(context),
                  Center(
                    child: Text(
                        AppLocalizations.of(context)!.phoneText,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(color: kAshColor)
                    ),
                  ),
                  space(context),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SmsButtons(
                        title: AppLocalizations.of(context)!.validate,
                        color: kOrangeColor,
                        tapSmsButton: () {
                          final form = _formKey.currentState;
                          if (form!.validate()) {
                            form.save();
                            //auth.smsMessageService();

                            FocusScopeNode currentFocus = FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            emailScreen(context);
                          }
                        })
                  ),


                ],
              )
          ),
        ),
      ),
    );
    }
    );
    }));


  }
}
