
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/internet_connection.dart';
import 'package:bulk_sms/utility/dimen.dart';
import 'package:bulk_sms/views/LandingPage.dart';
import 'package:bulk_sms/views/profile/view_profile.dart';
import 'package:bulk_sms/views/saved_message_screen.dart';
import 'package:bulk_sms/views/Funds/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasicBottomNavBar extends StatefulWidget {
  BasicBottomNavBar ({Key? key}) : super(key: key);

  @override
  _BasicBottomNavBarState createState() => _BasicBottomNavBarState();
}

class _BasicBottomNavBarState extends State<BasicBottomNavBar > {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    LandingPage(),

    SavedMessageScreen(),
   WalletScreen(),
    ViewProfileScreen(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    InternetConnections().checkConnection(context);

  }


  @override
  void deactivate() {
    InternetConnections().dispose();
    super.deactivate();
    print("deactivate");
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
       bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              //backgroundColor: Colors.green
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.email),
            label: 'Messages',
            //backgroundColor: Colors.blue,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Wallet',
            //backgroundColor: Colors.pink,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            //backgroundColor: Colors.pink,
          ),

        ],
        currentIndex: _selectedIndex,
        iconSize: 20,
        onTap: _onItemTapped,
        elevation: 5,

    showUnselectedLabels: true,
    type:  BottomNavigationBarType.fixed,
    backgroundColor: kBlackColor,
    mouseCursor: SystemMouseCursors.grab,
    selectedFontSize: 20,
    selectedIconTheme: IconThemeData(color: kOrangeColor, size: 20),
    selectedItemColor: kOrangeColor,
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold,
    color: kAshColor,
    fontSize: kFontSize16.sp
    ),
    unselectedIconTheme: IconThemeData(
    color: Colors.grey,
    ),
    unselectedItemColor: Colors.grey,


    ),
    );
  }
}