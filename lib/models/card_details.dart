class CardDetailsModal {
  String? cardFirstFourDigit;
  String? cardLastFourDigit;
  String? authorizationCode;
  String? cardType;
  String? cardBrand;
  String? cardBank;
  String? expiringMonth;
  String? expiringYear;

  CardDetailsModal({
    this.cardFirstFourDigit,
    this.cardLastFourDigit,
    this.authorizationCode,
    this.cardType,
    this.cardBrand,
    this.cardBank,
    this.expiringMonth,
    this.expiringYear,
  });

  // now create converter

  factory CardDetailsModal.fromJson(Map<String,dynamic> responseData){
    return CardDetailsModal(
      cardFirstFourDigit: responseData['bin'],
      cardLastFourDigit: responseData['last4'],
      authorizationCode : responseData['authorization_code'],
      cardType: responseData['card_type'],
      cardBrand: responseData['brand'],
      cardBank: responseData['bank'],
      expiringMonth: responseData['exp_month'],
      expiringYear: responseData['exp_year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cardFirstFourDigit": this.cardFirstFourDigit,
      "cardLastFourDigit": this.cardLastFourDigit,
      "authorizationCode": this.authorizationCode,
      "cardType": this.cardType,
      "cardBrand": this.cardBrand,
      "cardBank": this.cardBank,
      "expiringMonth": this.expiringMonth,
      "expiringYear": this.expiringYear,
    };
  }
}

class CardVerificationModal {
  String? brand;
  String? bank;


  CardVerificationModal({
    this.brand,
    this.bank,

  });

  // now create converter

  factory CardVerificationModal.fromJson(Map<String,dynamic> responseData){
    return CardVerificationModal(
      brand: responseData['brand'],
      bank: responseData['bank'],

    );
  }
}


class GetBanksResponse {
  String? bankName;
  String? bankCode;
  bool? internetbanking;

  GetBanksResponse({ this.bankName,  this.bankCode});

  GetBanksResponse.fromJson(Map<String, dynamic> json) {
    bankName = json['bankname'];
    bankCode = json['bankcode'];
    internetbanking = json['internetbanking'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankname'] = this.bankName;
    data['bankcode'] = this.bankCode;
    data['internetbanking'] = this.internetbanking;

    return data;
  }
}