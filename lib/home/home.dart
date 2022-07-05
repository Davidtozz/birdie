// import 'dart:convert';
// import 'dart:io';
import 'dart:io';

import 'package:birdie/forms/login_form.dart';
import 'package:birdie/shared/globalcolors.dart';
import 'package:birdie/home/contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
import 'package:birdie/shared/avatar.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final screens = [
  //   const Contacts(),
  //   const Center(
  //     child: Text("ciao"),
  //   ),
  // ];

  late Future fetchData;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    fetchData = _getUserData();
  }

  Future<void> _getUserData() async {
    var url = 'https://birdie-api.herokuapp.com/api/users/${widget.username}';
    await http.get(Uri.parse(url));
  }

  int bottomNavigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData,
      builder: (context, snapshot) {
        return Scaffold(
            // systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent,

            drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.8,
            drawer: Drawer(
                width: MediaQuery.of(context).size.width * 0.8,
                elevation: 5.0,
                child: Stack(
                  children: [
                    Positioned.fill(
                      top: 0,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: UserCard(username: widget.username))),
                    Positioned.fill(
                        bottom: 0,
                        left: 0,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SvgPicture.asset(
                            'assets/images/profiledata.svg',
                            height: 170,
                          ),
                        )),
                    Positioned(
                      top: Platform.isWindows ? 235 : 190,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.8,
                          maxHeight: MediaQuery.of(context).size.height * 0.5,
                        ),
                        child: Column(
                          children: const[ AboutAppTile()],
                        ),
                      ),
                    ),
                  ],
                )),
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
            body: PageView(physics: const BouncingScrollPhysics(), children: [
              Contacts(userName: widget.username),
            ])

            //screens[bottomNavigationIndex],
            // bottomNavigationBar: NavigationBarTheme(
            //   data: const NavigationBarThemeData(
            //     height: 55,
            //     indicatorColor: Colors.white,
            //     backgroundColor: GlobalColors.purple,
            //   ),
            //   child: NavigationBar(
            //     labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            //     selectedIndex: bottomNavigationIndex,
            //     onDestinationSelected: (index) =>
            //         {setState(() => bottomNavigationIndex = index)},
            //     // backgroundColor: GlobalColors.black,
            //     destinations: const [
            //       NavigationDestination(
            //           icon: FaIcon(FontAwesomeIcons.users), label: "Contacts"),
            //       NavigationDestination(
            //           // TODO:
            //           icon: FaIcon(FontAwesomeIcons.userGroup),
            //           label: "View groups"),
            //     ],
            //   ),
            // ),
            );
      },
    );
  }
}

class AboutAppTile extends StatelessWidget {
  const AboutAppTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        dense: true,
        leading: const FaIcon(
          FontAwesomeIcons.circleInfo,
          size: 40,
          color: GlobalColors.purple,
        ),

        //  aboutBoxChildren: const[
        //    Text('This app is a prototype for a new social network.'),
        //  ],
        title: Text(
          'About this app',
          style: GoogleFonts.roboto(
              fontSize: 20,
              color: GlobalColors.purple,
              fontWeight: FontWeight.w500),
        ),
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => Dialog(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(children: [
                        Positioned(
                          top: 15,
                          left: 15,
                          child: SvgPicture.asset(
                            'assets/images/male_avatar.svg',
                            height: 100,
                          ),
                        ),
                        Positioned(
                          left: 125,
                          top: 20,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Birdie',
                                  style: GoogleFonts.roboto(
                                      fontSize: 35,
                                      color: GlobalColors.purple,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Version 1.0.0',
                                  style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      color: GlobalColors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '© 2022 davidtozz',
                                  style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.w500),
                                ),
                              ]),
                        ),
                        Positioned(
                          bottom: 70,
                          left: 15,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.3,
                            ),
                            child: Text(
                              'This app is a prototype of a new social media network.',
                              style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  color: GlobalColors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 15,
                            right: 15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Follow me on:',
                                    style: GoogleFonts.roboto(
                                        fontSize: 15,
                                        color: GlobalColors.black,
                                        fontWeight: FontWeight.w500)),
                                        const SizedBox(width: 15),
                                GestureDetector(
                                  onTap: () async {
                                    var url =
                                        'https://www.linkedin.com/in/davide-pulvirenti/';
                                    // await launchUrl(Uri.parse(url));

                                    if (await canLaunchUrl(Uri.parse(url)) ==
                                        true) {
                                      debugPrint('launching url');
                                      launchUrl(Uri.parse(url));
                                    } else {
                                      debugPrint('Could not launch $url');
                                    }
                                  },
                                  child: const FaIcon(
                                    FontAwesomeIcons.linkedin,
                                    color: Color(0xFF0A66C2),
                                    size: 35,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  child: const FaIcon(
                                    FontAwesomeIcons.github,
                                    size: 35,
                                  ),
                                ),
                              ],
                            ))
                      ]),
                    ),
                  ));

          // },
        });
  }
}

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.username,
  }) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.bottomToTop,
            child: const LogInForm(),
          ),
        );
      },
      child: Container(
        height: 220,
        width: double.infinity,
        color: GlobalColors.purple,
        child: Stack(
          children: [
            Positioned(
              bottom: 50,
              left: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Avatar(icon: FontAwesomeIcons.cameraRotate),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      username,
                      style: GoogleFonts.roboto(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),

                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  // borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text('Log Out',
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )),
                    ),
                    // const SizedBox(width: 5),
                    IconButton(
                      onPressed: () {
                        //Navigate to Login page
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                childCurrent: Home(username: username),
                                child: const LogInForm(),
                                type: PageTransitionType.topToBottomJoined));
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.rightToBracket,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
