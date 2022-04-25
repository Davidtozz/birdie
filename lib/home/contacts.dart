import 'package:birdie/globalcolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'chat.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {

  String contactName = ""; //todo: retrieve info from DB
  String number = ""; //todo: retrieve info from DB
  double lastOnline = 0.0; //todo: retrieve info from DB
  
  


  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      interactive: true,
      child: ListView(
        children: [


          ListTile(
            leading: CircleAvatar(
              backgroundColor: GlobalColors.purple,
              child: Text('C', textAlign: TextAlign.center,  style: GoogleFonts.roboto(color: Colors.white, fontSize: 20, )),
            ),
            // const Icon(Icons.person, color: GlobalColors.purple),
            title: Text("Cuncettu", style: GoogleFonts.roboto()),
            //TODO: add background color to list tile
            subtitle: const Text('last online: 10:00'),
            onTap: () {
             Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Chat(
                    contactName: 'Cuncettu',
                    number: '+39 452 654 789', //todo: get number from database or server
                    lastOnline: 10.24,
                    // isOnline: true, //todo: implement isOnline validation from DB or from server
                    // contactImage: 'assets/images/profile_pic.jpg',
                  ),
                ),
              );
            },
          ),



           ListTile(
            leading: CircleAvatar(
              backgroundColor: GlobalColors.purple,
              child: Text('G', textAlign: TextAlign.center,  style: GoogleFonts.roboto(color: Colors.white, fontSize: 20, )),
            ),
            // const Icon(Icons.person, color: GlobalColors.purple),
            title: Text("Giuanni", style: GoogleFonts.roboto()),
            //TODO: add background color to list tile
            subtitle: const Text('last online: 10:00'),
            onTap: () {
              //navigate to chat.dart
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Chat(
                    contactName: 'A',
                    number: '+39 452 654 789', //todo: get number from database or server
                    lastOnline: 10.24,
                    // isOnline: true, //todo: implement isOnline validation from DB or from server
                    // contactImage: 'assets/images/profile_pic.jpg', //todo: get image from DB or server
                  ),
                ),
              );

            },
          ),
           ListTile(
            leading: CircleAvatar(
              backgroundColor: GlobalColors.purple,
              child: Text('A', textAlign: TextAlign.center,  style: GoogleFonts.roboto(color: Colors.white, fontSize: 20, )),
            ),
            // const Icon(Icons.person, color: GlobalColors.purple),
            title: Text("+39 452 654 789", style: GoogleFonts.roboto()),
            //TODO: add background color to list tile
            subtitle: const Text('last online: 10:00'),
            onTap: () {
              // Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
    );
  }
}
