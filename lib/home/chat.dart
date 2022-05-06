import 'package:birdie/globalcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Chat extends StatefulWidget {
  final String contactName, number;
  //  pathToContactImage; //todo: implement pathToContactImage via DB or server
  final String lastOnline;
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
  final defaultChatBackgrounds = [
    'assets/chat_bg/moonlight.png',
    'assets/chat_bg/purple_saturn.jpg',
    'assets/chat_bg/sunset.png',
  ];

  String message = "";

  String setMessage() {
    return message;
  }

  int messageCount = 1; // ! Amount of messages in chat

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.purple,
        elevation: 5.0,
        // backgroundColor: GlobalColors.purple,
        title: topContactInfo(),
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
        Container(
          margin: const EdgeInsets.only(bottom: 80),
          child: ListView.builder(
              reverse: true,
              itemBuilder: ((context, index) {
                // ! Message count
                return Message(
                  messageBody: message,
                );
              }),
              itemCount: messageCount),
        ),
        Align(
          // !
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: FormBuilderTextField(
                focusNode: FocusNode(canRequestFocus: true),
                onSubmitted: (value) {
                  setState(() {
                    label = "Write something...";

                    message = value!;
                    value = null;
                    messageCount++;
                  });
                },
                // controller: TextEditingController(text: label),
                key: _fbKey,
                onChanged: (value) {
                  setState(() {
                    label = "";
                  });
                },
                name: 'message',
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          label = 'Write something...';
                          messageCount++;
                        });
                      }, //TODO: implement sendMessage(),
                      icon: const Icon(Icons.send)),

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
        ),
      ]),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const FaIcon(FontAwesomeIcons.solidMessage)
      // ),
    );
  }

  //****************************************************************************************
  //! Extracted Widgets...

  Column topContactInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.contactName.isEmpty ? widget.number : widget.contactName,
        ),
        Text(
          'Last seen ${widget.lastOnline}',
          style: GoogleFonts.roboto(fontSize: 15),
        ),
      ],
    );
  }

  //****************************************************************************************
}

class Message extends StatelessWidget {
  const Message({Key? key, required this.messageBody}) : super(key: key);

  final String messageBody;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.message,
        color: Colors.white,
      ),
      title: Text(messageBody,
          style: GoogleFonts.roboto(fontSize: 15, color: Colors.grey)),
    );
  }
}
