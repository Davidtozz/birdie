import 'dart:async';
import 'dart:convert';
import 'package:birdie/providers/contact_provider.dart';
import 'package:birdie/shared/globalcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'chat.dart';

class Contacts extends StatefulWidget {
  Contacts({Key? key, this.userName}) : super(key: key);

  String? userName;

  // static fetchData() async {}

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  final listViewBuilderKey = UniqueKey();

  late Future fetchFromAWS;
  var dialogContactNameController = TextEditingController();



  List<String> name = [], number = []; // ! Info achieeved from server

  String lastOnline = '15:16'; //todo: retrieve info from DB
  List<String> lastMessageSent = []; //todo: retrieve info from DB

 


  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: Provider.of<ContactProvider>(context),
        builder: ((context, snapshot) {
          var contactProvider = Provider.of<ContactProvider>(context);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                height: 150,
                width: 150,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballClipRotateMultiple,
                  colors: [GlobalColors.purple],
                  strokeWidth: 5.0,
                ),
              ),
            );
          } else {
            return Scaffold(
                body: contactProvider.contactNameList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/404.svg',
                              height: 140,
                            ),
                            const SizedBox(height: 20),
                            Flexible(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Text('I see nobody in here 😞',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: GlobalColors.black,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount:contactProvider.contactNameList.length, 
                        // ! itemCount is known by the amount of contacts present in the DB
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onLongPress: () => showDialog(
                                  //? Delete contact
                                  context: context,
                                  builder: (context) => AlertDialog(
                                          title: const Text("Delete contact"),
                                          content: Text(
                                              "Are you sure you want to delete ${contactProvider.contactNameList[index]}?"),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text("Cancel"),
                                              onPressed: () {
                                                // ? nothing happens if the user cancels
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                                // ! deletes the contact if the user confirms
                                                child: const Text("Delete"),
                                                onPressed: () {
                                                  //delete the contact
                                                  contactProvider.deleteContact(
                                                    contactName: name[index],
                                                    userName: widget.userName
                                                  );
                                                  // deleteContact(
                                                  //     contactName: name[index]);
                                                  setState(() {});

                                                  Navigator.of(context).pop();
                                                })
                                          ])),
                              child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: GlobalColors.purple,
                                    child: Text(
                                      contactProvider.contactNameList.isEmpty
                                          ? 'A'
                                          : contactProvider.contactNameList[index][0].toUpperCase(),
                                      // ! if contact isn't saved with a name, show his number instead
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  title: Text(contactProvider.contactNameList[index],
                                      style: GoogleFonts.roboto()),
                                  subtitle: Row(
                                    children: [
                                      Text('Last: ',
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w900)),
                                      Text(contactProvider.lastMessageSent[index],
                                          style: GoogleFonts.roboto())
                                    ],
                                  ),
                                  onTap: () {
                                    //show dialog
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            alignment: Alignment.center,
                                            // duration: const Duration(milliseconds: 300),
                                            // reverseDuration: const Duration(milliseconds: 200),
                                            type: PageTransitionType.fade,
                                            child: Chat(
                                              userName: widget.userName!,
                                              contactName: contactProvider.contactNameList[
                                                  index], // ! pass contact name to Chat widget
                                              // ! pass contact number to Chat widget
                                              lastOnline:
                                                  lastOnline, // ! pass contact last online to Chat widget
                                            )));
                                  }));

                          // );
                        },
                      ),
                floatingActionButton: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: FloatingActionButton.small(
                        // ? Refresh FAB
                        onPressed: (() => setState(() {
                              contactProvider.contactNameList.clear();
                              // fetchFromAWS = fetchData();
                            })),
                        backgroundColor: Colors.grey[600],
                        heroTag: 'refresh',
                        child: const Icon(Icons.refresh),
                      ),
                    ),
                    FloatingActionButton(
                      // ? Add contact FAB
                      backgroundColor: GlobalColors.purple,
                      tooltip: 'Add',
                      heroTag: 'add',
                      onPressed: () {
                        //show a dialog

                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                              "Add a contact",
                              textAlign: TextAlign.center,
                            ),
                            content: SizedBox(
                              child: TextField(
                                onSubmitted: (value) {
                                  http.post(
                                      Uri.parse(
                                          'https://birdie-auth-testing.herokuapp.com/api/users/${widget.userName}/addcontact'),
                                      headers: {
                                        'Content-Type': 'application/json'
                                      },
                                      body: json.encode({'name': value}));

                                  dialogContactNameController.text = value = "";
                                  Navigator.pop(context);
                                  setState(() {
                                    contactProvider.contactNameList.add(value);
                                    // fetchFromAWS = fetchData();
                                  });

                                  // dialogController.text = value;
                                },
                                controller: dialogContactNameController,
                                decoration: const InputDecoration(
                                  labelText: "Name",
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text("Add"),
                                onPressed: () {
                                  http.post(
                                      Uri.parse(
                                          'https://birdie-auth-testing.herokuapp.com/api/users/${widget.userName}/addcontact'),
                                      headers: {
                                        'Content-Type': 'application/json'
                                      },
                                      body: json.encode({
                                        'name': dialogContactNameController.text
                                      }));

                                  Navigator.of(context).pop();
                                  setState(() {
                                    contactProvider.contactNameList.add(dialogContactNameController.text);
                                    // fetchFromAWS = fetchData();
                                  });
                                  dialogContactNameController.clear();
                                },
                              ),
                            ],
                          ),
                        );

                        // setState(() {
                        //   fetchFromAWS = fetchData();
                        // });
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.plus,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ));
          }
        }),
      );
}
