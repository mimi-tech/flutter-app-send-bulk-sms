import 'package:bulk_sms/utility/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Header extends StatelessWidget {
 Header({required this.title});

  final String title;

  Widget space() {
    return SizedBox(height: 10.h);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      height: 65.h,

      child: ListView(
        //mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          space(),
          space(),
          Center(


              child: Text(title.toUpperCase(),
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: kOrangeColor),



              )

          ),
          //space(),
          Divider(thickness: 3.0,color: kNavyColor,),

        ],
      ),
    );
  }
}