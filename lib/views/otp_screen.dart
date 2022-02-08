import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/components/sms_buttons.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:flutter/material.dart';

class RequestForOTP extends StatefulWidget {
  RequestForOTP({required this.next});
  final VoidCallback next;
  @override
  _RequestForOTPState createState() => _RequestForOTPState();
}

class _RequestForOTPState extends State<RequestForOTP> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 600),
        curve: Curves.decelerate,
        child: Column(

          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child:Text('Please enter the OTP sent \nto your mobile or email',
                style: Theme.of(context).textTheme.caption!.copyWith(color: kNavyColor),

              ),
            ),


            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: this._formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [


                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      cursorColor: kOrangeColor,
                      controller: _otpController,
                      decoration: InputDecoration(
                        hintText: 'Otp',
                        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                        errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
                        border: Theme.of(context).inputDecorationTheme.border,
                        enabledBorder:Theme.of(context).inputDecorationTheme.enabledBorder,
                        focusedBorder:Theme.of(context).inputDecorationTheme.focusedBorder,
                        focusedErrorBorder:Theme.of(context).inputDecorationTheme.focusedErrorBorder,
                        errorBorder:Theme.of(context).inputDecorationTheme.errorBorder,
                        contentPadding: Theme.of(context).inputDecorationTheme.contentPadding,
                      ),
                      validator: this._pinValidator,
                      onChanged: (String value){
                        otpText = value;
                      },
                    ),
                  ),
                  SizedBox(height: 30,),
                  SmsButtonsNew(tapSmsButton:widget.next, color: kOrangeColor, title: 'Verify'),
                  SizedBox(height: 30,),


                ],
              ),
            ),
          ],
        ),
      ),

    );
  }

  String? _pinValidator(String? value) {
    return value!.trim().isEmpty ? "Otp is required" : null;
  }


}
