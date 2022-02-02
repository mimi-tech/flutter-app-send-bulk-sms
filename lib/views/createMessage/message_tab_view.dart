import 'package:bulk_sms/components/sms_buttons.dart';
import 'package:bulk_sms/models/new_user.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/dimen.dart';
import 'package:bulk_sms/view_model/users_Auth_provider.dart';
import 'package:bulk_sms/views/contacts.dart';
import 'package:bulk_sms/views/createMessage/create_contact_group.dart';
import 'package:bulk_sms/views/createMessage/create_message.dart';
import 'package:bulk_sms/views/createMessage/view_contact_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';



class MessageTabView extends StatelessWidget {
  const MessageTabView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    NewUser user = Provider.of<UserProvider>(context).user;

    return DefaultTabController(
      length: 2,
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: kDarkBlue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Create new message", style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kWhiteColor)),
            ElevatedButton(onPressed: (){},
                style: ButtonStyle(

                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFB6B6B6)),

                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: 'Balance:  ',
                      style: Theme.of(context).textTheme.caption!.copyWith(color: kWhiteColor,fontWeight: FontWeight.normal),

                      children: <TextSpan>[
                        TextSpan(text: user.wallet.toString(),
                            style: Theme.of(context).textTheme.caption!.copyWith(color: kTextColor,fontWeight: FontWeight.normal)
                        ),
                      ]),
                ),



            )

            ],
          ),
          bottom: TabBar(
            isScrollable: true,
            unselectedLabelColor: Color(0xFFB6B6B6),
            indicatorColor: Color(0xFF3AF2EA),
            labelColor:Color(0xFF3AF2EA),
            labelStyle: GoogleFonts.rajdhani(
              textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color(0xFFB6B6B6),
                fontSize: kFontSize14.sp
              ),
            ),
            tabs: [
              Tab(

                child: Row(

                  children: [
                    SvgPicture.asset('assets/contacts.svg'),
                    SizedBox(width: 5.0),
                    Text('Add contacts'),

                  ],
                ),
              ),


              Tab(

                child: Row(
                  children: [
                    SvgPicture.asset('assets/contact_group.svg'),
                    SizedBox(width: 5.0),
                    Text('Select Contacts',

                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
        body: TabBarView(
          children: [
            CreateMessage(),
            //ContactScreen(),
            //ViewGroupContactScreen(),
            ViewGroupContactScreen(),

          ],
        ),
      ),
    );
  }
}
