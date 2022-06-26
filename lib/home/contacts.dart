import 'dart:async';
import 'dart:convert';
import 'package:birdie/shared/globalcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'chat.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key, required this.userName}) : super(key: key);

  final String userName;

  // static fetchData() async {}

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  final listViewBuilderKey = UniqueKey();

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
  List<String> lastMessageSent = []; //todo: retrieve info from DB

  Future<void> fetchData() async {
    debugPrint('Fetching user ${widget.userName} data');

    var request = await http.get(Uri.parse(
        //  'localhost:3000/api/getcontacts' // ! API HEROKU URL
        'https://birdie-auth-testing.herokuapp.com/api/users/${widget.userName}/getcontacts'));
    var response = await json.decode(request.body);

    var test = response[0]['content'];

    debugPrint('Last message sent: $test');

    debugPrint('LastMessageSent List content: $lastMessageSent');

    setState(() {
      name.clear();
      lastMessageSent.clear();
      if (name.isEmpty && number.isEmpty) {
         
         
        // ? Recent fix
        for (int i = 0; i < response.length; i++) {
          name.add(response[i]['name']);
          lastMessageSent.add(response[i]['content'] ?? '');
        }
        // debugPrint('\nResponse body: ${response.toString()}');
        // debugPrint('Recent messages: ${name.toString()}');
        debugPrint('Found ${name.length} contacts for user ${widget.userName}');
      }

      if (name.last != response[response.length - 1]['name']) {
        name.add(response[response.length - 1]['name']);
      }
    });
  }

  Future<void> deleteContact({required String contactName}) async {
    var url =
        'https://birdie-auth-testing.herokuapp.com/api/users/${widget.userName}/deletecontact';

    var chosenContact = json.encode({'name': contactName});

    await http
        .delete(Uri.parse(url),
            headers: {'Content-Type': 'application/json'}, body: chosenContact)
        .then((value) {
      if (value.statusCode == 200) {
        debugPrint('Deleted contact: $contactName');
        setState(() {
          debugPrint('$name before');
          name.remove(contactName);
          debugPrint('$name after');
          fetchFromAWS = fetchData();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: fetchFromAWS,
        builder: ((context, snapshot) {
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

                                                  deleteContact(
                                                      contactName: name[index]);
                                                  Navigator.of(context).pop();
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
                                  subtitle: Row(
                                    children: [
                                      Text('Last: ',
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w900)),
                                      Text(lastMessageSent[index],
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
                                              userName: widget.userName,
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
                                          'https://birdie-auth-testing.herokuapp.com/api/users/${widget.userName}/addcontact'),
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
                                          'https://birdie-auth-testing.herokuapp.com/api/users/${widget.userName}/addcontact'),
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
