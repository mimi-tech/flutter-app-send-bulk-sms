import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/components/progressIndicator.dart';
import 'package:bulk_sms/components/sms_buttons.dart';
import 'package:bulk_sms/models/new_user.dart';
import 'package:bulk_sms/utility/Validators.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/dimen.dart';
import 'package:bulk_sms/view_model/users_Auth_provider.dart';
import 'package:bulk_sms/view_model/users_contact.dart';
import 'package:bulk_sms/views/Funds/card.dart';
import 'package:bulk_sms/views/createMessage/show_new_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SmsPreview extends StatefulWidget {
  const SmsPreview({Key? key}) : super(key: key);

  @override
  _SmsPreviewState createState() => _SmsPreviewState();
}

class _SmsPreviewState extends State<SmsPreview> {


  @override
  Widget build(BuildContext context) {

    NewUser user = Provider.of<UserProvider>(context).user;

    ContactServicesViewModal usersContact = Provider.of<ContactServicesViewModal>(context);
//gather all contact

    // usersContact.allContact.clear();
    // for(int i = 0; i <usersContact.selectedContactGroup!.values.toList().length; i++){
    //   allList.addAll(usersContact.selectedContactGroup!.values.toList()[i]);
    // }

    //usersContact.allContact.addAll(allList.toSet());
    //print(usersContact.allContact.toSet());
    var smsCost = usersContact.allContact.toSet().length * double.parse("${dotenv.env['SMS_AMOUNT']}");
   var newBalance = user.wallet - smsCost;
    return AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 600),
        curve: Curves.decelerate,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: kMargin),
          height: MediaQuery.of(context).size.height * 0.4,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spacing(context),
                Center(
                  child: Text("Delight Sms preview".toUpperCase(),
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(color: kAshColor),

                  ),
                ),
                spacing(context),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: 'Hi ',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kTextColor,fontWeight: FontWeight.w500),

                      children: <TextSpan>[
                  TextSpan(
                  text: '${user.fullName} ',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kNavyColor,fontWeight: FontWeight.bold),
                  ),

                      TextSpan(text: "You are about to send an sms to ${usersContact.allContact.length} contacts",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kTextColor,fontWeight: FontWeight.normal)
                        ),
                      ]

                  ),
                ),

                spacing(context),
                RichText(
                  text: TextSpan(
                      text: 'per sms cost: ',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kAshColor,fontWeight: FontWeight.w500),

                      children: <TextSpan>[
                        TextSpan(text: "${dotenv.env["SMS_AMOUNT"]}",
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kLightBlue,fontWeight: FontWeight.normal)
                        ),
                      ]),
                ),

                RichText(
                  text: TextSpan(
                      text: 'Total cost: ',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kAshColor,fontWeight: FontWeight.w500),

                      children: <TextSpan>[
                        TextSpan(text: smsCost.toString(),
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kLightBlue,fontWeight: FontWeight.normal)
                        ),
                      ]),
                ),

                RichText(
                  text: TextSpan(
                      text: 'New balance: ',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kAshColor,fontWeight: FontWeight.w500),

                      children: <TextSpan>[
                        TextSpan(text: newBalance.toString(),
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kLightBlue,fontWeight: FontWeight.normal)
                        ),
                      ]),
                ),

                spacing(context),

                Center(
                  child: Text(usersContact.smsSentAllContactText,
                      style:Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold,color: kGreenColor)
                  ),
                ),
                Center(
                  child: Text(usersContact.smsSentText,
                      style:usersContact.smsSentText == "Message sent successfully"?

                      Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold,color: kGreenColor)
                          : Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold,color: kRedColor)

                  ),
                ),
                spacing(context),
                usersContact.loading?ShowProgress(): Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SmsButtonsNew(title: "Cancel".toUpperCase(), color: kRedColor, tapSmsButton: (){Navigator.pop(context);}),

                    SmsButtonsNew(title: "Continue".toUpperCase(), color: kLightBlue, tapSmsButton: () async {
                     if(usersContact.allContact.toSet().length != 0) {
                      //check if user has enough money

                      if(smsCost <= user.wallet){
                        notifyFlutterToastSuccess(title: "Sending...");

                      await usersContact.getSendBulkSms(context: context,email: user.email,fullName: user.fullName);

                      }else{
                        notifyFlutterToastError(title: "Insufficient fund, Please fund your wallet and continue");
                        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: CardDeposit()));

                      }
                    }else{
                       notifyFlutterToastError(title: "Please select or add new contacts");

                     }
                    }),
                  ],
                ),
                spacing(context),

              ],
            ),
          ),
        ));
  }
}
