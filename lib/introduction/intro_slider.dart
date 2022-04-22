import 'package:flutter/material.dart';
import 'package:birdie/home.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class IntroSliderPage extends StatefulWidget {
  @override
  _IntroSliderPageState createState() => _IntroSliderPageState();
}

class _IntroSliderPageState extends State<IntroSliderPage> {
  final List<Slide> slides = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slides.add(
      Slide(
        title: "Birdie",
        description:
            "Reach friends and family with Birdie, fast and easy!",
        pathImage: "assets/images/svg/sms.svg",
      ),
    );

    // slides.add(
    //   Slide(
    //     title: "Encrypted messages",
    //     description: "Birds are not afraid of the dark, they are afraid of you!",
    //     pathImage: "assets/images/movie.png",
    //   ),
    // );


    // slides.add(
    //   Slide(
    //     title: "Great Discounts",
    //     description: "Best discounts on every single service we offer!",
    //     pathImage: "assets/images/discount.png",
    //   ),
    // );
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
                  padding: const EdgeInsets.all(20),
                  // decoration: const BoxDecoration(
                  //   shape: BoxShape.circle,
                  //   color: Color.fromARGB(255, 237, 3, 3),
                  // ),
                  child: Image.asset(
                    currentSlide.pathImage.toString(),
                    matchTextDirection: true,
                    height: 60,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    currentSlide.title.toString(),
                    style: const TextStyle(color: Color.fromARGB(255, 77, 13, 181), fontSize: 25),
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
                      color: Color.fromARGB(255, 77, 13, 181),
                      fontSize: 14,
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
      showNextBtn: false,
      backgroundColorAllSlides: const Color.fromARGB(255, 255, 255, 255),
      renderSkipBtn: const Text("Skip"),
 
      renderDoneBtn: Text(
        "Done",
        style: TextStyle(color: Colors.green[700]),
      ),
      colorDot: const Color.fromARGB(210, 112, 112, 112),
      colorActiveDot: const Color.fromARGB(255, 0, 0, 0),
      sizeDot: 8.0,
      typeDotAnimation: dotSliderAnimation.DOT_MOVEMENT,
      listCustomTabs: renderListCustomTabs(),
      scrollPhysics: const BouncingScrollPhysics(),
      showDoneBtn: true,
      
      onDonePress: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomePage(),
        ),
      ),
    );
  }
}