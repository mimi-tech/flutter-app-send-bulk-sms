import 'package:bulk_sms/components/bottomNavigationBar.dart';
import 'package:bulk_sms/views/Funds/bank_account.dart';
import 'package:bulk_sms/views/Funds/card.dart';
import 'package:bulk_sms/views/Funds/transfer_funds.dart';
import 'package:bulk_sms/views/LandingPage.dart';
import 'package:bulk_sms/views/Registration/email_screen.dart';
import 'package:bulk_sms/views/Registration/password_screen.dart';
import 'package:bulk_sms/views/Registration/phone_number_screen.dart';
import 'package:bulk_sms/views/Registration/signup_screen.dart';
import 'package:bulk_sms/views/contacts.dart';
import 'package:bulk_sms/views/createMessage/create_message.dart';
import 'package:bulk_sms/views/createMessage/message_tab_view.dart';
import 'package:bulk_sms/views/createMessage/view_contact_group.dart';
import 'package:bulk_sms/views/forgotPassword/change_password.dart';
import 'package:bulk_sms/views/forgotPassword/verify_email.dart';
import 'package:bulk_sms/views/homePage.dart';
import 'package:bulk_sms/views/login.dart';
import 'package:bulk_sms/views/text2.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void signupRoutes(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: SignUpScreen()));

}

void phoneNumberScreenRoutes(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PhoneNumberScreen()));

}

void emailScreen(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: EmailScreen()));

}

void passwordScreen(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PasswordScreen()));

}

void loginScreen(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: LoginScreen()));

}

void landingPage(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: LandingPage()));

}
void bottomBar(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: BasicBottomNavBar()));

}

void verifyEmailForgotPassword(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: VerifyEmailScreen()));

}
void changePasswordScreen(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: ChangePassword()));

}

void cardDepositScreen(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: CardDeposit()));

}

void bankAccountDepositScreen(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: TextPayment()));

}
void createMessageScreen(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: CreateMessage()));

}

void messageTabViewScreen(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: MessageTabView()));

}
void homeScreenPage(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: HomePageScreen()));

}

void transferFundsRoute(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: TransferFunds()));

}

void contactScreenRoute(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: ContactScreen()));

}

void contactGroupScreenRoute(BuildContext context){
  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: ViewGroupContactScreen()));

}

