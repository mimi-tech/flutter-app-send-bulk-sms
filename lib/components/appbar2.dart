import 'package:bulk_sms/utility/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BulkSmsAppbarSecond extends StatefulWidget with PreferredSizeWidget{
  const BulkSmsAppbarSecond({Key? key, required this.title, required this.color,required this.deleteButton}) : super(key: key);
  final String title;
  final Color color;
  final Widget deleteButton;
  @override
  _BulkSmsAppbarSecondState createState() => _BulkSmsAppbarSecondState();
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56.0);

}

class _BulkSmsAppbarSecondState extends State<BulkSmsAppbarSecond> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon:Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: widget.color,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title.toUpperCase(),
            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kWhiteColor,fontWeight: FontWeight.bold),
          ),
         widget.deleteButton
        ],
      ),
    );
  }
}
