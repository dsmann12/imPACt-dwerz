import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:flutter/material.dart';
import 'package:impact/pages/root.dart';
import 'package:impact/pages/routes.dart';
import 'package:impact/pages/profile.dart';


class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  _IntroScreenState createState() {
    return _IntroScreenState();
  }
}


class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  bool newSignUp = false;

  void onDonePress() {
    // TODO: go to next screen
    this.newSignUp = true;
    Navigator.of(context).pushReplacement(FadePageRoute(
      builder: (context) => (newSignUp) ? ProfileEdit() : RootPage(),
    ));
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Colors.white,
    );
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.white,
      size: 35.0,
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Colors.white,
    );
  }

  @override
  void initState() {
    super.initState();


    slides.add(
      new Slide(
        title: "WELCOME",
        description: "Thank you for becoming a part of imPACt!",
        pathImage: "assets/Academic-Hat-Transparent-Background.png",
        backgroundColor: Colors.deepPurple,
      ),
    );
    slides.add(
      new Slide(
        title: "ABOUT",
        description: "Our mission is to have allows students to network with researchers and university faculty as mentees",
        pathImage: "assets/college-png-10.png",
        backgroundColor: Colors.deepPurple,
      ),
    );
    slides.add(
      new Slide(
        title: "GOOD LUCK",
        description: "Remember, network with as many mentors and mentees as you can so that you can gain and provide the needed experience in your preferred field.",
        pathImage: "assets/Hands.png",
        backgroundColor: Colors.deepPurple,
      ),
    );


    /*
    new DotsIndicator(
      decorator: DotsDecorator(
        color: Colors.white,
        activeColor: Colors.black38
      ),
    );
    */
  }


  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,

      /*
      onDonePress: this.onDonePress,
      colorDoneBtn: Colors.deepOrangeAccent,
      onSkipPress: this.onDonePress,
      colorSkipBtn: Colors.deepOrangeAccent,
      */

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      colorSkipBtn: Colors.deepPurple,
      highlightColorSkipBtn: Colors.deepPurple,

      // Next button
      renderNextBtn: this.renderNextBtn(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: Colors.deepPurple,
      highlightColorDoneBtn: Colors.deepPurple,

      // Dot indicator
      colorDot: Colors.white,
      colorActiveDot: Colors.black12,
      sizeDot: 13.0,

      // Show or hide status bar
      shouldHideStatusBar: true,
      backgroundColorAllSlides: Colors.grey,

    );
  }
  noSuchMethod(Invocation i) => super.noSuchMethod(i);
}
