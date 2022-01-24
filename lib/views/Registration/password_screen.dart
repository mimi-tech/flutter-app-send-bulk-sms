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

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {

  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CircularProgressIndicator(),

    ],
  );



  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    Future<void> _doRegister() async {
      final form = _formKey.currentState;
      if (form!.validate()) {
        form.save();
        if(_password.text.trim() != _confirmPassword.text.trim()){
          return notifyFlutterToastError(title:"Password doesn't match");
        }
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        await auth.userRegistration(context);
        await auth.getLogin(context);
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

                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        spacing(context),
                        Text(
                            AppLocalizations.of(context)!.passwordText,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.bold)
                        ),
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
                          validator: Validator.validatePassword,

                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.passwordText,
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
                          onChanged: (String value) {},
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
                        tapSmsButton: () {
                          _doRegister();
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

  void latter() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      //auth.register();

    //   auth!.register(fullName!, phoneNumber!, emailAddress!, password!).then((
    //       response) {
    //     if (response['status'] == true) {
    //       //User user = response['data'];
    //
    //       //log the user in
    //       // final Future<Map<String,dynamic>> response =  loginAuth!.login(emailAddress!, password!);
    //       //
    //       // response.then((response) {
    //       //   if (response['status']) {
    //       //     User user = response['data'];
    //       //     // now we will create shared preferences and save data
    //       //
    //       //
    //       //   }
    //       //
    //       //   });
    //
    //
    //       final Future<Map<String, dynamic>> successfulMessage =
    //       auth!.login(emailAddress!, password!);
    //
    //       successfulMessage.then((response) {
    //         if (response['status']) {
    //           User user = response['user'];
    //           //Provider.of<UserProvider>(context, listen: false).setUser(user);
    //
    //           landingPage(context);
    //           notifyFlutterToastSuccess(title: AppLocalizations.of(context)!.regSuccess);
    //
    //         }
    //       });
    //     }
    //   });
    // }
  }
}}



