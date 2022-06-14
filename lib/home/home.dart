import 'dart:convert';
import 'dart:io';
import 'package:birdie/globalcolors.dart';
import 'package:birdie/home/contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final screens = [
    const Contacts(),
    const Center(
      child: Text("ciao"),
    ),
  ];

  TextEditingController dialogContactNameController = TextEditingController(),
      dialogContactNumberController = TextEditingController();

  int bottomNavigationIndex = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    dialogContactNameController.dispose();
    dialogContactNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent,
      
      drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.3,
      drawer: Drawer(
        elevation: 5.0,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    height: 220,
                    color: GlobalColors.purple,
                    child: Row(
                      children:  [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 65,
                            child: SvgPicture.asset('assets/images/profilepic.svg', width: 130, height: 130,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  for (int i = 0; i < 5; i++)
                    ListTile(
                      dense: true,
                      subtitle: Text(
                        'Modify your profile settings',
                        style: GoogleFonts.roboto(
                            fontSize: 14, color: Colors.grey),
                      ),

                      leading: const FaIcon(FontAwesomeIcons.userLarge,
                          color: GlobalColors.purple, size: 30),
                      title: Text(
                        'Profile',
                        style: GoogleFonts.lato(fontSize: 20),
                      ),
                      // trailing: FaIcon(FontAwesomeIcons.arrowRight, color: GlobalColors.purple, size: 20,),
                    ),
                ]),
              ),
              // SizedBox(height: 150,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  'assets/images/profiledata.svg',
                  height: 170,
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
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
                icon: FaIcon(FontAwesomeIcons.users), label: "Contacts"),
            NavigationDestination(
                // TODO:
                icon: FaIcon(FontAwesomeIcons.userGroup),
                label: "View groups"),
          ],
        ),
      ),
    );
  }
}
