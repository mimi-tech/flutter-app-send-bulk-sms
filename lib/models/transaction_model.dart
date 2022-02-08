

class TransactionModel {
  dynamic amount;
  dynamic status;
  dynamic gatewayResponse;
  dynamic channel;
  dynamic createdAt;
  dynamic currency;

  TransactionModel({
    this.amount,
    this.status,
    this.gatewayResponse,
    this.channel,
    this.createdAt,
    this.currency,
  });



  // now create converter

  TransactionModel.fromJson(Map<String,dynamic> responseData){

      amount = responseData['amount'];
      status = responseData['status'];
      gatewayResponse = responseData['gateway_response'];
      channel = responseData['channel'];
      createdAt = responseData['createdAt'];
      currency = responseData['currency'];


  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['gateway_response'] = this.gatewayResponse;
    data['channel'] = this.channel;
    data['createdAt'] = this.createdAt;
    data['currency'] = this.currency;

    return data;
  }
}