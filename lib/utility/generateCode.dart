import 'dart:math';
import 'package:bulk_sms/components/constants.dart';

class GenerateCode{
   static generateCode(){
     Random random = new Random();
     var randomNumber = random.nextInt(900000) + 100000;

     //var randomNumber = random.nextInt(1000000);
      codeSent = randomNumber;
     print(codeSent);
   }


}