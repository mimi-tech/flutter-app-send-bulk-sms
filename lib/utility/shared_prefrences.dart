
import 'package:bulk_sms/models/card_details.dart';
import 'package:bulk_sms/models/new_user.dart';
import 'package:bulk_sms/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {


  Future<bool> saveUser(NewUser user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('userId',user.userId ?? "");
    prefs.setString('name',user.fullName ?? "");
    prefs.setString('email',user.email ?? "");
    prefs.setString('phone',user.phoneNumber ?? "");
    prefs.setInt('messageCount',user.messageCount ?? 0);
    prefs.setInt('recievers',user.recievers ?? 0);
    prefs.setBool('blocked',user.blocked ?? false);
    prefs.setInt('wallet',user.wallet ?? 0);

    return prefs.commit();

  }

  //Save users card details
  Future<bool> cardDetails(CardDetailsModal cardDetailsModal) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('cardFirstFourDigit',cardDetailsModal.cardFirstFourDigit ?? '');
    prefs.setString('cardLastFourDigit',cardDetailsModal.cardFirstFourDigit ?? '');
    prefs.setString('authorizationCode',cardDetailsModal.authorizationCode ?? '');
    prefs.setString('cardType',cardDetailsModal.cardType ?? '');
    prefs.setString('cardBrand',cardDetailsModal.cardBrand ?? '');
    prefs.setString('cardBank',cardDetailsModal.cardBank ?? '');
    prefs.setString('expiringMonth',cardDetailsModal.expiringMonth ?? '');
    prefs.setString('expiringYear',cardDetailsModal.expiringYear ?? '');

    return prefs.commit();

  }



  //fetching the users card details
  Future<CardDetailsModal> getCardDetailsNew ()  async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String cardFirstFourDigit = prefs.getString("cardFirstFourDigit") ?? "";
    String cardLastFourDigit = prefs.getString("cardLastFourDigit") ?? "";
    String authorizationCode = prefs.getString("authorizationCode") ?? "";
    String cardType = prefs.getString("cardType") ?? "";
    String cardBrand = prefs.getString("cardBrand") ?? '';
    String cardBank = prefs.getString("cardBank") ?? '';
    String expiringMonth = prefs.getString("expiringMonth") ?? '';
    String expiringYear = prefs.getString("expiringYear") ?? '';
    return CardDetailsModal(
        cardFirstFourDigit: cardFirstFourDigit,
        cardLastFourDigit: cardLastFourDigit,
        authorizationCode: authorizationCode,
        cardType: cardType,
        cardBrand: cardBrand,
        cardBank:cardBank,
        expiringMonth:expiringMonth,
        expiringYear:expiringYear
    );

  }

  Future<NewUser> getUser ()  async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String userId = prefs.getString("userId") ?? "";
    String fullName = prefs.getString("fullName") ?? "";
    String email = prefs.getString("email") ?? "";
    String phoneNumber = prefs.getString("phoneNumber") ?? "";
    int messageCount = prefs.getInt("messageCount") ?? 0;
    int recievers = prefs.getInt("recievers") ?? 0;
    bool blocked = prefs.getBool("blocked") ?? false;
    int wallet = prefs.getInt("wallet") ?? 0;

    return NewUser(
        userId: userId,
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        messageCount: messageCount,
        recievers:recievers,
        blocked:blocked,
        wallet:wallet
    );

  }



  void saveToken(String token)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token',token);
  }

  void saveCustomerId(int customerId)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('customerId',customerId);
  }

  void saveCustomerCode(String customerCode)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('customerCode',customerCode);
  }

  void saveAuthId(String userId)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId',userId);
  }

  void removeUser() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('userId');
    prefs.remove('name');
    prefs.remove('email');
    prefs.remove('phone');
    prefs.remove('type');
    prefs.remove('messageCount');
    prefs.remove('recievers');
    prefs.remove('blocked');
    prefs.remove('wallet');
    prefs.remove('token');
    prefs.remove('cardFirstFourDigit');
    prefs.remove('cardLastFourDigit');
    prefs.remove('authorizationCode');
    prefs.remove('cardType');
    prefs.remove('cardBrand');
    prefs.remove('cardBank');
    prefs.remove('expiringMonth');
    prefs.remove('expiringYear');
    prefs.remove('customerCode');


  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    return token;
  }
  Future<int> getCustomerId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int customerId = prefs.getInt("customerId") ?? 0;
    return customerId;
  }
  Future<String> getCustomerCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String customerCode = prefs.getString("customerCode") ?? "";
    return customerCode;
  }

  Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("userId") ?? "";
    return userId;
  }

}