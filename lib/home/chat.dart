import 'dart:convert';
import 'package:birdie/shared/globalcolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:loading_indicator/loading_indicator.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Chat extends StatefulWidget {
  final String contactName, userName;
  final String? number, lastOnline;
  //  pathToContactImage; //todo: implement pathToContactImage via DB or server

  const Chat(
      {Key? key,
      required this.contactName,
      required this.userName,
      this.lastOnline,
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

  String label = "Write something...";
  // final defaultChatBackgrounds = [
  //   'assets/chat_bg/moonlight.png',
  //   'assets/chat_bg/purple_saturn.jpg',
  //   'assets/chat_bg/sunset.png',
  // ];
  var bottomTextBoxController = TextEditingController();

  List<String> myMessages = [],
      receivedMessages = []; //TODO implement SOCKET IO to get messages

  late Future fetchMessages;

  @override
  void initState() {
    // TODO: implement initState
    fetchMessages = getMessagesFromAPI();
    getMessagesFromAPI();
    super.initState();
  }

  //post message to server using http
  void postMessageToAPI(String msg) async {
    var url =
        // 'localhost:5000/api/postmessages';
        'https://birdie-auth-testing.herokuapp.com/api/users/${widget.userName}/${widget.contactName}/message'; // ! API HEROKU URL
    await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          // 'number': widget.number,
          'message': msg,
        }));
  }

  Future<void> getMessagesFromAPI() async {
    var request = await http.get(Uri.parse(
        // 'https//localhost:5000/api/getmessages',
        'https://birdie-auth-testing.herokuapp.com/api/users/${widget.userName}/${widget.contactName}/messages')); // ! sostituire "localhost" con "localhost"

    var response = json.decode(request.body);

    //for each message in response, add it to a list

    if (request.statusCode == 200) {
      setState(() {
        for (var i = 0; i < response.length; i++) {
          myMessages.add(response[i]['content']);
        }
      });

      debugPrint(myMessages.toString());
    } else {
      debugPrint("Error: ${request.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: GlobalColors.purple,
        elevation: 5.0,
        // backgroundColor: GlobalColors.purple,
        title: Column(
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
        ),
      ),
      body: FutureBuilder(
        future: fetchMessages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                width: 150,
                height: 150,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballClipRotateMultiple,
                  colors: [GlobalColors.purple],
                  strokeWidth: 5.0,
                  // backgroundColor: GlobalColors.purple,
                ),
              ),
            );
          } else {
            return Stack(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  shrinkWrap: true,
                  reverse: false,
                  itemBuilder: ((context, index) {
                    return Message(
                      messageBody: myMessages[index],
                      isSender: true,
                    );
                  }),
                  itemCount: myMessages.length + receivedMessages.length),
            ),
            Positioned(
              bottom: 15,
              left: 15,
              right: 15,
              child: PhysicalModel(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black,
                elevation: 5.0,
                child: TextField(
                  // focusNode: FocusNode(canRequestFocus: true),
                  controller: bottomTextBoxController,
                  onSubmitted: (value) {
                    if (value.isEmpty) {
                      return;
                    } else {
                      setState(() {
                        label = "Write something...";
                        myMessages.add(value);
                        postMessageToAPI(value);
                        value = "";
                      });
                    }
                    bottomTextBoxController.clear();
                  },
                  // key: _fbKey,

                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    suffixIcon: IconButton(
                        // ! Button to send message
                        onPressed: () {
                          setState(() {
                            myMessages.add(bottomTextBoxController.text);
                            label = 'Write something...';
                            postMessageToAPI(bottomTextBoxController.text);
                            bottomTextBoxController.clear();
                          });
                        }, //TODO: implement sendMessage(),
                        icon: const Icon(Icons.send)),

                    labelText: label,

                    filled: true,
                    fillColor: Colors.grey[300],
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
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
            )
          ]);
          }
          
        },
      ),
    );
  }
}

class Message extends StatelessWidget {
  const Message({Key? key, required this.messageBody, required this.isSender})
      : super(key: key);

  // factory Message.fromJson(Map<String, dynamic> json) => Message(
  //       messageBody: json['message'] as String,
  //     );

  final String messageBody;
  final bool isSender;
  @override
  Widget build(BuildContext context) {
    if (isSender == true) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(right: 10, top: 5),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Text(
              messageBody,
              style: GoogleFonts.roboto(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    } else {
      return Row(
        // ! Row for received messages
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(left: 10),
            decoration: const BoxDecoration(
              color: GlobalColors.purple,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Text(
              messageBody,
              style: GoogleFonts.roboto(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    }
  }
}
