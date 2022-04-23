import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(elevation: 5.0, 
      child:
       ListView(

        children: const[
          ListTile(title: Text("Account settings"),),
          Divider(height: 5.0, thickness: 2, indent: 7, endIndent: 7, color: Color.fromARGB(179, 72, 70, 70),),
          ListTile(title: Text("New Group"),),
          Divider(height: 5.0,),
          ListTile(title: Text("New Chat"),),
],



      ),),
      appBar: AppBar(
        // elevation: 2.5,
        actions: [
          IconButton(
            tooltip: 'Open settings',
              onPressed: () {
                print('pressed settings');
              },
              icon: const Icon(Icons.settings)),
        ],
        backgroundColor: const Color.fromARGB(171, 3, 117, 218),
        title: const Text("Home page title"),
      ),
      body: ListView(
        children: [
          ListTile(
            
            leading: const Icon(Icons.person),
            title: Text("Lorem ipsum dolor sit amet cw9w9ecw9wv",style: GoogleFonts.lato()),
            // style: ListTileStyle(), //TODO: add background color to list tile
            subtitle: const Text('last online: 10:00'),
            onTap: () {
              // Navigator.pushNamed(context, '/profile');
            },
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text("Lorem ipsum dolor sit amet cw9w9ecw9wv"),
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text("Lorem ipsum dolor sit amet cw9w9ecw9wv"),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.contacts_rounded), label: "Add new user"),
          NavigationDestination(icon: Icon(Icons.group_add_outlined), label: "View users"),
        ],
      ),
    );
  }
}
