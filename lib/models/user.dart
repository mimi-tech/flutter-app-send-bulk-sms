class User {
  String userId;
  String fullName;
  String email;
  String phoneNumber;
  int messageCount;
  int recievers;
  bool blocked;
  int wallet;

  User({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.messageCount,
    required this.recievers,
    required this.blocked,
    required this.wallet,


  });

  // now create converter

  factory User.fromJson(Map<String,dynamic> responseData){
    return User(
      userId: responseData['id'],
      fullName: responseData['fullName'],
      email : responseData['email'],
      phoneNumber: responseData['phoneNumber'],
      messageCount: responseData['messageCount'],
      recievers: responseData['recievers'],
      blocked: responseData['blocked'],
      wallet: responseData['wallet'],
    );
  }
}