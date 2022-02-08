import 'package:bulk_sms/components/appbar.dart';
import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/components/modalProgressFunction.dart';
import 'package:bulk_sms/components/sms_buttons.dart';
import 'package:bulk_sms/components/validation_dialog.dart';
import 'package:bulk_sms/utility/Validators.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/dimen.dart';
import 'package:bulk_sms/utility/routes.dart';
import 'package:bulk_sms/view_model/email_services_view_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {

  TextEditingController _email = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    MessageServicesEmail messageServices = context.watch<MessageServicesEmail>();
    MessageServicesEmail auth = Provider.of<MessageServicesEmail>(context);

    return SafeArea(child: Scaffold(
      appBar: BulkSmsAppbar(color:kOrangeColor,title: '${AppLocalizations.of(context)!.appName} ${AppLocalizations.of(context)!.forgotPasswordText}'),
      body: ProgressHUDFunction(
        inAsyncCall: messageServices.loading,
        child: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: kMargin),
              child: Column(
                children: [
                  spacing(context),

                  Center(
                    child: Text(
                        AppLocalizations.of(context)!.emailText,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold)
                    ),
                  ),
                  spacing(context),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      controller: _email,
                      autocorrect: true,
                      autofocus: true,
                      cursorColor: (kOrangeColor),
                      keyboardType: TextInputType.emailAddress,
                      style: Theme.of(context).textTheme.bodyText1,
                      validator: Validator.validateEmail,

                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.emailText,
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
                        emailAddress = value;
                      },
                    ),
                  ),
                  spacing(context),
                  Center(
                    child: Text(
                        AppLocalizations.of(context)!.emailSubtitle,
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(color: kAshColor)
                    ),
                  ),
                  space(context),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: SmsButtons(
                        title: AppLocalizations.of(context)!.validate,
                        color: kOrangeColor,
                        tapSmsButton: (){
                          final form = _formKey.currentState;
                          if(form!.validate()) {
                            form.save();
                            isForgotPassword = true;
                            auth.emailMessageService(context: context);

                          }
                          }

                      )
                  ),


                ],
              )
          ),
        ),
      ),
    ));


  }
}
