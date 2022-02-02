import 'package:bulk_sms/components/appbar2.dart';
import 'package:bulk_sms/components/constants.dart';
import 'package:bulk_sms/components/modalProgressFunction.dart';
import 'package:bulk_sms/components/progressIndicator.dart';
import 'package:bulk_sms/components/sms_buttons.dart';
import 'package:bulk_sms/utility/Validators.dart';
import 'package:bulk_sms/utility/colors.dart';
import 'package:bulk_sms/utility/dimen.dart';
import 'package:bulk_sms/view_model/users_contact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateContactGroupScreen extends StatefulWidget {
  const CreateContactGroupScreen({Key? key}) : super(key: key);

  @override
  _CreateContactGroupScreenState createState() => _CreateContactGroupScreenState();
}

class _CreateContactGroupScreenState extends State<CreateContactGroupScreen> {

  ContactServicesViewModal? notifier;
  TextEditingController _title = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? filter;
  Icon actionIcon =  Icon(Icons.search,color: kAshColor,size: 25,);
  bool checkSearch = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final notifier = Provider.of<ContactServicesViewModal>(context);

    if (this.notifier != notifier) {
      this.notifier = notifier;
      Future.microtask(() => notifier.getViewContact());
    }
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    notifier!.contact.clear();
    pickedContacts.clear();
    //newContact.clear();
    super.dispose();
  }
Widget bodyList(ContactServicesViewModal modal, int index){
    return Card(
      color: kListView,
      child: ListTile(

          leading: Text("${index + 1}",
            style: Theme
                .of(context)
                .textTheme
                .bodyText1!
                .copyWith(
                color: kWhiteColor),

          ),


          trailing: modal
              .selectedContacts
              .contains(modal
              .storedContacts[index]) ?
          IconButton(onPressed: () {
            modal.removeContact(modal
                .storedContacts[index]);
          },
              icon: Icon(
                Icons.check_box,
                color: kLightBlue,))
              : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: () {
                modal.addSelectedContact(modal.storedContacts[index]);
              },
                  icon: Icon(Icons.check_box_outline_blank, color: kLightBlue,)),

              IconButton(onPressed: () {
                modal.removeAContact(modal.storedContacts[index]);
                // modal.storedContacts.remove(modal.storedContacts[index]);
              },
                  icon: Icon(Icons.delete, color: kRedColor,)),
            ],
          ),


          title: Text(
            modal.storedContacts[index],
            style: Theme
                .of(context)
                .textTheme
                .bodyText1!
                .copyWith(
                color: kWhiteColor),

          )
      ),
    );
}
  @override
  Widget build(BuildContext context) {
    //ContactServicesViewModal usersContact = Provider.of<ContactServicesViewModal>(context);


    return SafeArea(
        child:  Consumer<ContactServicesViewModal>(
            builder: (context, modal, child)
            {
              return Scaffold(
                backgroundColor: kBlackColor,
                  appBar: AppBar(
                    backgroundColor: kDarkBlue,
                    title: checkSearch ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                       Text( 'Create Contact group( ${modal.storedContacts.length.toString()} )'.toUpperCase(),
                         style: Theme.of(context).textTheme.caption!.copyWith(color: kWhiteColor),

                       ),

                        modal.changeIcon?
                        IconButton(onPressed: (){
                          modal.changeCheckedIcon();
                          //newContact.clear();
                          for(int i = 0; i < modal.storedContacts.length; i++){
                            modal.removeContact(modal.storedContacts[i]);

                          }
                        }, icon: Icon(Icons.check_box,color: kWhiteColor,))
                            :IconButton(onPressed: (){
                          modal.changeCheckedIcon();

                          for(int i = 0; i < modal.storedContacts.length; i++){
                            modal.addSelectedContact(modal.storedContacts[i]);

                          }
                        }, icon: Icon(Icons.check_box_outline_blank,color: kWhiteColor,)),
                        IconButton(onPressed: (){
                          setState(() {
                            checkSearch = false;
                          });}, icon: Icon(Icons.search))
                      ],
                    ):Container(

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Expanded(
                            child: TextFormField(
                                controller: searchController,
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kWhiteColor),
                                autocorrect: true,
                                autofocus: true,
                                cursorColor: kBlackColor,
                                keyboardType: TextInputType.text,
                                decoration: searchInput),
                          ),

                          IconButton(onPressed: (){
                            setState(() {
                            checkSearch = true;
                          });}, icon: Icon(Icons.cancel))
                        ],
                      ),
                    ),

                  ),


                  body: ProgressHUDFunction(
                    inAsyncCall: modal.loading,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: kMargin),
                        child: Column(
                          children: [
                            spacing(context),
                            Form(
                              key: _formKey,
                              child: TextFormField(
                                controller: _title,
                                cursorColor: (kOrangeColor),
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.sentences,
                                maxLength: 10,
                                validator: Validator.validateContactTitle,

                                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: kWhiteColor),
                                decoration: InputDecoration(
                                  suffix: GestureDetector(
                                    onTap: (){
                            final form = _formKey.currentState;
                            if (form!.validate()) {
                            form.save();
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            modal.getAddGroupContact(context);
                            }
                                    },
                                    child: Text("Create",
                                      style: Theme.of(context).textTheme.subtitle1!.copyWith(color: kLightBlue),
                                    ),
                                  ),
                                  isDense: true,
                                  hintText: 'Enter new group title or existing',
                                  hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,

                                  errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
                                  border: Theme.of(context).inputDecorationTheme.border!.copyWith(borderSide: BorderSide(color: kAshColor)),
                                  enabledBorder:Theme.of(context).inputDecorationTheme.enabledBorder,
                                  focusedBorder:Theme.of(context).inputDecorationTheme.focusedBorder!.copyWith(borderSide: BorderSide(color: kAshColor)),
                                  focusedErrorBorder:Theme.of(context).inputDecorationTheme.focusedErrorBorder,
                                  errorBorder:Theme.of(context).inputDecorationTheme.errorBorder,
                                  contentPadding: Theme.of(context).inputDecorationTheme.contentPadding,
                                ),
                                onSaved: (String? value) {
                                  contactName = value;
                                },
                              ),
                            ),


                            Column(
                              children: [
                                Text(modal.infoText,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(color: kWhiteColor),
                                ),

                              ],
                            ),

                            FutureBuilder(
                                future: modal.getViewContact(),
                                builder: (context, snapshot) {

                                  return Expanded(
                                    child: ListView.builder(
                                        itemCount: modal.storedContacts.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return SingleChildScrollView(

                                              child: Consumer<ContactServicesViewModal>(
                                                  builder: (context, modal, child) {
                                                    return modal.storedContacts
                                                        .length == 0 ? ShowProgress()
                                                        :  filter == null || filter == "" ?bodyList(modal, index):
                                                    '${modal.storedContacts[index]}'.contains(filter!)

                                                        ?bodyList(modal,index):Container();


                                                  }));
                                        }
                                    ),
                                  );
                                }


                            ),


                          ],
                        )
                    ),
                  ));
            }));
  }





}
