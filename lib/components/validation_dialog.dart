import 'dart:io';

import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/components/sms_buttons.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:bulk_sms/utility/dimen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class ValidationDialog{
  static BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: kTextFieldBorderColor),
      borderRadius: BorderRadius.circular(15.0),
    );
  }
static validateMe({
  required title,
  required context,
  required subtitle,
  required data,
  required subtitle2,
  required onPressedDone
}) {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();



  showDialog(
      context: context,
      builder: (context) =>
      Platform.isIOS
          ? CupertinoAlertDialog(
        title:Text(title, style: Theme.of(context).textTheme.caption
        ),
        content: Column(children: <Widget>[



          Container(
            margin: EdgeInsets.symmetric(horizontal: kMargin),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: subtitle,
                  style: Theme.of(context).textTheme.bodyText1,

                  children: <TextSpan>[
                    TextSpan(text: data,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),

                    //
                    // TextSpan(text: subtitle2,
                    //   style: Theme.of(context).textTheme.bodyText1,
                    // ),


                  ]),
            ),
          ),

          //animatingBorders(),
    PinPut(

      autofocus: true,
      //validator: validatePin,
      fieldsCount: 6,
      eachFieldHeight: 20,
      onChanged: (String code) {
        phoneCode = code;},

      focusNode: _pinPutFocusNode,
      controller: _pinPutController,
      submittedFieldDecoration: _pinPutDecoration.copyWith(borderRadius: BorderRadius.circular(20)),
      pinAnimationType: PinAnimationType.slide,

      selectedFieldDecoration: _pinPutDecoration,
      followingFieldDecoration: _pinPutDecoration.copyWith(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: kTextFieldBorderColor,),
      ),
    ),
          SizedBox(height: 10,),

        ]),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(AppLocalizations.of(context)!.cancel,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),


          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(AppLocalizations.of(context)!.done,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      )
          : SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
        title: Center(
          child:Text(title, style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold)

        ),),
        children: <Widget>[


          Container(
            margin: EdgeInsets.symmetric(horizontal: kMargin),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: subtitle,
                  style: Theme.of(context).textTheme.bodyText1,

                  children: <TextSpan>[
                    TextSpan(text: data,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),




                  ]),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(18.0),
            child: PinPut(

              autofocus: true,
              //validator: validatePin,
              fieldsCount: 6,
              eachFieldHeight: 5,
              eachFieldWidth: 5,
              onChanged: (String code) {
                print(_pinPutController.text);
                phoneCode = code;},
              fieldsAlignment: MainAxisAlignment.spaceBetween,
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: _pinPutDecoration.copyWith(borderRadius: BorderRadius.circular(20)),
              pinAnimationType: PinAnimationType.slide,
              selectedFieldDecoration: _pinPutDecoration,
              followingFieldDecoration: _pinPutDecoration.copyWith(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                  color: Colors.deepPurpleAccent.withOpacity(.5),
                ),

              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: kMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmsButtons(title:AppLocalizations.of(context)!.cancel ,
                    color: kRedColor,
                    tapSmsButton: (){Navigator.pop(context);}

                ),

                SmsButtons(title:AppLocalizations.of(context)!.done ,
                    color: kNavyColor,
                    tapSmsButton: onPressedDone

                )
              ],
            ),
          )

        ],
      ));
}}