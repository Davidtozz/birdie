import 'package:birdie/globalcolors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Chat extends StatefulWidget {
  final String contactName, number;
  //  pathToContactImage; //todo: implement pathToContactImage via DB or server
  final double lastOnline;
  const Chat({
    Key? key,
    required this.contactName,
    required this.number,
    required this.lastOnline,
    // required this.pathToContactImage,
  }) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  String label = "Write something...";

  var defaultChatBackgrounds = [
    'assets/chat_bg/moonlight.png',
    'assets/chat_bg/purple_saturn.jpg',
    'assets/chat_bg/sunset.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        // backgroundColor: GlobalColors.purple,
        leading: CircleAvatar(
          backgroundColor: GlobalColors.purple,
          child: Text(widget.contactName[0],
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 20,
              )),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.contactName),
            Text(
              widget.lastOnline.toString(),
              style: GoogleFonts.roboto(fontSize: 15),
            ),
          ],
        ),
      ),

      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              isAntiAlias: true,
              image: AssetImage(defaultChatBackgrounds[0]),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.all(15),
            child: FormBuilderTextField(
              onSubmitted: (value) => setState(() {
                label = 'Write something...';
              }),
              onTap: () {
                setState(() {
                  label = "";
                });
              },
              name: 'message',
              decoration: InputDecoration(
                suffixIcon: const Padding(
                  padding:  EdgeInsets.fromLTRB(0, 11, 5, 0),
                  child:  FaIcon(FontAwesomeIcons.solidMessage, size: 30),
                ),
                
                labelText: label,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                //  labelText: 'Type a message...',
                labelStyle: GoogleFonts.roboto(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ]),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const FaIcon(FontAwesomeIcons.solidMessage)
      // ),
    );
  }
}
