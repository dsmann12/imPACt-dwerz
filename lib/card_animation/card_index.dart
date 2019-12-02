import 'dart:async';
import 'package:impact/card_animation/card_data.dart';
import 'package:impact/card_animation/dummyCard.dart';
import 'package:impact/card_animation/currentCard.dart';

//import 'package:animation_exp/PageReveal/page_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:impact/models/user.dart';
import 'package:impact/models/request.dart';
import 'package:impact/services/authentication.dart';
import 'package:impact/services/user_service.dart';
import 'package:impact/services/request_service.dart';
import 'package:impact/pages/requests.dart';

class CardDemo extends StatefulWidget {
  @override
  CardDemoState createState() => new CardDemoState();
}

class CardDemoState extends State<CardDemo> with TickerProviderStateMixin {
  AnimationController _buttonController;
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;
  Animation<double> width;
  int flag = 0;
  User currentUser = AuthService.getCurrentUser();
  List<User> mentors;
  List data = imageData;
  List selectedData = [];
  void initState() {
    super.initState();
    UserService.getMentors().then((users) {
      setState(() {
        mentors = users;
      });
    });

    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

    rotate = new Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    rotate.addListener(() {
      setState(() {
        if (rotate.isCompleted) {
          // var i = data.removeLast();
          var i = mentors.removeLast();
          // data.insert(0, i);
          mentors.insert(0, i);

          _buttonController.reset();
        }
      });
    });

    right = new Tween<double>(
      begin: 0.0,
      end: 400.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    bottom = new Tween<double>(
      begin: 15.0,
      end: 100.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.ease,
      ),
    );
    width = new Tween<double>(
      begin: 20.0,
      end: 25.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  Future<Null> _swipeAnimation() async {
    try {
      await _buttonController.forward();
    } on TickerCanceled {}
  }

  // dismissImg(DecorationImage img) {
  dismissImg(User user) {
    setState(() {
      // data.remove(img);
      mentors.remove(user);
    });
  }

  // addImg(DecorationImage img) {
  addImg(User user) {
    setState(() {
      // data.remove(img);
      mentors.remove(user);
      // selectedData.add(img);
      selectedData.add(user);
      Request request = Request(mentee: currentUser, mentor: user);
      RequestService.submitRequest(request);
    });
  }

  swipeRight() {
    if (flag == 0)
      setState(() {
        flag = 1;
      });
    _swipeAnimation();
  }

  swipeLeft() {
    if (flag == 1)
      setState(() {
        flag = 0;
      });
    _swipeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;

    double initialBottom = 10.0;
    var dataLength = (mentors == null) ? 0 : mentors.length;
    double backCardPosition = initialBottom + (dataLength - 1) * 10 + 10;
    double backCardWidth = -10.0;

    return (mentors == null) ? Center(child: CircularProgressIndicator(),) : Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          // backgroundColor: new Color.fromRGBO(106, 94, 175, 1.0),
          backgroundColor: Colors.white,
          centerTitle: true,
         leading: new Container(
           margin: const EdgeInsets.only(bottom: 23, top: 5, left: 15, right: 15),
           child: new IconButton(
             icon: Icon(
              Icons.contact_mail,
              color: Colors.black,
              size: 30.0,
            ),
            onPressed: () => Navigator.of(context).push(new MaterialPageRoute(builder: (context) => RequestsPage())),
           ),
         ),
         actions: <Widget>[
           new GestureDetector(
             onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (context) => RequestsPage())),
             child: new Container(
                 margin: const EdgeInsets.all(15.0),
                 child: new Icon(
                   Icons.search,
                   color: Colors.black,
                   size: 30.0,
                 )),
           ),
         ],
          title: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "Mentors",
                style: new TextStyle(
                    fontSize: 16.0,
                    // letterSpacing: 3.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              // new Container(
              //   width: 15.0,
              //   height: 15.0,
              //   margin: new EdgeInsets.only(bottom: 20.0),
              //   alignment: Alignment.center,
              //   child: new Text(
              //     dataLength.toString(),
              //     style: new TextStyle(fontSize: 10.0),
              //   ),
              //   decoration: new BoxDecoration(
              //       color: Colors.red, shape: BoxShape.circle),
              // )
            ],
          ),
        ),
        body: new Container(
          // color: new Color.fromRGBO(106, 94, 175, 1.0),
          color: Colors.white,
          alignment: Alignment.center,
          child: ((mentors != null) && (mentors.length > 0))
              ? new Stack(
              alignment: AlignmentDirectional.center,
              children: (mentors == null) ? <Widget>[Center(child: CircularProgressIndicator(),)] : mentors.map((item) {
                // if (data.indexOf(item) == dataLength - 1) {
                if (mentors.indexOf(item) == mentors.length - 1) {
                  return cardDemo(
                      item,
                      bottom.value,
                      right.value,
                      0.0,
                      backCardWidth + 10,
                      rotate.value,
                      rotate.value < -10 ? 0.1 : 0.0,
                      context,
                      dismissImg,
                      flag,
                      addImg,
                      swipeRight,
                      swipeLeft);
                } else {
                  backCardPosition = backCardPosition - 10;
                  backCardWidth = backCardWidth + 10;

                  return cardDemoDummy(item, backCardPosition, 0.0, 0.0,
                      backCardWidth, 0.0, 0.0, context);
                }
              }).toList())
              : new Text("No Mentors Left to Swipe!",
              style: new TextStyle(color: Colors.black, fontSize: 25)),
        )
      );
  }
}