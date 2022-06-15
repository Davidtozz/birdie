import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:birdie/globalcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  Key listViewBuilderKey = UniqueKey();

  late Future fetchFromAWS;
  var dialogContactNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    name.clear();
    fetchFromAWS = fetchData();

    super.initState();
  }

  List<String> name = [], number = []; // ! Info achieeved from server

  String lastOnline = '15:16'; //todo: retrieve info from DB
  String lastMessageSent = "Placeholder"; //todo: retrieve info from DB

  Future<void> fetchData() async {
    var request = await http.get(Uri.parse(
        //  'localhost:3000/api/getcontacts' // ! API HEROKU URL
        'https://birdie-auth-testing.herokuapp.com/api/getcontacts'));
    var response = json.decode(request.body);

    setState(() {
      name.clear();
      if (name.isEmpty && number.isEmpty) {
        for (var i = 0; i < response.length; i++) {
          name.add(response[i]['name']);
          // number.add(response[i]['phone'].toString());

        }
        debugPrint('\nResponse body: ${response.toString()}');
        debugPrint('Contact list content: ${name.toString()}');
      }

      if (name.last != response[response.length - 1]['name']) {
        name.add(response[response.length - 1]['name']);
      }
    });
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: fetchFromAWS,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    color: GlobalColors.purple,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Loading...',
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No contacts found',
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: GlobalColors.purple,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: (() => setState(() {
                          name.clear();
                          fetchFromAWS = fetchData();
                        })),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(GlobalColors.purple),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: Text(
                      'Retry',
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
                body: name.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/404.svg',
                              height: 140,
                            ),
                            const SizedBox(height: 20),
                            Text('Feeling lonely? Invite someone to your crib',
                                style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: GlobalColors.black,
                                )),
                          ],
                        ),
                      )
                    : Scrollbar(
                        interactive: true,
                        thumbVisibility: true,
                        child: ListView.builder(
                          key: listViewBuilderKey,
                          physics: const BouncingScrollPhysics(),
                          itemCount: name
                              .length, // ! itemCount is known by the amount of contacts present in the DB
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onLongPress: () => showDialog(
                                    //? Delete contact
                                    context: context,
                                    builder: (context) => AlertDialog(
                                            title: const Text("Delete contact"),
                                            content: Text(
                                                "Are you sure you want to delete ${name[index]}?"),
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
                                                    http
                                                        .delete(
                                                            Uri.parse(
                                                                // 'localhost:5000/api/deletecontact'),
                                                                'https://birdie-auth-testing.herokuapp.com/api/deletecontact'), //! API HEROKU URL
                                                            headers: {
                                                              'Content-Type':
                                                                  'application/json'
                                                            },
                                                            body: json.encode({
                                                              'name':
                                                                  name[index]
                                                            }))
                                                        .then((value) {
                                                      if (value.statusCode ==
                                                          200) {
                                                        setState(() {
                                                          name.removeAt(index);
                                                        });
                                                      } else {
                                                        debugPrint(
                                                            'Error deleting contact');
                                                      }
                                                    });
                                                    Navigator.of(context).pop();
                                                    //remove the contact from the list
                                                    name.removeAt(index);
                                                    setState(() {
                                                      fetchFromAWS =
                                                          fetchData();
                                                    });
                                                  })
                                            ])),
                                child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: GlobalColors.purple,
                                      child: Text(
                                        name.isEmpty
                                            ? 'A'
                                            : name[index][0].toUpperCase(),
                                        // ! if contact isn't saved with a name, show his number instead
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    title: Text(name[index],
                                        style: GoogleFonts.roboto()),
                                    subtitle: Text(lastMessageSent,
                                        style: GoogleFonts.roboto()),
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
                                                contactName: name[
                                                    index], // ! pass contact name to Chat widget
                                                // ! pass contact number to Chat widget
                                                lastOnline:
                                                    lastOnline, // ! pass contact last online to Chat widget
                                              )));
                                    }));

                            // );
                          },
                        ),
                      ),
                floatingActionButton: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: FloatingActionButton.small(
                        // ? Refresh FAB
                        onPressed: (() => setState(() {
                              name.clear();
                              fetchFromAWS = fetchData();
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
                                          'https://birdie-auth-testing.herokuapp.com/api/addcontact'),
                                      headers: {
                                        'Content-Type': 'application/json'
                                      },
                                      body: json.encode({'name': value}));

                                  dialogContactNameController.text = value = "";
                                  Navigator.pop(context);
                                  setState(() {
                                    name.add(value);
                                    fetchFromAWS = fetchData();
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
                                          'https://birdie-auth-testing.herokuapp.com/api/addcontact'),
                                      headers: {
                                        'Content-Type': 'application/json'
                                      },
                                      body: json.encode({
                                        'name': dialogContactNameController.text
                                      }));

                                  Navigator.of(context).pop();
                                  setState(() {
                                    name.add(dialogContactNameController.text);
                                    fetchFromAWS = fetchData();
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
