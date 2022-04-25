import 'package:birdie/globalcolors.dart';
import 'package:birdie/home/contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int bottomNavigationIndex = 0;

  @override
  void initState() {
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const Contacts(),
      const Center(child: Text("ciao"),
      ),
     
    ];

    return Scaffold(
      drawer: Drawer(
        elevation: 5.0,
        child: ListView(
          
          children: const [
            ListTile(
              title: Text("Account settings"),
              
            ),
            // Divider(
            //   height: 5.0,
            //   thickness: 2,
            //   indent: 7,
            //   endIndent: 7,
            //   color: Color.fromARGB(179, 72, 70, 70),
            // ),
            ListTile(
              title: Text("New Group"),
            ),
            Divider(
              height: 5.0,
            ),
            ListTile(
              title: Text("New Chat"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        // elevation: 2.5,
        backgroundColor: GlobalColors.purple,
        title: Text(
          "Birdie",
          style: GoogleFonts.roboto(),
        ),
      ),
      body: screens[bottomNavigationIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
          height: 55,
          indicatorColor: Colors.white,
          backgroundColor: GlobalColors.purple,
        ),
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: bottomNavigationIndex,
          onDestinationSelected: (index) =>
              {setState(() => bottomNavigationIndex = index)},

          // backgroundColor: GlobalColors.black,
          destinations: const [

            NavigationDestination(
                icon: FaIcon(
                  FontAwesomeIcons.userGroup), 
                  label: "Contacts"),
           
            NavigationDestination( // TODO: 
                icon: FaIcon(FontAwesomeIcons.userGroup), label: "View groups"),
          
          ],
        ),
      ),
    );
  }
}