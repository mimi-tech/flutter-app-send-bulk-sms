import 'package:bulk_sms/components/appbar.dart';
import 'package:bulk_sms/components/appbar2.dart';
import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/components/modalProgressFunction.dart';
import 'package:bulk_sms/components/progressIndicator.dart';
import 'package:bulk_sms/components/sms_buttons.dart';
import 'package:bulk_sms/models/new_user.dart';
import 'package:bulk_sms/utility/Validators.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/dimen.dart';
import 'package:bulk_sms/view_model/fund_wallet_provider.dart';
import 'package:bulk_sms/view_model/users_Auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransferFunds extends StatefulWidget {
  const TransferFunds({Key? key}) : super(key: key);

  @override
  _TransferFundsState createState() => _TransferFundsState();
}

class _TransferFundsState extends State<TransferFunds> {
  TextEditingController _amount = TextEditingController();
  TextEditingController _email = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    NewUser user = Provider.of<UserProvider>(context).user;

    return SafeArea(

      child: ChangeNotifierProvider<FundWalletService2>(
          create: (context)=> FundWalletService2(),
          builder: (context,child) {
            return Scaffold(
        appBar: BulkSmsAppbarSecond(title: "Transfer Funds",color: kBlackColor,
        deleteButton:  SmsButtons(
            title: user.wallet.toString(),
            color: kOrangeColor,
            tapSmsButton: (){}

        ),
        ),

        body:  ProgressHUDFunction(
          inAsyncCall: FundWalletService2().loading,
          child: Container(
      margin: EdgeInsets.symmetric(horizontal: kMargin),
      child: Column(
            children: [

              spacing(context),
                    spacing(context),

                    Center(
                      child: Text(AppLocalizations.of(context)!.transferCaption,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(color: kNavyColor),

                      ),
                    ),
              Form(
                  key: _formKey,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                  spacing(context),
                  spacing(context),
                    Text(AppLocalizations.of(context)!.transferText3,
                      style: Theme.of(context).textTheme.caption!.copyWith(color: kAshColor),

                    ),
                    TextFormField(
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
                    Text(AppLocalizations.of(context)!.transferText2,
                      style: Theme.of(context).textTheme.caption!.copyWith(color: kAshColor),

                    ),
                    spacing(context),
                    TextFormField(
                      controller: _amount,
                      autocorrect: true,
                      autofocus: true,
                      cursorColor: (kOrangeColor),
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).textTheme.bodyText1,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: Validator.validateTransferAmount,
                      decoration: InputDecoration(
                        hintText: 'Amount not less than 100 NGN',
                        labelText: 'Amount',
                        labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                        errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
                        border: Theme.of(context).inputDecorationTheme.border,
                        enabledBorder:Theme.of(context).inputDecorationTheme.enabledBorder,
                        focusedBorder:Theme.of(context).inputDecorationTheme.focusedBorder,
                        focusedErrorBorder:Theme.of(context).inputDecorationTheme.focusedErrorBorder,
                        errorBorder:Theme.of(context).inputDecorationTheme.errorBorder,
                        contentPadding: Theme.of(context).inputDecorationTheme.contentPadding,
                      ),
                      onSaved: (value) {
                        amount = int.parse(value!);
                      },
                    ),

              ])),
              spacing(context),
              spacing(context),
    Consumer<FundWalletService2>(
    builder: (context, modal, child){
             return modal.loading == false?SmsButtons(
                  title: AppLocalizations.of(context)!.transferText,
                  color: kOrangeColor,
                  tapSmsButton: (){
                    final form = _formKey.currentState;
                    if(form!.validate()) {
                      form.save();
                      FocusScope.of(this.context).requestFocus(FocusNode());

                      modal.getTransferFunds(context);

                    }
                  }
              ):ShowProgress();
    })
            ],
          )),
        ));
    })

      );

  }
}
