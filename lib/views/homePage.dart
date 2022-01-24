import 'package:bulk_sms/components/animation_slide.dart';
import 'package:bulk_sms/components/fade_animation.dart';
import 'package:bulk_sms/components/sms_buttons.dart';
import 'package:bulk_sms/services/logout.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/dimen.dart';
import 'package:bulk_sms/utility/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Container(
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
          Container(

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                  border: Border.all(color: kWhiteColor,width: 1.0)
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: GestureDetector(
                    onTap: (){bottomBar(context);},
                    child: Icon(Icons.email,color: kWhiteColor,size: 50,)),
              )),

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               SmsButtons(
                   title: AppLocalizations.of(context)!.loginText,
                   color: kNavyColor,
                   tapSmsButton: (){loginScreen(context);}
               ),

                SmsButtons(
                    title: AppLocalizations.of(context)!.signupText,
                    color: kOrangeColor,
                    tapSmsButton: (){signupRoutes(context);}
                )
              ],
            )
          ],
        ),
      ),
    )))
    ;
  }
}
