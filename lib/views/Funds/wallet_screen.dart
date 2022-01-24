import 'package:bulk_sms/components/appbar.dart';
import 'package:bulk_sms/components/appbar2.dart';
import 'package:bulk_sms/components/progressIndicator.dart';
import 'package:bulk_sms/components/sms_buttons.dart';
import 'package:bulk_sms/models/new_user.dart';
import 'package:bulk_sms/models/transaction_model.dart';
import 'package:bulk_sms/services/funding_services.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/routes.dart';
import 'package:bulk_sms/view_model/users_Auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as https;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  Future<List<TransactionModel>>? transactionList;
  var fullName = '';
  @override
  void initState() {
    super.initState();
    this.transactionList = FServices.customerTransactions(https.Client());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.transactionList = FServices.customerTransactions(https.Client());
  }


  Widget _transactionsList() {
    return FutureBuilder(
        future: this.transactionList,
        builder: (BuildContext context, AsyncSnapshot<List<TransactionModel>> snapshot) {
          if (snapshot.hasData) {
            return this._transactionList(snapshot.data!);
          }
          if (snapshot.hasError) {
            return Center(child: Text("Unable to fetch your transactions at the moment."));
          }


          return ShowProgress();
        });
  }

  Widget _transactionList(final List<TransactionModel> data) {

    return SingleChildScrollView(
      child: Column(
        children: [
          ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: data.map((paymentData) => GestureDetector(

                  child: Card(
                    elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(fullName.toString(),
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kTextColor),

                                ),
                                Column(
                                  children: [
                                    Text(paymentData.status,
                                      style: paymentData.status.toString().toLowerCase() == "success"?
                                      Theme.of(context).textTheme.bodyText1!.copyWith(color: kGreenColor):
                                      Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.orangeAccent),

                                    ),
                                    Text(paymentData.channel,
                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kNavyColor,fontWeight: FontWeight.bold),

                                    ),
                                  ],
                                ),

                                Text('${paymentData.amount.toString()} ${paymentData.currency.toString()}',
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kBlackColor),

                                ),

                              ],
                            ),
                            Divider(),

                            Text(paymentData.createdAt,
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kAshColor,fontWeight: FontWeight.bold),

                            ),

                            Text(paymentData.gatewayResponse,
                              style: paymentData.gatewayResponse.toString().toLowerCase() == "approved"?
                              Theme.of(context).textTheme.bodyText1!.copyWith(color: kGreenColor):
                              Theme.of(context).textTheme.bodyText1!.copyWith(color: kRedColor),

                            ),

                          ],
                        ),
                      ),

                  ),
                ),
                )
                    .toList(),
              )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    NewUser user = Provider.of<UserProvider>(context).user;
    fullName = user.fullName.toString();
    return SafeArea(child:Scaffold(
        appBar: BulkSmsAppbarSecond(title: "Transactions",color: kBlackColor,
        deleteButton:  SmsButtonsNew(
          tapSmsButton: (){transferFundsRoute(context);},
          title: AppLocalizations.of(context)!.transferText,
          color: kGreenColor,
        ),
        ),

        body:CustomScrollView(slivers: <Widget>[
        SliverAppBar(
            forceElevated: true,
            shape:  RoundedRectangleBorder(
                borderRadius:  BorderRadius.only(bottomRight: Radius.circular(10.0),bottomLeft: Radius.circular(10.0),
                )
            ),
            backgroundColor: kAshColor,
            pinned: false,
            automaticallyImplyLeading: false,
            floating: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: (){},
                style: ButtonStyle(

                  backgroundColor: MaterialStateProperty.all<Color>(kOrangeColor),

                ),
                child: RichText(
                  text: TextSpan(
                      text: ('Balance: '),
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kLightBlue,fontWeight: FontWeight.normal),

                      children: <TextSpan>[
                        TextSpan(
                          text: user.wallet.toString(),
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kWhiteColor,fontWeight: FontWeight.bold),

                        )
                      ]),
                ),


            ),


                SmsButtonsNew(
                  tapSmsButton: (){cardDepositScreen(context);},
                  title: AppLocalizations.of(context)!.fundWallet,
                  color: kNavyColor,
                ),
              ],
            )
        ),

          SliverList(delegate: SliverChildListDelegate([
            _transactionsList()

          ]))
    ]
        )
    ));
  }

}
