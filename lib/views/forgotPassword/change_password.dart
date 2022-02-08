import 'package:bulk_sms/components/appbar.dart';
import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/components/modalProgressFunction.dart';
import 'package:bulk_sms/components/sms_buttons.dart';
import 'package:bulk_sms/utility/Validators.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/dimen.dart';
import 'package:bulk_sms/view_model/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    void _doResetPassword() {
      final form = _formKey.currentState;
      if (form!.validate()) {
        form.save();
        if(_password.text.trim() != _confirmPassword.text.trim()){
          return notifyFlutterToastError(title:"Password doesn't match");
        }
        auth.resetPassword(context);
      }}
    return SafeArea(child: Scaffold(
      appBar: BulkSmsAppbar(color:kOrangeColor,title: '${AppLocalizations.of(context)!.appName} ${AppLocalizations.of(context)!.appbarRegText}'),
      body: ProgressHUDFunction(
          inAsyncCall: auth.loading,
        child: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: kMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spacing(context),
                  spacing(context),


                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            AppLocalizations.of(context)!.passwordText,
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold)
                        ),
                        TextFormField(
                          controller: _password,
                          autocorrect: true,
                          autofocus: true,
                          cursorColor: (kOrangeColor),
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          style: Theme.of(context).textTheme.bodyText1,
                          validator: Validator.validatePassword,

                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.passwordText,
                            hintStyle: Theme.of(context).inputDecorationTheme.helperStyle,
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
                        Text(
                            AppLocalizations.of(context)!.confirmPassword,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.bold)
                        ),
                        TextFormField(
                          controller: _confirmPassword,
                          autocorrect: true,
                          autofocus: true,
                          cursorColor: (kOrangeColor),
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1,
                          validator: Validator.validatePassword,

                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!
                                .confirmPassword,

                            hintStyle: Theme
                                .of(context)
                                .inputDecorationTheme
                                .helperStyle,
                            errorStyle: Theme
                                .of(context)
                                .inputDecorationTheme
                                .errorStyle,
                            border: Theme
                                .of(context)
                                .inputDecorationTheme
                                .border,
                            enabledBorder: Theme
                                .of(context)
                                .inputDecorationTheme
                                .enabledBorder,
                            focusedBorder: Theme
                                .of(context)
                                .inputDecorationTheme
                                .focusedBorder,
                            focusedErrorBorder: Theme
                                .of(context)
                                .inputDecorationTheme
                                .focusedErrorBorder,
                            errorBorder: Theme
                                .of(context)
                                .inputDecorationTheme
                                .errorBorder,
                            contentPadding: Theme
                                .of(context)
                                .inputDecorationTheme
                                .contentPadding,
                          ),
                          onSaved: (String? value) {
                            password = value;
                          },
                        ),
                      ],
                    ),
                  ),

                  space(context),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: SmsButtons(
                        title: AppLocalizations.of(context)!.submitText,
                        color: kOrangeColor,
                        tapSmsButton: ()=>_doResetPassword()
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
