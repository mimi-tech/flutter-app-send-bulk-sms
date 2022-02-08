import 'dart:io';
import 'package:bulk_sms/components/modalProgressFunction.dart';
import 'package:bulk_sms/models/new_user.dart';
import 'package:bulk_sms/view_model/fund_wallet_provider.dart';
import 'package:bulk_sms/view_model/users_Auth_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as https;

import 'package:bulk_sms/components/appbar.dart';
import 'package:bulk_sms/components/appbar2.dart';
import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/components/header.dart';
import 'package:bulk_sms/components/progressIndicator.dart';
import 'package:bulk_sms/components/sms_buttons.dart';
import 'package:bulk_sms/models/card_details.dart';
import 'package:bulk_sms/services/funding_services.dart';
import 'package:bulk_sms/utility/cardMonthInputFormatter.dart';
import 'package:bulk_sms/utility/cardNumberFormatter.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/dimen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';

class BankAccountDeposit extends StatefulWidget {
  const BankAccountDeposit({Key? key}) : super(key: key);

  @override
  _BankAccountDepositState createState() => _BankAccountDepositState();
}

class _BankAccountDepositState extends State<BankAccountDeposit> {
  String bank = '';
  String accountNumber = '';


  TextEditingController _bank = TextEditingController();
  TextEditingController _accountNumber = TextEditingController();

  TextEditingController _amount = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GetBanksResponse? selectedBank;
  Future<List<GetBanksResponse>>? banks;


  @override
  void initState() {
    super.initState();
    //this.banks = FServices.getBanks(https.Client());

  }

  Widget _banks() {
    return FutureBuilder(
        future: this.banks,//FServices.getBanks(),
        builder: (BuildContext context, AsyncSnapshot<List<GetBanksResponse>> snapshot){

          if (snapshot.hasError) {
            return Center(child: Text("Unable to fetch banks."));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ShowProgress();
          }
          return this._bankLists(snapshot.data!);



        });
  }

  Widget _bankLists(List<GetBanksResponse> banks) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,

      child: SingleChildScrollView(
        child: Column(
          children: [
            StickyHeader(
                header:  Header(title: 'Choose your bank'.toUpperCase(),),


                content:ListView(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: banks.map((bank) => GestureDetector(
                    onTap: () => {this._handleBankTap(bank)},
                    child: Column(
                      children: [

                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.ac_unit,color: kOrangeColor,),
                                SizedBox(width: 10,),
                                Text(bank.bankName.toString(),
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyText1!


                                )

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  )
                      .toList(),
                )),
          ],
        ),
      ),
    );
  }
  void _handleBankTap(final GetBanksResponse selectedBank) {
    this._removeFocusFromView();
    this.selectedBank = selectedBank;
    //Navigator.pop(this.context);
    bankName = selectedBank.bankName.toString();
    bankCode  =selectedBank.bankCode.toString();
    _bank.text = selectedBank.bankName.toString();
    Navigator.pop(context);
  }

  void _removeFocusFromView() {
    FocusScope.of(this.context).requestFocus(FocusNode());
  }

  void _showBottomSheet() {
    Platform.isIOS?
    showCupertinoModalPopup(

        context: context, builder: (BuildContext context) {
      return CupertinoActionSheet(
        actions: <Widget>[
          this._banks()

        ],
      );
    })
        :showModalBottomSheet(
      context: this.context,
      isDismissible: true,
      builder: (context) {
        return this._banks();
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    NewUser user = Provider.of<UserProvider>(context).user;

    return SafeArea(
        child: ChangeNotifierProvider<FundWalletService2>(
            create: (context)=> FundWalletService2(),
            builder: (context,child){


              return Consumer<FundWalletService2>(
                  builder: (context, modal, child){
                    return Scaffold(
            appBar: BulkSmsAppbar(

                color:kBlackColor,
                title: '${AppLocalizations.of(context)!.fundWallet}'

            ),

            body:  ProgressHUDFunction(
              inAsyncCall: modal.loading,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: kMargin),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    children: [

                      spacing(context),

                      Center(
                        child: Text(
                            AppLocalizations.of(context)!.payWithBankAccount.toUpperCase(),
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold)
                        ),
                      ),
                      spacing(context),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            spacing(context),
                            Text('Select bank',
                                style: Theme.of(context).textTheme.bodyText1
                            ),

                            TextFormField(
                              readOnly: true,
                              onTap: ()=>_showBottomSheet(),
                              controller: _bank,
                              autocorrect: true,
                              autofocus: true,
                              cursorColor: (kOrangeColor),
                              keyboardType: TextInputType.text,
                              style: Theme.of(context).textTheme.bodyText1,
                              validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.payWithBankAccount1: null,
                              decoration: InputDecoration(

                                hintText: 'Select bank',
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
                                bankName = value;

                              },
                            ),
                            spacing(context),
                            Text('Account Number',
                                style: Theme.of(context).textTheme.bodyText1
                            ),
                            TextFormField(
                              controller: _accountNumber,
                              autocorrect: true,
                              autofocus: true,
                              cursorColor: (kOrangeColor),
                              keyboardType: TextInputType.number,
                              style: Theme.of(context).textTheme.bodyText1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,

                                LengthLimitingTextInputFormatter(10),
                              ],
                              validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.payWithBankAccount2: null,

                              decoration: InputDecoration(
                                hintText: 'Account Number',
                                hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                                errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
                                border: Theme.of(context).inputDecorationTheme.border,
                                enabledBorder:Theme.of(context).inputDecorationTheme.enabledBorder,
                                focusedBorder:Theme.of(context).inputDecorationTheme.focusedBorder,
                                focusedErrorBorder:Theme.of(context).inputDecorationTheme.focusedErrorBorder,
                                errorBorder:Theme.of(context).inputDecorationTheme.errorBorder,
                                contentPadding: Theme.of(context).inputDecorationTheme.contentPadding,
                              ),
                              onChanged: (String value){
                                if(_accountNumber.text.length == 10){
                                  //modal.getResolveAccountNumber();
                                }
                              },
                              onSaved: (String? value) {
                                bankAccountNumber = value;
                              },
                            ),
                            Text(modal.bankName,
                                style: Theme.of(context).textTheme.bodyText1
                            ),
                            spacing(context),
                            Text('Amount',
                                style: Theme.of(context).textTheme.bodyText1
                            ),
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
                              validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.payWithBankAccount3: null,

                              decoration: InputDecoration(
                                hintText: 'Amount you want to fund',
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
                                amount = int.parse(value!);
                              },
                            ),
                            spacing(context),
                          ],
                        ),
                      ),
                      spacing(context),
                      SmsButtons(title: AppLocalizations.of(context)!.fundWallet.toUpperCase(),
                          color: kOrangeColor,
                          tapSmsButton: () async {
                          final form = _formKey.currentState;
                          if (form!.validate()) {
                            form.save();
                            //modal.getChargeAccount(context, user.email,user.phoneNumber, user.fullName);


                          }

                          }
                      )
                    ],
                  ),




                ),
              ),
            ));
                    });
                    }));
  }


}
