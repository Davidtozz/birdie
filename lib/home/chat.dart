import 'dart:convert';
import 'dart:io';

import 'package:birdie/globalcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Chat extends StatefulWidget {
  final String contactName, lastOnline;
  final String? number;
  //  pathToContactImage; //todo: implement pathToContactImage via DB or server

  const Chat(
      {Key? key,
      required this.contactName,
      required this.lastOnline,
      this.number})
      : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  void dispose() {
    // TODO: implement dispose
    bottomTextBoxController.dispose();
    super.dispose();
  }

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  String label = "Write something...";
  final defaultChatBackgrounds = [
    'assets/chat_bg/moonlight.png',
    'assets/chat_bg/purple_saturn.jpg',
    'assets/chat_bg/sunset.png',
  ];
  TextEditingController bottomTextBoxController = TextEditingController();
  String message = "";
  List<String> myMessages = [], receivedMessages = [];

  @override
  void initState() {
    // TODO: implement initState
    getMessagesFromAPI();
    super.initState();
  }

  //post message to server using http
  void postMessageToAPI(String msg) async {
    var url =
        'http://${Platform.isWindows ? 'localhost' : 'localhost'}:3000/messages'; // ! sostituire "localhost" con "localhost"
    var request = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          // 'number': widget.number,
          'message': msg,
        }));
  }

  Future<void> getMessagesFromAPI() async {
    var request = await http.get(Uri.parse(
        'http://localhost:3000/getmessages')); // ! sostituire "localhost" con "localhost"

    var response = json.decode(request.body);

    //for each message in response, add it to a list

    if (request.statusCode == 200) {
      for (var i = 0; i < response.length; i++) {
        setState(() {
          myMessages.add(response[i]['content']);
        });
      }

      debugPrint(myMessages.toString());
    } else {
      debugPrint("Error: ${request.statusCode}");
    }
  }

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
        //*****************************************************************************************
        Container(
          // ! Background image
          decoration: BoxDecoration(
            image: DecorationImage(
              isAntiAlias: true,
              image: AssetImage(defaultChatBackgrounds[0]),
              fit: BoxFit.cover,
            ),
          ),
        ),
        //*****************************************************************************************

        ListView.builder(
            shrinkWrap: true,
            reverse: false,
            itemBuilder: ((context, index) {
              return Message(
                // ? TODO: Before adding a message, check if it is a message from me or someone else
                messageBody: myMessages[index],
              );
            }),
            itemCount: myMessages.length + receivedMessages.length),
        //*****************************************************************************************

        // ! TextField per i messaggi

        //*****************************************************************************************
      ]),
      bottomSheet: FormBuilderTextField(
        focusNode: FocusNode(canRequestFocus: true),
        controller: bottomTextBoxController,
        onSubmitted: (value) {
          if (value!.isEmpty) {
            return;
          } else {
            postMessageToAPI(value);
            setState(() {
              label = "Write something...";

              message = value!;
              value = "";
              myMessages.add(message);
            });
          }
          bottomTextBoxController.clear();
        },
        key: _fbKey,
        name: 'message',
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          suffixIcon: IconButton(
              // ! Button to send message
              onPressed: () {
                if (bottomTextBoxController.text.isEmpty) {
                  return;
                } else {
                  myMessages.add(bottomTextBoxController.text);

                  setState(() {
                    label = 'Write something...';
                  });
                }
                postMessageToAPI(bottomTextBoxController.text);
                bottomTextBoxController.clear();
              }, //TODO: implement sendMessage(),
              icon: const Icon(Icons.send)),

          labelText: label,

          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          //  labelText: 'Type a message...',
          labelStyle: GoogleFonts.roboto(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
      ),
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
          widget.contactName,
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

  // factory Message.fromJson(Map<String, dynamic> json) => Message(
  //       messageBody: json['message'] as String,
  //     );

  final String messageBody;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(6.5, 0, 6.5, 0),
      child: ListTile(
        title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          LimitedBox(
            maxWidth: MediaQuery.of(context).size.width * 0.6,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                messageBody,
                // maxLines: null,
                style: GoogleFonts.roboto(fontSize: 17, color: Colors.black),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
