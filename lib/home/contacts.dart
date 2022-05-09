import 'dart:async';
import 'dart:convert';

import 'package:birdie/globalcolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'chat.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  // static fetchData() async {}

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  void initState() {
    // TODO: implement initState
    
 
    // Timer.periodic(const Duration(seconds: 1), (timer) {
    //   ;
    // });
    fetchData();

    if (mounted) {}

    super.initState();
  }

  

  List<String> name = []; // ! Info achieeved from server

  String number = "+39 465 237 0014"; //todo: retrieve info from DB
  String lastOnline = '15:16'; //todo: retrieve info from DB
  String lastMessageSent =
      "Fuck you, and i'll see you tomorrow!"; //todo: retrieve info from DB

  Future<void> fetchData() async {
    var request =
        await http.get(Uri.parse('http://localhost:3000/getcontacts'));
    var response = json.decode(request.body);

    setState(() {
      if (name.isEmpty) {
        for (var i = 0; i < response.length; i++) {
          name.add(response[i]['contact_name']);
        }
      }

      if (name.last != response[response.length - 1]['contact_name']) {
        name.add(response[response.length - 1]['contact_name']);
      }
    });

    debugPrint(name.toString());
  }

  fetchDataPeriodically() {} //TODO: implement listener to check for updates in DB

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      interactive: true,
      thumbVisibility: true,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: name
            .length, // ! itemCount is known by the amount of contacts present in the DB
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () => showDialog(
                context: context,
                builder: (context) =>

                    //Add a popup dialog to delete the contact
                    AlertDialog(
                        title: const Text("Delete contact"),
                        content: Text(
                            "Are you sure you want to delete ${name[index]}?"),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("Cancel"),
                            onPressed: () {
                              // ! nothing happens if the user cancels
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                              // ! deletes the contact if the user confirms
                              child: const Text("Delete"),
                              onPressed: () {
                                //delete the contact
                                http.delete(
                                    Uri.parse(
                                        'http://localhost:3000/deletecontact'),
                                    headers: {
                                      'Content-Type': 'application/json'
                                    },
                                    body: json
                                        .encode({'contact_name': name[index]}));
                                Navigator.of(context).pop();
                                //remove the contact from the list
                                setState(() {
                                  name.removeAt(index);
                                });
                                fetchData();
                              })
                        ])),
            // SimpleDialog(
            //         title: Text(name[index]),
            //         children: <TextButton>[
            //           TextButton(
            //               child: const Text('Edit'),
            //               onPressed: () {
            //                 Navigator.of(context).pop();
            //               })
            //         ])),

            child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: GlobalColors.purple,
                  child: Text(
                    name.isEmpty ? 'A' : name[index][0].toUpperCase(),
                    // ! if contact isn't saved with a name, show his number instead
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                title: Text(name[index], style: GoogleFonts.roboto()),
                subtitle: Text(lastMessageSent, style: GoogleFonts.roboto()),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          alignment: Alignment.center,
                          // duration: const Duration(milliseconds: 300),
                          // reverseDuration: const Duration(milliseconds: 200),
                          type: PageTransitionType.fade,
                          child: Chat(
                            contactName: name[
                                index], // ! pass contact name to Chat widget
                            number:
                                number, // ! pass contact number to Chat widget
                            lastOnline:
                                lastOnline, // ! pass contact last online to Chat widget
                          )));
                }),
          );
        },
      ),
    );
  }
}

// * CLasse inutile perché non utilizzata

// class Contact extends StatelessWidget {
//   const Contact({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile();
//   }
// }
