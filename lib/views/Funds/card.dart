import 'dart:io';

import 'package:bulk_sms/components/appbar.dart';
import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/components/modalProgressFunction.dart';
import 'package:bulk_sms/components/sms_buttons.dart';
import 'package:bulk_sms/models/new_user.dart';
import 'package:bulk_sms/services/funding_services.dart';
import 'package:bulk_sms/utility/Validators.dart';
import 'package:bulk_sms/utility/cardMonthInputFormatter.dart';
import 'package:bulk_sms/utility/cardNumberFormatter.dart';
import 'package:bulk_sms/utility/card_utils.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/dimen.dart';
import 'package:bulk_sms/utility/shared_prefrences.dart';
import 'package:bulk_sms/view_model/fund_wallet_provider.dart';
import 'package:bulk_sms/view_model/users_Auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CardDeposit extends StatefulWidget {
  const CardDeposit({Key? key}) : super(key: key);

  @override
  _CardDepositState createState() => _CardDepositState();
}

class _CardDepositState extends State<CardDeposit> {
  String cardNumber = '';
  String cardHolderName = '';
  String expiryDate = '';
  String cvv = '';
  String cardBankName ='';
  var result;
  bool showBack = false;
  TextEditingController _cardNumber = TextEditingController();
  TextEditingController _expDate = TextEditingController();
  TextEditingController _holderName = TextEditingController();
  TextEditingController _cvv = TextEditingController();
  TextEditingController _amount = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final plugin = PaystackPlugin();
  @override
  void initState() {
  super.initState();
  plugin.initialize(publicKey:"${dotenv.env['PAYSTACK_PUBLIC_KEY']}");

  //getting the shared pref of users card details
  UserPreferences().getCardDetailsNew().then((value) => {
  if((value.cardFirstFourDigit != '' || value.cardFirstFourDigit != null)){
    binCardNumber = "${value.cardFirstFourDigit}",
    authorizationCode  = "${value.authorizationCode}",
    cardBankName  = "${value.cardBank}",
    _cardNumber.text = "${value.cardFirstFourDigit!.substring(0,4)}  xxxx  xxxx  ${value.cardLastFourDigit!.substring(0,4)}",

  }}
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

                   if(binCardNumber != ''){
                     modal.getVerifyCardBin(context);
                   }

                 return Scaffold(
                     appBar: BulkSmsAppbar(
                         color:kBlackColor,
                         title: '${AppLocalizations.of(context)!.fundWallet}'

                     ),

                     body:ProgressHUDFunction(
                     inAsyncCall: modal.loading,
                 child: SingleChildScrollView(
                 child: Container(
                 margin: EdgeInsets.symmetric(horizontal: kMargin),
                 child: Column(
                 mainAxisSize: MainAxisSize.min,

                 children: [
                 FlatButton(onPressed: () async{
                   print(binCardNumber);
                   print(binCardNumber);
                   var result = await UserPreferences().getCardDetailsNew();
                   print(result.cardFirstFourDigit);

                 }, child: Text("ksajsdk"),
                 color: kGreenColor,
                 ),
                 spacing(context),

                 Center(
                 child: Text(
                 AppLocalizations.of(context)!.cardDetails.toUpperCase(),
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

                 TextFormField(
                 controller: _cardNumber,
                 autocorrect: true,
                 autofocus: true,
                 cursorColor: (kOrangeColor),
                 keyboardType: TextInputType.number,
                 style: Theme.of(context).textTheme.bodyText1,
                 validator: (value) => value!.isEmpty ? AppLocalizations.of(context)!.cardDetails: null,

                 inputFormatters: [
                 FilteringTextInputFormatter.digitsOnly,
                 LengthLimitingTextInputFormatter(16),
                 CardNumberInputFormatter()
                 ],
                 decoration: InputDecoration(
                 labelText: 'Card Number',
                 labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                 suffixIcon:  modal.brand != ""?modal.brand =='Mastercard'?
                 SvgPicture.asset('assets/master_card.svg')
                     :SvgPicture.asset('assets/visa2.svg'):Text(''),
                 errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
                 border: Theme.of(context).inputDecorationTheme.border,
                 enabledBorder:Theme.of(context).inputDecorationTheme.enabledBorder,
                 focusedBorder:Theme.of(context).inputDecorationTheme.focusedBorder,
                 focusedErrorBorder:Theme.of(context).inputDecorationTheme.focusedErrorBorder,
                 errorBorder:Theme.of(context).inputDecorationTheme.errorBorder,
                 contentPadding: Theme.of(context).inputDecorationTheme.contentPadding,
                 ),
                 onChanged: (String value) async {
                 if(_cardNumber.text.length == 22){
                   cardNumber = CardUtils.getCleanedNumber(value);
                   binCardNumber = cardNumber.substring(0,6);

                 await modal.getVerifyCardBin(context);
                 }
                 },
                 onSaved: (String? value) {
                 cardNumber = CardUtils.getCleanedNumber(value!);
                 },
                 ),


                   Text(modal.bank.toString(),
                     style: Theme.of(context).textTheme.subtitle1!.copyWith(color: kTextColor),

                   ),
                   spacing(context),
                 Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [

                 Container(
                 width:MediaQuery.of(context).size.width * 0.4,
                 child: TextFormField(
                 controller: _expDate,
                 autocorrect: true,
                 autofocus: true,
                 cursorColor: (kOrangeColor),
                 keyboardType: TextInputType.number,
                 style: Theme.of(context).textTheme.bodyText1,
                 inputFormatters: [
                 FilteringTextInputFormatter.digitsOnly,

                 LengthLimitingTextInputFormatter(4),
                 CardMonthInputFormatter()
                 ],
                 validator: Validator.validateDate,

                 decoration: InputDecoration(
                 labelText: 'Expiring date',
                 labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                 errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
                 border: Theme.of(context).inputDecorationTheme.border,
                 enabledBorder:Theme.of(context).inputDecorationTheme.enabledBorder,
                 focusedBorder:Theme.of(context).inputDecorationTheme.focusedBorder,
                 focusedErrorBorder:Theme.of(context).inputDecorationTheme.focusedErrorBorder,
                 errorBorder:Theme.of(context).inputDecorationTheme.errorBorder,
                 contentPadding: Theme.of(context).inputDecorationTheme.contentPadding,
                 ),
                 onSaved: (value) {
                 List<int> expiryDate = CardUtils.getExpiryDate(value!);
                 expiryMonth = expiryDate[0];
                 expiryYear = expiryDate[1];
                 },
                 ),
                 ),


                 Container(
                 width:MediaQuery.of(context).size.width * 0.4,
                 child: TextFormField(
                 controller: _cvv,
                 autocorrect: true,
                 autofocus: true,
                 cursorColor: (kOrangeColor),
                 keyboardType: TextInputType.number,
                 style: Theme.of(context).textTheme.bodyText1,
                 inputFormatters: [
                 FilteringTextInputFormatter.digitsOnly,

                 LengthLimitingTextInputFormatter(4),
                 ],
                 validator: (value) => value!.isEmpty ? 'Please enter card cvv correctly': null,

                 decoration: InputDecoration(
                 labelText: 'Card cvv',
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
                 cvv = value!;
                 },
                 ),
                 ),
                 ],
                 ),
                 spacing(context),
                 TextFormField(
                 controller: _holderName,
                 autocorrect: true,
                 autofocus: true,
                 cursorColor: (kOrangeColor),
                 keyboardType: TextInputType.text,

                style: Theme.of(context).textTheme.bodyText1,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.sentences,
                validator: (value) => value!.isEmpty ? 'Please enter card card holder name correctly': null,

                decoration: InputDecoration(
                  labelText: 'Card name',
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
                  cardName = value!;
                  binCardNumber = cardNumber.substring(0,6);
                },
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
                                    validator: Validator.validateAmount,
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
                                      // String newValue = value! +'00';
                                      // int paddedAmount = int.parse(newValue);
                                      // amount = paddedAmount;
                                      // print("New amount $amount");
                                    },
                                  ),
                                  spacing(context),
                                ],
                              ),
                            ),

                        SmsButtons(title: AppLocalizations.of(context)!.fundWallet.toUpperCase(),
                            color: kOrangeColor,
                            tapSmsButton: () async {
                              final form = _formKey.currentState;
                              if (form!.validate()) {
                                form.save();
                                //fund the wallet
                                var inputFirstBinDigit = _cardNumber.text.substring(0,4);
                                var saveFirstBinDigit = binCardNumber.toString().substring(0,4);

                                //get the last digit

                                if((inputFirstBinDigit == saveFirstBinDigit) && authorizationCode != ''){
                                  //charge customer from authorization
                                 await modal.chargeAuthorization(context,user.email);
                                }else{

                                try {

                                  //resolve the card
                                await modal.getVerifyCardBin_2(context,user.phoneNumber!,user.email!,user.fullName!);
                                //initialize payment
                                  var result = await FServices.initializePayment(context,user.email!);
                          //CHARGE THE CARD
                          Charge charge  = Charge();
                          charge.card = _getCardFromUI();
                          charge
                          ..amount = amount! // In base currency
                          ..email = user.email
                          ..card = _getCardFromUI()
                         // ..reference = _getReference()
                          ..accessCode = result["access_code"]

                          ..putCustomField('Charged From', 'Bulk sms');
                          chargeCard(charge,modal);


                          } on HttpException {
                          throw Exception("No internet");
                          } on FormatException {
                          throw Exception("Invalid format");
                          }on SocketException {
                            throw Exception("Internal server error");
                          } catch (e) {
                          throw Exception(e);
                          }

                             }}}
                            )

                          ],
                        ),




                      ),
                    )));
                  });
        }));


  }


  chargeCard(Charge charge, FundWalletService2 modal) async {
    final response = await plugin.chargeCard(context, charge: charge);

    //final reference = response.reference;

    // Checking if the transaction is successful
    if (response.message == 'Success') {
      print(response.reference);
      modal.fundingUserWallet(response.reference,context);
    }
  }
  PaymentCard _getCardFromUI() {
    return PaymentCard(
      number: cardNumber,
      cvc: cvv,
      expiryMonth: expiryMonth,
      expiryYear: expiryYear,
    );
  }



}
