import 'dart:math';

import 'package:impact/card_animation/card_detail.dart';
import 'package:flutter/material.dart';
import 'package:impact/models/user.dart';

Positioned cardDemo(
    User user,
    // DecorationImage img,
    double bottom,
    double right,
    double left,
    double cardWidth,
    double rotation,
    double skew,
    BuildContext context,
    Function dismissImg,
    int flag,
    Function addImg,
    Function swipeRight,
    Function swipeLeft) {
  Size screenSize = MediaQuery.of(context).size;
  // print("Card");
  return Positioned(
    bottom: bottom - 5,
    right: flag == 0 ? right != 0.0 ? right : null : null,
    left: flag == 1 ? right != 0.0 ? right : null : null,
    child: Dismissible(
      key: Key(Random().toString()),
      crossAxisEndOffset: -0.3,
      onResize: () {
        //print("here");
        // setState(() {
        //   var i = data.removeLast();

        //   data.insert(0, i);
        // });
      },
      onDismissed: (DismissDirection direction) {
//          _swipeAnimation();
        if (direction == DismissDirection.endToStart)
          // dismissImg(img);
          dismissImg(user);
        else
          // addImg(img);
          addImg(user);
      },
      child: Transform(
        alignment: flag == 0 ? Alignment.bottomRight : Alignment.bottomLeft,
        //transform: null,
        transform: Matrix4.skewX(skew),
        //..rotateX(-math.pi / rotation),
        child: RotationTransition(
          turns: AlwaysStoppedAnimation(
              flag == 0 ? rotation / 360 : -rotation / 360),
          child: Hero(
            tag: "Mentor",
            child: GestureDetector(
              onTap: () {
                // Navigator.push(
                //     context,
                //     new MaterialPageRoute(
                //         builder: (context) => new DetailPage(type: img)));
                Navigator.of(context).push(new PageRouteBuilder(
                  // pageBuilder: (_, __, ___) => new DetailPage(type: img),
                  pageBuilder: (_, __, ___) => new DetailPage(user: user),
                ));
              },
              child: Card(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 4.0,
                child: Container(
                  alignment: Alignment.center,
                  width: screenSize.width / 1.05,
                  height: screenSize.height / 1.6,
                  decoration: BoxDecoration(
                    // color: Color.fromRGBO(121, 114, 173, 1.0),
                    color: Colors.deepPurple[400],
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        width: screenSize.width / 1.05,
                        height: screenSize.height / 2.2,
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.only(
                              topLeft: new Radius.circular(10.0),
                              topRight: new Radius.circular(10.0)),
                          // image: img,
                          image: DecorationImage(image: NetworkImage(user.avatarURL), fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 35, top: 10, bottom: 10),
                        width: screenSize.width / 1.05,
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget> [
                            Text("${user.firstName} ${user.lastName}", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                            Text(user.institution, style: TextStyle(color: Colors.white, fontSize: 16),),
                            Text(user.department, style: TextStyle(color: Colors.white, fontSize: 16),),
                          ]
                        )
                      ),
                      new Container(
                          width: screenSize.width / 1.05,
                          height:
                          screenSize.height / 1.6 - screenSize.height / 1.7,
                          alignment: Alignment.center,
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new FlatButton(
                                  padding: new EdgeInsets.all(0.0),
                                  onPressed: () {
                                    swipeLeft();
                                  },
                                  child: new Container(
                                    height: 60.0,
                                    width: 130.0,
                                    alignment: Alignment.center,
                                    decoration: new BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                      new BorderRadius.circular(60.0),
                                    ),
                                    child: new Text(
                                      "Dismiss",
                                      style: new TextStyle(color: Colors.white),
                                    ),
                                  )),
                              new FlatButton(
                                  padding: new EdgeInsets.all(0.0),
                                  onPressed: () {
                                    swipeRight();
                                  },
                                  child: new Container(
                                    height: 60.0,
                                    width: 130.0,
                                    alignment: Alignment.center,
                                    decoration: new BoxDecoration(
                                      color: Colors.greenAccent[700],
                                      borderRadius:
                                      new BorderRadius.circular(60.0),
                                    ),
                                    child: new Text(
                                      "Send Request",
                                      style: new TextStyle(color: Colors.white),
                                    ),
                                  ))
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}