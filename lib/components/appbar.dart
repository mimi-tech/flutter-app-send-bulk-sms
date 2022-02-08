import 'package:bulk_sms/utility/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BulkSmsAppbar extends StatefulWidget with PreferredSizeWidget{
  const BulkSmsAppbar({Key? key, required this.title, required this.color}) : super(key: key);
final String title;
final Color color;
  @override
  _BulkSmsAppbarState createState() => _BulkSmsAppbarState();
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56.0);

}

class _BulkSmsAppbarState extends State<BulkSmsAppbar> {
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
      title: Text(widget.title.toUpperCase(),
        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kWhiteColor),
      ),
    );
  }
}


