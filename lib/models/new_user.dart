class NewUser {
  String? userId;
  String? fullName;
  String? email;
  String? phoneNumber;
  int? messageCount;
  int? recievers;
  bool? blocked;
  dynamic wallet;

  NewUser({
     this.userId,
     this.fullName,
     this.email,
     this.phoneNumber,
     this.messageCount,
     this.recievers,
     this.blocked,
     this.wallet,


  });

  // now create converter

  factory NewUser.fromJson(Map<String,dynamic> responseData){
    return NewUser(
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
  Map<String, dynamic> toJson() {
    return {
      "userId": this.userId,
      "fullName": this.fullName,
      "email": this.email,
      "phoneNumber": this.phoneNumber,
      "messageCount": this.messageCount,
      "recievers": this.recievers,
      "blocked": this.blocked,
      "wallet": this.wallet,
    };
  }
}