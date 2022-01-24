import 'dart:async';
import 'package:bulk_sms/models/new_user.dart';
import 'package:bulk_sms/models/user.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/routes.dart';
import 'package:bulk_sms/utility/shared_prefrences.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  var _visible = true;

  AnimationController? animationController;
  Animation<double>? animation;

  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    String token = await UserPreferences().getToken();

    // Navigator.of(context).push(
    //     MaterialPageRoute(builder: (context) => HomePageScreen()));
    if (token == null || token == "") {

      homeScreenPage(context);
    } else {
      //UserPreferences().removeUser();
      //UsersViewModal().getUser();
      bottomBar(context);
    }
  }
  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        vsync:this,
        value: 0.1,

        duration: new Duration(seconds: 4));
    animation =
    new CurvedAnimation(parent: animationController!, curve: Curves.easeOut);

    animation!.addListener(() => this.setState(() {}));
    animationController!.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController!.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body:  Container(
      decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/splash_bg.png'),
    fit: BoxFit.cover,)),

    child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Bulk sms'.toUpperCase(),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kWhiteColor,fontWeight: FontWeight.bold)
            ),

          ],),
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.email,size: animation!.value * 250,color: kWhiteColor,)
          ],
        ),
      ],
    )

      ),
    ));
  }
}
