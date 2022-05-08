import 'package:birdie/globalcolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'chat.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  
  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  String name = "Giuanni"; //todo: retrieve info from DB
  String number = "+39 465 237 0014"; //todo: retrieve info from DB
  String lastOnline = '15:16'; //todo: retrieve info from DB
  String lastMessageSent =
      "Fuck you, and i'll see you tomorrow!"; //todo: retrieve info from DB

  Future<void> fetchData() async {
    await http.get(Uri.parse('http://localhost:3000/getcontacts'));
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      interactive: true,
      thumbVisibility: true,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount:
            5, // ! itemCount is known by the amount of contacts present in the DB
        itemBuilder: (context, index) {
          return ListTile(
              leading: CircleAvatar(
                backgroundColor: GlobalColors.purple,
                child: Text(
                  name.isEmpty
                      ? '?'
                      : name[
                          0], // ! if contact isn't saved with a name, show his number instead
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              title: Text(name.isEmpty ? number : name,
                  style: GoogleFonts.roboto()),
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
                          contactName:
                              name, // ! pass contact name to Chat widget
                          number:
                              number, // ! pass contact number to Chat widget
                          lastOnline:
                              lastOnline, // ! pass contact last online to Chat widget
                        )));
              });
        },
      ),
    );
  }
}

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile();
  }
}
