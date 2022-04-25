import 'package:birdie/globalcolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      interactive: true,
      child: ListView(
        children: [
          ListTile(
            leading: const Icon(
              Icons.person,
              color: GlobalColors.purple,),
            title: Text("+39 452 654 789", style: GoogleFonts.lato()),
            // style: ListTileStyle(), //TODO: add background color to list tile
            subtitle: const Text('last online: 10:00'),
            onTap: () {
              // Navigator.pushNamed(context, '/profile');
            },
          ),
          const ListTile(
            leading: Icon(Icons.person_outline_outlined),
            title: Text("Lorem ipsum dolor sit amet cw9w9ecw9wv"),
          ),
          const ListTile(
            leading: Icon(Icons.person_outline_outlined),
            title: Text("Lorem ipsum dolor sit amet cw9w9ecw9wv"),
          ),
        ],
      ),
    );
  }
}
