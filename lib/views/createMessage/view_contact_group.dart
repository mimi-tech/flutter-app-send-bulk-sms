
import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/components/modalProgressFunction.dart';
import 'package:bulk_sms/components/progressIndicator.dart';
import 'package:bulk_sms/components/sms_buttons.dart';
import 'package:bulk_sms/models/contact_modal.dart';
import 'package:bulk_sms/services/contact_services.dart';
import 'package:bulk_sms/view_model/message_service_view_modal.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/view_model/users_contact.dart';
import 'package:bulk_sms/views/createMessage/create_contact_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as https;


class ViewGroupContactScreen extends StatefulWidget {
  const ViewGroupContactScreen({Key? key}) : super(key: key);

  @override
  _ViewGroupContactScreenState createState() => _ViewGroupContactScreenState();
}

class _ViewGroupContactScreenState extends State<ViewGroupContactScreen> {
  Future<List<GetUserContact>>? contactList;

  void initState() {
    super.initState();
    this.contactList = ContactServices.userContactGroup(https.Client());
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //this.contactList = ContactServices.userContactGroup(https.Client());
  }

  Widget _contactList() {
    return FutureBuilder(
        future: this.contactList,
        builder: (BuildContext context, AsyncSnapshot<List<GetUserContact>> snapshot) {
          if (snapshot.hasData) {
            return this._contactLists(snapshot.data!);
          }
          if (snapshot.hasError) {
            return Center(child: Text("Unable to fetch your transactions at the moment."));
          }


          return ShowProgress();
        });
  }

  Widget _contactLists(final List<GetUserContact> data) {
    return Consumer<ContactServicesViewModal>(
        builder: (context, modal, child) {

         return ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: data.map((contactData) => GestureDetector(

        child:SingleChildScrollView(
          child: Card(
            elevation: 5.0,
            child: ExpansionTile(
              //leading: Icon(Icons.email),
              iconColor: kLightBlue,
              collapsedIconColor: kOrangeColor,
              backgroundColor: Colors.white70,
              collapsedBackgroundColor: kDarkBlue,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                  leading: modal.selectedContactGroup == null?
                  IconButton(onPressed: (){modal.addGroupContact(name: contactData.contactName, contact: contactData.contacts);}, icon: Icon(Icons.check_box_outline_blank,color: kLightBlue,))
                      :
                  modal.selectedContactGroup!.containsKey(contactData.contactName.toString())?
                  IconButton(onPressed: (){modal.removeGroupContact(name: contactData.contactName);}, icon: Icon(Icons.check_box,color: kOrangeColor,)):
                  IconButton(onPressed: (){modal.addGroupContact(name: contactData.contactName, contact: contactData.contacts);}, icon: Icon(Icons.check_box_outline_blank,color: kLightBlue,)),



                    title:Text(contactData.contactName.toString(),
                      style: Theme.of(context).textTheme.caption!.copyWith(color: kLightBlue),

                    ),

                    subtitle:Text(contactData.updatedAt.toString(),
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kAshColor),

                    ),

                    trailing: Container(

                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: kLightBlue, width: 1.0)
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text(contactData.contacts!.length.toString(),
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
                    'Contact(s)',
                    style: Theme.of(context).textTheme.caption!.copyWith(color: kDarkBlue),

                  ),
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color:kDarkBlue,
                      height:MediaQuery.of(context).size.height * 0.4,
                      child: ListView.builder(
                          padding: EdgeInsets.all(8),
                          itemCount: contactData.contacts!.length,
                          itemBuilder: (BuildContext context, int index){
                            // List<dynamic>  allList = [];
                            //
                            // for(int i = 0; i <modal.selectedContactGroup!.values.toList().length; i++){
                            //   allList.addAll(modal.selectedContactGroup!.values.toList()[i]);
                            // }
                            //
                            // modal.allContact.addAll(allList);

                            return contactData.contacts!.length == 0?Text('No contact seen',
                              style: Theme.of(context).textTheme.bodyText1,
                            )

                                :ListTile(

                                leading: Text("${index + 1}".toString(),
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kWhiteColor),

                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    modal.allContact.contains(contactData.contacts![index]) ?
                                    IconButton(onPressed: (){modal.allContact.remove(contactData.contacts![index]);


                                    }, icon: Icon(Icons.check_box,color: kWhiteColor,))

                                    : IconButton(onPressed: (){modal.allContact.add(contactData.contacts![index]);}, icon: Icon(Icons.check_box_outline_blank,color: kWhiteColor,)),


                                    IconButton(onPressed: (){
                                      contactData.contacts!.remove(contactData.contacts![index]);
                                      modal.getDeleteSingleGroupContact(contactNameBYID: contactData.contactName, contact: contactData.contacts![index]);}, icon: Icon(Icons.delete,color: kRedColor,)),

                                  ],
                                ),
                                title:Text(contactData.contacts![index],
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kWhiteColor),

                                )
                            );
                          }
                      ),
                    ),

                  ],
                ),
                modal.loading?ShowProgress():ListTile(
                  leading: SmsButtonsNew(tapSmsButton: () async {
                    await modal.getDeleteGroupContact(contactNameBYID: contactData.contactName);
                  },color: kRedColor,title: "Delete",),)


              ],
            ),

          ),
        ),
        )
        ).toList(),
    );

          });}

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<MessageServices>(
        create: (context)=> MessageServices(),
        builder: (context,child){


          return  Consumer<ContactServicesViewModal>(
              builder: (context, modal, child) {
                return Scaffold(
                  backgroundColor: kLightAsh,
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                      backgroundColor: kDarkBlue,
                      title: GestureDetector(
                        onTap: (){
                          Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: CreateContactGroupScreen()));

                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              elevation: 5.0,

                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Create Contact group',
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kLightBlue,fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),),
                    body: ProgressHUDFunction(
                      inAsyncCall: modal.loading,
                      child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            children: [


                              spacing(context),

                              _contactList()





                            ],
                          ),
                        ),
                      ),
                    ));


              });


        });
  }}
