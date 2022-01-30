
import 'package:bulk_sms/themes/light_themes.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/internet_connection.dart';
import 'package:bulk_sms/view_model/account_provider.dart';
import 'package:bulk_sms/view_model/users_Auth_provider.dart';
import 'package:bulk_sms/view_model/users_contact.dart';


import 'package:bulk_sms/views/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load();
  PaystackPlugin().initialize(publicKey: "${dotenv.env["PAYSTACK_PUBLIC_KEY"]}");

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor:kBlackColor));

  runApp(MyApp());


}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


/* Sets the statusBar colour of the app */
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: kBlackColor,
      ),
    );
    return ScreenUtilInit(
        designSize: const Size(360, 740),
    builder: () => MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ContactServicesViewModal()),

      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
        title: 'Bulk sms',
        theme: CustomTheme.lightTheme(),
          onGenerateTitle: (context) {
            return AppLocalizations.of(context)!.helloWorld;
          },
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          //supportedLocales: ['en','fr'],
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
          }

        ),

      ),
    );

  }
}
