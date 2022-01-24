import 'dart:io';

import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/models/card_details.dart';
import 'package:bulk_sms/repos/api_status.dart';
import 'package:bulk_sms/services/funding_services.dart';
import 'package:flutter/foundation.dart';

class FundWalletService2 extends ChangeNotifier{
  String _bank = '';
  String _brand = '';
  String _bankName = '';
  bool _loading = false;
  CardDetailsModal _cardDetailsModal = new CardDetailsModal();
  List<String> _bankList = [];

  String get bank => _bank;
  String get brand => _brand;
  String get bankName => _bankName;
  bool get loading => _loading;
  CardDetailsModal get cardDetailsModal => _cardDetailsModal;
  List<String> get bankList => _bankList;

  setBank(String bank) async {
    _bank = bank;
    notifyListeners();
  }

  setBankName(String bankName) async {
    _bankName = bankName;
    notifyListeners();
  }
  setBrand(String brand) async {
    _brand = brand;
    notifyListeners();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setBankList(List<String> bankList) {
    _bankList = bankList;
  }

  setCardDetailsModal(CardDetailsModal _cardDetailsModal) {
    _cardDetailsModal = cardDetailsModal;
    //notifyListeners();
  }


  getVerifyCardBin(context) async{
    var response = await FServices.verifyCardBin(context);
    if( response.isNotEmpty ){
      var cardData = response['data'];
      setBank(cardData['bank']);
      setBrand(cardData['brand']);

    }else{
      print("endpoint failed");
    }

  }

  getVerifyCardBin_2(context,String phoneNumber,String email, String fullName) async{
    setLoading(true);
    var response = await FServices.verifyCardBin(context);
    if( response.isNotEmpty ){
      var cardData = response['data'];
      setBank(cardData['bank']);
      setBrand(cardData['brand']);
      //create customer
       await FServices.createCustomer(context, phoneNumber, email, fullName);
    }else{
      print("endpoint failed");
    }

  }


  fundingUserWallet(reference,context) async {
    setLoading(true);
    var response = await FServices.verifySuccessTxn(reference,context);
    if(response.isNotEmpty){
      //update the users wallet
      var updateResponse = await FServices.updateWallet(context);
      if( updateResponse is Success ){
        notifyFlutterToastSuccess(title: "Wallet funded successfully");
        setLoading(false);
      }else{
        setLoading(false);
        notifyFlutterToastSuccess(title: "Error funding wallet");
      }
    }else{
      setLoading(false);
      notifyFlutterToastSuccess(title: "Error funding wallet");
    }


  }


  chargeAuthorization(context, email) async {
    setLoading(true);
    var response = await FServices.chargeAuthorization(context,email);
    if(response.isNotEmpty){
      //verify transaction
      var verifyTxnResponse = await FServices.verifySuccessTxn(response['data']['reference'],context);
      if(verifyTxnResponse.isNotEmpty){
        //update the users wallet
        var updateResponse = await FServices.updateWallet(context);
        if( updateResponse is Success ){
          notifyFlutterToastSuccess(title: "Wallet funded successfully");
          setLoading(false);
      }else{
          setLoading(false);
          notifyFlutterToastSuccess(title: "Error updating wallet");
        }

      }else{
        setLoading(false);
        notifyFlutterToastSuccess(title: "Error verifying transaction");
      }
    }else{
      setLoading(false);
      notifyFlutterToastSuccess(title: "Error funding wallet");
    }


  }


  getTransferFunds(context) async{

    setLoading(true);
    var response = await FServices.transferFunds(context);
    if( response is Success ){
      setLoading(false);
      notifyFlutterToastSuccess(title: "Transfer successful");

    }
    if(response is Failure) {
      setLoading(false);
      notifyFlutterToastError(title: "${response.errorResponse}");

    }

    }




}



