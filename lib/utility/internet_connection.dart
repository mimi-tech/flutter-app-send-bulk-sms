import 'dart:async';
import 'dart:io';

import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/dimen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnections{
  StreamSubscription? _connectionChangeStream;
  bool isOffline = false;
  bool firstEntering = false;

  void checkConnection(BuildContext context){

    _connectionChangeStream = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      if(result != ConnectivityResult.none){
        isOffline = await InternetConnectionChecker().hasConnection;
       if(firstEntering == true) {
         Navigator.pop(context);
       }
      }else{
        //there is no internet show dialog to the user
        firstEntering = true;
        showDialog(
            barrierDismissible: false,
            context: context,
            builder:(context) => Platform.isIOS ?
        CupertinoAlertDialog(
          content:  Container(
            margin: EdgeInsets.symmetric(horizontal: kMargin),
            child:Text('Opps! You have no internet connection',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(color: kOrangeColor),
            )

          ),


        )
            : SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 4,

          children: <Widget>[

            Container(
              margin: EdgeInsets.symmetric(horizontal: kMargin),
              child: Text('Opps! You have no internet connection',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(color: kOrangeColor),
              )


            ),


          ],
        ));
      }
    });
  }

  void dispose() {
    _connectionChangeStream!.cancel();
  }
}

