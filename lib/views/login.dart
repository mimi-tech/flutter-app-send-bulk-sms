import 'package:bulk_sms/components/appbar.dart';
import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/components/modalProgressFunction.dart';
import 'package:bulk_sms/components/sms_buttons.dart';

import 'package:bulk_sms/utility/Validators.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/dimen.dart';
import 'package:bulk_sms/utility/routes.dart';
import 'package:bulk_sms/view_model/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    void _loginUser() {
      final form = _formKey.currentState;

      if (form!.validate()) {
        form.save();
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        auth.getLogin(context);
      }}
    return SafeArea(child: Scaffold(
      appBar: BulkSmsAppbar(color: kOrangeColor,
          title: '${AppLocalizations.of(context)!.appName} ${AppLocalizations
              .of(context)!.appbarRegText}'),
      body: ProgressHUDFunction(
        inAsyncCall: auth.loading,
        child: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: kMargin),
              child: Column(
                children: [
                  spacing(context),

                  Center(
                    child: Text(
                        AppLocalizations.of(context)!.loginText.toUpperCase(),
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.bold)
                    ),
                  ),
                  spacing(context),

                  spacing(context),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _email,
                          autocorrect: true,
                          autofocus: true,
                          cursorColor: (kOrangeColor),
                          keyboardType: TextInputType.emailAddress,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1,
                          validator: Validator.validateEmail,

                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.emailText,
                            hintStyle: Theme
                                .of(context)
                                .inputDecorationTheme
                                .hintStyle,
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
                            emailAddress = value;
                          },
                        ),
                        spacing(context),
                        TextFormField(
                          controller: _password,
                          autocorrect: true,
                          autofocus: true,
                          cursorColor: (kOrangeColor),
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!
                                .passwordText,

                            hintStyle: Theme
                                .of(context)
                                .inputDecorationTheme
                                .hintStyle,
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


                  spacing(context),

                  GestureDetector(

                    onTap: () {
                      verifyEmailForgotPassword(context);
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          AppLocalizations.of(context)!.forgotPassword,
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontWeight: FontWeight.normal,color: Colors.blue)
                      ),
                    ),
                  ),
                  spacing(context),
                  spacing(context),
                  Align(
                      alignment: Alignment.center,
                      child: SmsButtons(
                        title: AppLocalizations.of(context)!.loginText,
                        color: kOrangeColor,
                        tapSmsButton: () {
                          _loginUser();
                        },
                      )
                  ),


                ],
              )
          ),
        ),
      ),
    ));
  }

  // void _loginUser() {
  //   final form = _formKey.currentState;
  //
  //   if (form!.validate()) {
  //     form.save();
  //
  //     final Future<Map<String, dynamic>> successfulMessage =
  //     auth!.login(emailAddress!, password!);
  //
  //     successfulMessage.then((response) {
  //       if (response['status']) {
  //         User user = response['data'];
  //         //Provider.of<UserProvider>(context, listen: false).setUser(user);
  //         landingPage(context);
  //         notifyFlutterToastSuccess(title: AppLocalizations.of(context)!.loginSuccess);
  //       }
  //     });
  //   }
  // }
}
