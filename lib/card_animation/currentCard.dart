import 'dart:math';

import 'package:impact/card_animation/card_detail.dart';
import 'package:flutter/material.dart';
import 'package:impact/models/user.dart';

Positioned cardDemo(
    User user,
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
  return Positioned(
    bottom: bottom + 10,
    right: flag == 0 ? right != 0.0 ? right : null : null,
    left: flag == 1 ? right != 0.0 ? right : null : null,
    child: Dismissible(
      key: Key(Random().toString()),
      crossAxisEndOffset: -0.3,
      onResize: () {
      },
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart)
          dismissImg(user);
        else
          addImg(user);
      },
      child: Transform(
        alignment: flag == 0 ? Alignment.bottomRight : Alignment.bottomLeft,
        transform: Matrix4.skewX(skew),
        child: RotationTransition(
          turns: AlwaysStoppedAnimation(
              flag == 0 ? rotation / 360 : -rotation / 360),
          child: Hero(
            tag: "Mentor",
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(new PageRouteBuilder(
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
                    color: Colors.grey[100],
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
                          image: DecorationImage(image: NetworkImage(user.avatarURL), fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: (screenSize.width / 1.05) * 0.05, right: (screenSize.width / 1.05) * 0.05, top: 10, bottom: 10),
                        width: screenSize.width / 1.05,
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget> [
                            Text("${user.firstName} ${user.lastName}", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                            Text(user.institution, style: TextStyle(color: Colors.black, fontSize: 16),),
                            Text(user.department, style: TextStyle(color: Colors.black, fontSize: 16),),
                          ]
                        )
                      ),
                      new Container(
                          padding: EdgeInsets.symmetric(horizontal: (screenSize.width / 1.05) * 0.05),
                          width: screenSize.width / 1.05,
                          height:
                          screenSize.height / 1.6 - screenSize.height / 1.7,
                          alignment: Alignment.center,
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      color: Colors.deepPurple,
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