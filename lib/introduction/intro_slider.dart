import 'package:birdie/providers/user_provider.dart';
import 'package:birdie/shared/globalcolors.dart';
import 'package:flutter/material.dart';
import 'package:birdie/home/home.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:birdie/forms/signup_form.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class IntroSliderPage extends StatefulWidget {
  @override
  _IntroSliderPageState createState() => _IntroSliderPageState();
}

class _IntroSliderPageState extends State<IntroSliderPage> {
  final List<Slide> slides = [];

  @override
  void initState() {
    super.initState();
    slides.add(
      Slide(
          title: "The world in your hands",
          description:
              "Birdie allows you to connect with people from all over the world!",
          pathImage: 'assets/images/world.svg'),
    );

    slides.add(
      Slide(
        title: "Powerful security",
        description: "Your messages are so fast nobody is able to catch them!",
        pathImage: "assets/images/security.svg",
      ),
    );

    slides.add(
      Slide(
        title: "Start messaging!",
        description:
            "You can start messaging with your friends and family right now! ",
        pathImage: "assets/images/startmessaging.svg",
      ),
    );
    // slides.add(
    //   Slide(
    //     title: "World Travel",
    //     description: "Book tickets of any transportation and travel the world!",
    //     pathImage: "assets/images/travel.png",
    //   ),
    // );
  }

  List<Widget> renderListCustomTabs() {
    final List<Widget> tabs = [];
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(
        SizedBox(
          child: Container(
            margin: const EdgeInsets.only(bottom: 160, top: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(13),
                  // decoration: const BoxDecoration(
                  //   shape: BoxShape.circle,
                  //   color: Color.fromARGB(252, 127, 91, 244),
                  // ),
                  child: SvgPicture.asset(currentSlide.pathImage.toString(),
                      height: 240.0),

                  // Image.asset(
                  //   currentSlide.pathImage.toString(),
                  //   matchTextDirection: true,
                  //   height: 240,
                  // ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    currentSlide.title.toString(),
                    style: const TextStyle(
                        color: GlobalColors.purple, fontSize: 25),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  margin: const EdgeInsets.only(
                    top: 15,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    currentSlide.description.toString(),
                    style: const TextStyle(
                      color: GlobalColors.black,
                      fontSize: 19,
                      height: 1.5,
                    ),
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      )
      ),








      body: IntroSlider(
        renderNextBtn: const Padding(
          padding:  EdgeInsets.only(top: 2.5, bottom: 2.5),
          child:  FaIcon(FontAwesomeIcons.arrowRight, color: Colors.white,),
        ),
        showNextBtn: true,
        showSkipBtn: false,
        backgroundColorAllSlides: const Color.fromARGB(255, 255, 255, 255),
        // renderSkipBtn: const Text("Skip"),
        renderDoneBtn: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: GlobalColors.purple , 
            surfaceTintColor:  Colors.white,
          ),
          child: const Padding(
            padding:  EdgeInsets.symmetric(vertical: 2.7),
            child: FaIcon(FontAwesomeIcons.check),
          ),
          // style: const ButtonStyle(backgroundColor:  GlobalColors.purple),
          ////TODO: modificare colore DONE button
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const SignUpForm(),
            ),
          ),
        ),
        // Icon(Icons.done_outline_rounded, color: GlobalColors.purple,),
        // renderNextBtn: const Icon(FontAwesomeIcons.arrowRight, color: Colors.black,), 
           
        colorDot: GlobalColors.black,
        colorActiveDot: GlobalColors.purple,
        nextButtonStyle: ElevatedButton.styleFrom(
          
          primary: GlobalColors.purple,
          elevation: 0,

        ),
        sizeDot: 8.0,
        typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
        listCustomTabs: renderListCustomTabs(),
        scrollPhysics: const BouncingScrollPhysics(),
        showDoneBtn: true,
        onDonePress: () => Navigator.pushReplacement(
          context,
          PageTransition(
            duration: const Duration(milliseconds: 300),
            childCurrent: IntroSliderPage(),
            type: PageTransitionType.rightToLeftJoined,

            child: const SignUpForm(),
          ),
        ),
      ),
    );
  }
}
