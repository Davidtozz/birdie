// import 'dart:convert';
// import 'dart:io';
import 'dart:io';
import 'package:birdie/globalcolors.dart';
import 'package:birdie/home/contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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
    dialogContactNameController.dispose();
    dialogContactNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      top: false,
      child: Scaffold(
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ProfilePicture(),

                          Text(
                            "John Doe",
                            style: GoogleFonts.roboto(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
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
      ),
    );
  }
}




class ProfilePicture extends StatefulWidget {
   ProfilePicture({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {

   File? profilePicture;

    Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      // final imageTemporary = File(image.path);
      final imagePermanent = await saveImagePermanently(image.path);
      setState(() => profilePicture = imagePermanent);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => pickImage(ImageSource.gallery),
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            radius: 65,
            child: profilePicture != null
                ? ClipOval(
                    child: Image.file(profilePicture as File,
                        width: 130, height: 130, fit: BoxFit.cover))
                : SvgPicture.asset(
                    'assets/images/profilepic.svg',
                    width: 130,
                    height: 130,
                  ),
          ),
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                onPressed: (() {}),
                icon: const FaIcon(
                  FontAwesomeIcons.cameraRotate,
                  size: 25,
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
