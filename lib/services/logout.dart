import 'package:bulk_sms/utility/routes.dart';
import 'package:bulk_sms/utility/shared_prefrences.dart';

class LogOutUser{
   logoutUser(context) {
    UserPreferences().removeUser();
    homeScreenPage(context);
  }
}