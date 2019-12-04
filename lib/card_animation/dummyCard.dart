import 'package:flutter/material.dart';
import 'package:impact/models/user.dart';

Positioned cardDemoDummy(
    User user,
    // DecorationImage img,
    double bottom,
    double right,
    double left,
    double cardWidth,
    double rotation,
    double skew,
    BuildContext context) {
  Size screenSize = MediaQuery.of(context).size;
  
  return new Positioned(
    bottom: bottom + 15,
    child: new Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4.0,
      child: new Container(
        alignment: Alignment.center,
        width: screenSize.width / 1.05,
        height: screenSize.height / 1.6,
        decoration: new BoxDecoration(
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
                height: screenSize.height / 1.6 - screenSize.height / 1.7,
                alignment: Alignment.center,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new FlatButton(
                        padding: new EdgeInsets.all(0.0),
                        onPressed: () {},
                        child: new Container(
                          height: 60.0,
                          width: 130.0,
                          alignment: Alignment.center,
                          decoration: new BoxDecoration(
                            color: Colors.red,
                            borderRadius: new BorderRadius.circular(60.0),
                          ),
                          child: new Text(
                            "Dismiss",
                            style: new TextStyle(color: Colors.white),
                          ),
                        )),
                    new FlatButton(
                        padding: new EdgeInsets.all(0.0),
                        onPressed: () {},
                        child: new Container(
                          height: 60.0,
                          width: 130.0,
                          alignment: Alignment.center,
                          decoration: new BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: new BorderRadius.circular(60.0),
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
  );
}