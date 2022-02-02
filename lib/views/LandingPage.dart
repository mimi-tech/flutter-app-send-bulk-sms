import 'package:bulk_sms/components/animation_slide.dart';

import 'package:bulk_sms/components/fade_animation.dart';

import 'package:bulk_sms/models/new_user.dart';

import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/dimen.dart';
import 'package:bulk_sms/utility/routes.dart';
import 'package:bulk_sms/utility/shared_prefrences.dart';

import 'package:bulk_sms/view_model/account_provider.dart';
import 'package:bulk_sms/view_model/users_Auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  AuthProvider? notifier;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AuthProvider().getLoggedInUserDetails(context);
  }


  @override
  Widget build(BuildContext context) {
NewUser user = Provider.of<UserProvider>(context).user;
print(user.userId);
    return SafeArea(child: Scaffold(

        floatingActionButton: FloatingActionButton(
          backgroundColor: kOrangeColor,
          shape: CircleBorder(),
          child: Icon(Icons.add,size: 30,color: kWhiteColor,),

          onPressed: () {  messageTabViewScreen(context);},
        ),
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,)),

      child: Container(
        margin: EdgeInsets.symmetric(horizontal: kMargin,vertical: kMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
   Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          user.fullName == null ? Container() : Container(

              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: kWhiteColor, width: 1.0)
              ),
              child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(user.fullName!.substring(0, 1).toString(),
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: kWhiteColor),

                  )
              )),

          user.fullName == null ?
          Center(
            child: Text(AppLocalizations.of(context)!.loading,
              style: Theme
                  .of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Colors.cyan, fontSize: kFontSize14),

            ),
          )
              : Center(
            child: Text(user.fullName.toString(),
              style: Theme
                  .of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.cyan, fontSize: kFontSize14),

            ),
          ),


        ],
      ),




            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimationSlide(
                  title:Text(AppLocalizations.of(context)!.welcomeTitle,
                    style: Theme.of(context).textTheme.headline1!.copyWith(color: kWhiteColor),
                  ),
                ),

                FadeAnimation(
                  title: Text(AppLocalizations.of(context)!.welcomeDesc,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(color: kWhiteColor),
                  ),
                )


              ],
            ),

          ],
        )
      ),
    )))
    ;
  }


}
