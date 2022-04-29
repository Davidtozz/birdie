import 'package:birdie/globalcolors.dart';
import 'package:birdie/home/chat.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  String name = "fkfkfkkf"; //todo: retrieve info from DB
  String number = "voveoihoroe"; //todo: retrieve info from DB
  double lastOnline = 0.0; //todo: retrieve info from DB
  String lastMessageSent = "fe3hoh3i"; //todo: retrieve info from DB
  bool isOnline = false; //todo: retrieve info from DB

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount:
            10, // ! itemCount is known by the amount of contacts present in the DB
        itemBuilder: (context, index) {
          return ListTile(
              leading: CircleAvatar(
                backgroundColor: GlobalColors.purple,
                child: name.isEmpty
                    ? Text(
                        number, // !if contact isn't saved with name, show his number instead
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )
                    : Text(name[0], // ! else, show the first letter of his name
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 20,
                        )),
              ),
              title: Text(name, style: GoogleFonts.roboto()),
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
                          contactName: name,
                          number: number,
                          lastOnline: lastOnline,
                        )));
              });
        },
      ),
    );
  }
}
