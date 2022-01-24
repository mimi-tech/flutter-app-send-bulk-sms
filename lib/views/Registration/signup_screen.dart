import 'package:bulk_sms/components/appbar.dart';
import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/utility/Validators.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/dimen.dart';
import 'package:bulk_sms/utility/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController _fName = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: BulkSmsAppbar(color:kOrangeColor,title: '${AppLocalizations.of(context)!.appName} ${AppLocalizations.of(context)!.appbarRegText}'),
      body: SingleChildScrollView(
        child: Container(
        margin: EdgeInsets.symmetric(horizontal: kMargin),
        child: Column(
          children: [
            spacing(context),

            Center(
              child: Text(
                  AppLocalizations.of(context)!.fullNameErrorText,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold)
              ),
            ),
            spacing(context),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(

                controller: _fName,
                autocorrect: true,
                autofocus: true,
                cursorColor: (kOrangeColor),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                style: Theme.of(context).textTheme.bodyText1,
                validator: Validator.validateFullName,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.fullName,
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
                  fullName = value;
                  },
              ),
            ),
            space(context),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: (){
    final form = _formKey.currentState;
    if(form!.validate()) {
      form.save();

      phoneNumberScreenRoutes(context);
    }},
                child: Container(
                    decoration: BoxDecoration(
                      color: kNavyColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: kWhiteColor,width: 1.0)
                  ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Icon(Icons.arrow_forward,color: kWhiteColor,size: kIconButtonPadding,),
                    )),
              ),
              ),


          ],
        )
    ),
      ),
    ));


  }
}
