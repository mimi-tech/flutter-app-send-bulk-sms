import 'package:bulk_sms/components/appbar.dart';
import 'package:bulk_sms/components/appbar2.dart';
import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/components/modalProgressFunction.dart';
import 'package:bulk_sms/components/sms_buttons.dart';

import 'package:bulk_sms/models/new_user.dart';
import 'package:bulk_sms/services/logout.dart';
import 'package:bulk_sms/utility/Validators.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/dimen.dart';
import 'package:bulk_sms/utility/routes.dart';
import 'package:bulk_sms/view_model/profile_view_modal.dart';
import 'package:bulk_sms/view_model/users_Auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({Key? key}) : super(key: key);

  @override
  _ViewProfileScreenState createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _email = TextEditingController();

  TextEditingController _fName = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   var height = 5.0;
   var width = 5.0;
   Color color = Colors.lightBlueAccent;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    NewUser user = Provider.of<UserProvider>(context).user;
    _phoneNumber.text = "${user.phoneNumber}";
    _email.text = "${user.email}";
    _fName.text = "${user.fullName}";
    return SafeArea(child:

    ChangeNotifierProvider<ProfileViewModal>(
        create: (context)=> ProfileViewModal(),
    builder: (context,child){

    return Consumer<ProfileViewModal>(
    builder: (context, modal, child){


    return Scaffold(
        appBar: BulkSmsAppbarSecond(
            color:kBlackColor,
            title: '${user.fullName}',
            deleteButton: SmsButtonsNew(
            tapSmsButton: () {
            LogOutUser().logoutUser(context);
            homeScreenPage(context);
              },
      title: 'Logout',
      color: kNavyColor,
    ),
        ),
        body: ProgressHUDFunction(
          inAsyncCall: modal.loading,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: kMargin),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spacing(context),

              Center(
                child: Text('User Information'.toUpperCase(),
                    style: Theme.of(context).textTheme.headline2!.copyWith(color: kOrangeColor)
                ),
              ),
              spacing(context),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'Wallet Balance:  ',
                  style: Theme.of(context).textTheme.caption!.copyWith(color: kAshColor),

                  children: <TextSpan>[
                    TextSpan(text: user.wallet.toString(),
                      style: Theme.of(context).textTheme.caption!.copyWith(color: kLightBlue)
                    ),
                  ]),
            ),

              spacing(context),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Message Count:  ',
                    style: Theme.of(context).textTheme.caption!.copyWith(color: kAshColor),

                    children: <TextSpan>[
                      TextSpan(text: user.messageCount.toString(),
                        style: Theme.of(context).textTheme.caption!.copyWith(color: kLightBlue),
                      ),
                    ]),
              ),
              spacing(context),
              spacing(context),
              Divider(),
              Center(
                child: Text('Edit profile'.toUpperCase(),
                    style: Theme.of(context).textTheme.headline2!.copyWith(color: kOrangeColor)
                ),
              ),

              spacing(context),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.fullName,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kNavyColor)
                    ),
                    TextFormField(

                      controller: _fName,
                      autocorrect: true,
                      cursorColor: (kOrangeColor),
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      style: Theme.of(context).textTheme.bodyText1,
                      validator: Validator.validateFullName,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(child: SvgPicture.asset('assets/edit.svg',height: 5.0,width: 5.0,color: color),
                          onTap: () async {
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            await modal.getUpdateFullName(context);
                          },
                        ),

                        hintText: AppLocalizations.of(context)!.fullName,
                        hintStyle: Theme.of(context).inputDecorationTheme.helperStyle,
                        errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
                        border: Theme.of(context).inputDecorationTheme.border,
                        enabledBorder:Theme.of(context).inputDecorationTheme.enabledBorder,
                        focusedBorder:Theme.of(context).inputDecorationTheme.focusedBorder,
                        focusedErrorBorder:Theme.of(context).inputDecorationTheme.focusedErrorBorder,
                        errorBorder:Theme.of(context).inputDecorationTheme.errorBorder,
                        contentPadding: Theme.of(context).inputDecorationTheme.contentPadding,
                      ),
                      onChanged: (String? value) {
                        fullName = value;
                      },
                    ),

                    spacing(context),
                    Text(AppLocalizations.of(context)!.phoneNumber,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kNavyColor)
                    ),
                    TextFormField(
                      controller: _phoneNumber,
                      autocorrect: true,
                      cursorColor: (kOrangeColor),
                      keyboardType: TextInputType.number,
                      textCapitalization: TextCapitalization.sentences,
                      style: Theme.of(context).textTheme.bodyText1,
                      validator: Validator.validatePhoneNumber,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(child: SvgPicture.asset('assets/edit.svg',height: height,width: width,color: color),
                        onTap: () async {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          if(user.phoneNumber != _phoneNumber.text){
                            //verify phone number
                            await modal.getUpdatePhoneNumber(context);
                          }else{
                            notifyFlutterToastError(title: "You did not change your phone number");
                          }
                      },
                        ),


                        hintText: AppLocalizations.of(context)!.phoneNumber,
                        hintStyle: Theme.of(context).inputDecorationTheme.helperStyle,
                        errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
                        border: Theme.of(context).inputDecorationTheme.border,
                        enabledBorder:Theme.of(context).inputDecorationTheme.enabledBorder,
                        focusedBorder:Theme.of(context).inputDecorationTheme.focusedBorder,
                        focusedErrorBorder:Theme.of(context).inputDecorationTheme.focusedErrorBorder,
                        errorBorder:Theme.of(context).inputDecorationTheme.errorBorder,
                        contentPadding: Theme.of(context).inputDecorationTheme.contentPadding,
                      ),
                      onChanged: (String? value) {
                        phoneNumber = value;
                      },
                    ),
                    Center(
                      child: Text(
                          AppLocalizations.of(context)!.phoneText,
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(color: kAshColor)
                      ),
                    ),
                    spacing(context),
                    Text("Email Address",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kNavyColor)
                    ),
                    TextFormField(
                      controller: _email,
                      autocorrect: true,
                      cursorColor: (kOrangeColor),
                      keyboardType: TextInputType.emailAddress,
                      style: Theme.of(context).textTheme.bodyText1,
                      validator: Validator.validateEmail,

                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(child: SvgPicture.asset('assets/edit.svg',height: height,width: width,color: color,),
                        onTap: () async {
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          if(user.email != _email.text){
                            //verify phone number
                            await modal.getUpdateEmailAddress(context);
                          }else{
                            notifyFlutterToastError(title: "You did not change your email address");
                          }
                        },
                        ),


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
                      onChanged: (String? value) {
                        emailAddress = value;
                      },
                    ),
                    Center(
                      child: Text(
                          AppLocalizations.of(context)!.emailSubtitle,
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(color: kAshColor)
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
    ),
        )
    );
    });





}));
  }}
