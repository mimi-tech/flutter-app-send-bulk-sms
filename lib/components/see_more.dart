import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/dimen.dart';
import 'package:flutter/material.dart';

class SeeMore extends StatelessWidget {
  final VoidCallback tapSeeMore;
  final VoidCallback tapAddMore;

  const SeeMore({Key? key,required this.tapSeeMore,required this.tapAddMore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment:MainAxisAlignment.end ,
      children: [
        OutlinedButton.icon(

          icon: Icon(Icons.add,color: kBlackColor,),
          onPressed: tapSeeMore,
          style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),

            side: BorderSide(color: kLightBlue, width: 1),
          ),
          label: Text("See all",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(color: kLightBlue,fontSize: kFontSize12)
          ),

        )
      ],
    );
  }
}
