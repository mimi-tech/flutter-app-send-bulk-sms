import 'package:bulk_sms/components/appbar.dart';
import 'package:bulk_sms/components/appbar2.dart';
import 'package:bulk_sms/components/modalProgressFunction.dart';
import 'package:bulk_sms/components/progressIndicator.dart';
import 'package:bulk_sms/components/sms_buttons.dart';
import 'package:bulk_sms/models/new_user.dart';
import 'package:bulk_sms/view_model/message_service_view_modal.dart';
import 'package:bulk_sms/view_model/save_messages.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/view_model/users_Auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
class SavedMessageScreen extends StatefulWidget {
  const SavedMessageScreen({Key? key}) : super(key: key);

  @override
  _SavedMessageScreenState createState() => _SavedMessageScreenState();
}

class _SavedMessageScreenState extends State<SavedMessageScreen> {

  @override
  Widget build(BuildContext context) {
    NewUser user = Provider.of<UserProvider>(context).user;

     return ChangeNotifierProvider<MessageServices>(
         create: (context)=> MessageServices(),
    builder: (context,child){


    return Consumer<MessageServices>(
    builder: (context, savedMessages, child) {
    return Scaffold(
          backgroundColor: Colors.blueGrey,
          appBar: BulkSmsAppbarSecond(title: '${user.fullName} Messages',color:kBlackColor,
          deleteButton: SmsButtonsNew(tapSmsButton: () async {
            await savedMessages.getDeleteAllSavedMessages();
          },color: kRedColor,title: "Delete all",),
          ),
           body: ProgressHUDFunction(
             inAsyncCall: savedMessages.loading,
             child: Container(
                child: Column(
                      children: [

                        FutureBuilder(
                          future: savedMessages.getUserSavedMessages(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {

                            if (snapshot.hasData) {
                              return  Expanded(
                              child: ListView.builder(
                                  padding: EdgeInsets.all(8),
                                  itemCount: savedMessages.storedMessages.length,//snapshot.data.length,
                                  itemBuilder: (BuildContext context, int index){
                                    List<dynamic> messageReceivers = snapshot.data[index]["recieversNumber"];
                                    List<dynamic> messageFailed = snapshot.data[index]["failedContacts"]??[];
                                    return SingleChildScrollView(
                                      child: Card(
                                        elevation: 5.0,
                                        child: ExpansionTile(
                                          //leading: Icon(Icons.email),
                                          iconColor: kLightBlue,
                                          collapsedIconColor: kOrangeColor,
                                          backgroundColor: Colors.white70,
                                          collapsedBackgroundColor: kBlackColor,
                                          title: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ListTile(

                                                title:Text(snapshot.data[index]['title']??'Title',
                                                  style: Theme.of(context).textTheme.caption!.copyWith(color: kLightBlue),

                                                ),

                                                subtitle:Text(snapshot.data[index]['dateSent']??'Date sent',
                                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kAshColor),

                                                ),

                                                trailing: Container(

                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(color: kLightBlue, width: 1.0)
                                                    ),
                                                    child: Padding(
                                                        padding: const EdgeInsets.all(14.0),
                                                        child: Text(snapshot.data[index]['count'].toString(),
                                                          style: Theme
                                                              .of(context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(color: Colors.blueGrey,fontWeight: FontWeight.bold),

                                                        )
                                                    )),


                                              ),


                                            ],
                                          ),
                                          children: <Widget>[
                                            ExpansionTile(
                                              title: Text(
                                                'Text message',
                                                style: Theme.of(context).textTheme.caption!.copyWith(color: kGreenColor),

                                              ),
                                              children: <Widget>[
                                                Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  color:kGreenColor,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text("Message: ${snapshot.data[index]['message']??""}",
                                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kTextColor),

                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),

                                            ExpansionTile(
                                              title: Text(
                                                'Sent Contact(s)',
                                                style: Theme.of(context).textTheme.caption!.copyWith(color: kLightBlue),

                                              ),
                                              children: <Widget>[
                                                Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  color:Colors.orangeAccent,
                                                  height:MediaQuery.of(context).size.height * 0.25,
                                                  child: ListView.builder(
                                                      padding: EdgeInsets.all(8),
                                                      itemCount: messageReceivers.length,
                                                      itemBuilder: (BuildContext context, int index){
                                                        return messageReceivers.length == 0?Text('No contact seen',
                                                          style: Theme.of(context).textTheme.bodyText1,
                                                        )

                                                            :ListTile(

                                                            leading: Text("${index + 1}".toString(),
                                                              style: Theme.of(context).textTheme.bodyText1,

                                                            ),
                                                            trailing: IconButton(onPressed: (){}, icon: Icon(Icons.check,color: Colors.green,)),
                                                            title:Text(messageReceivers[index],
                                                              style: Theme.of(context).textTheme.bodyText1,

                                                            )
                                                        );
                                                      }
                                                  ),
                                                ),

                                              ],
                                            ),

                                            ExpansionTile(
                                              title: Text(
                                                'Failed Contact(s)',
                                                style: Theme.of(context).textTheme.caption!.copyWith(color: kRedColor),

                                              ),
                                              children: <Widget>[
                                                Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  color:Colors.redAccent.withOpacity(0.2),
                                                  height:MediaQuery.of(context).size.height * 0.25,
                                                  child: ListView.builder(
                                                      padding: EdgeInsets.all(8),
                                                      itemCount: messageFailed.length != 0?messageFailed.length:0,
                                                      itemBuilder: (BuildContext context, int index){
                                                        return messageFailed.length == 0?Text('No failed message',
                                                          style: Theme.of(context).textTheme.bodyText1,
                                                        )

                                                            :ListTile(

                                                            leading: Text("${index + 1}".toString(),
                                                              style: Theme.of(context).textTheme.bodyText1,

                                                            ),
                                                            trailing: IconButton(onPressed: (){}, icon: Icon(Icons.check,color: Colors.green,)),
                                                            title:Text(messageFailed[index],
                                                              style: Theme.of(context).textTheme.bodyText1,

                                                            )
                                                        );
                                                      }
                                                  ),
                                                ),

                                              ],
                                            ),
                                            ListTile(
                                              title: Text('Sender: ${snapshot.data[index]['fullName']}',
                                                style: Theme.of(context).textTheme.caption!.copyWith(color: kLightBlue),

                                              ),
                                              subtitle: Text('Amount: ${snapshot.data[index]['amount']??'0.00'}'.toString(),
                                                style: Theme.of(context).textTheme.caption!.copyWith(color: kGreenColor),

                                              ),

                                              trailing: SmsButtonsNew(title: "Delete", color: kRedColor,tapSmsButton: () async {
                                               await savedMessages.getDeleteUserSavedMessages(snapshot.data[index]['msgId']);
                                                //after deleting the message remove it from the list
                                                savedMessages.storedMessages.removeAt(index);
                                              },)
                                            )
                                          ],
                                        ),

                                      ),
                                    );


                                  }
                                  ),
                            );

                          }
                        if (snapshot.hasError) {
                          return Center(child: Text("Unable to get your messages at the moment."));

                        }
                            if (!snapshot.hasData) {
                              return Center(child: Text("You have no saved messages."));

                            }
                            return ShowProgress();
                        }

                        )




                      ],
                    ),
                  ),
           ));


              });


  });
}}
