import 'package:flutter/material.dart';
import 'package:birdie/home.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:birdie/introduction/form.dart' as form;

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
        description: "Birdie allows you to connect with people from all over the world!",
        pathImage: 'assets/images/world.svg'
      ),
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
        description: "You can start messaging with your friends and family right now! ",
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
                  height: 240.0
                  ),
                  
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
                        color: Color(0xFF6C63FF), fontSize: 25),
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
                      color: Color.fromARGB(255, 47, 46, 65),
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
    return IntroSlider(
      showNextBtn: true,
      showSkipBtn: false,
      backgroundColorAllSlides: const Color.fromARGB(255, 255, 255, 255),
      // renderSkipBtn: const Text("Skip"),
      renderDoneBtn: TextButton(
        child: const Icon(Icons.arrow_right_alt_outlined),
        // style: const ButtonStyle(backgroundColor:  Color(0xFF6C63FF)), 
        ////TODO: modificare colore DONE button
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const form.Form(),
          ),
        ),
      
      
     
      ),
      // Icon(Icons.done_outline_rounded, color: Color(0xFF6C63FF),),
      
      colorDot: const Color.fromARGB(255, 47, 46, 65),
      colorActiveDot: const Color(0xFF6C63FF),
      
      sizeDot: 8.0,
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
      listCustomTabs: renderListCustomTabs(),
      scrollPhysics: const BouncingScrollPhysics(),
      showDoneBtn: true,
      onDonePress: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomePage(),
        ),
      ),
    );
  }
}
