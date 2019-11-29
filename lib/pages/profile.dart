import 'package:flutter/material.dart';
import 'package:impact/pages/login.dart';
import 'package:impact/services/authentication.dart';
import 'package:impact/pages/routes.dart';
import 'package:impact/models/user.dart';


class PersonalProfile extends StatefulWidget {
  @override
  _PersonalProfileState createState() => new _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {

  User user = AuthService.getCurrentUser();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
          children: <Widget>[
            ClipPath(
              child: Container(color: Colors.black.withOpacity(1)),
              clipper: getClipper(),
            ),
            Positioned(
                width: 350.0,
                top: MediaQuery.of(context).size.height / 5,
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/profile_placeholder.png'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.black)
                            ])),
                    SizedBox(height: 50.0),
                    Column(
                      children: <Widget>[
                        Text(
                          user.firstName + " " + user.lastName,
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                        //SizedBox(height: 15.0),
                        Chip(backgroundColor: Colors.blue, label: Text("Mentee"),),

                        Text(
                          user.institution,
                          style: TextStyle(
                              fontSize: 15.0,
//                          fontStyle: FontStyle.italic,
                              fontFamily: 'Montserrat'),
                        ),
                        //SizedBox(height: 5.0),

                        Text(
                          user.major,
                          style: TextStyle(
                              fontSize: 15.0,
//                          fontStyle: FontStyle.italic,
                              fontFamily: 'Montserrat'),
                        ),

                        Text(
                          user.college,
                          style: TextStyle(
                              fontSize: 15.0,
//                          fontStyle: FontStyle.italic,
                              fontFamily: 'Montserrat'),
                        ),

                        Text(
                          user.department.toString(),
                          style: TextStyle(
                              fontSize: 15.0,
//                          fontStyle: FontStyle.italic,
                              fontFamily: 'Montserrat'),
                        ),

//                        Text(
//                          'Research Interest(s): '
//                              'Software Development, '
//                              ' Mobile Application Development, '
//                              ' Web Application Development, '
//                              ' Mobile and Web Security ',
//                          style: TextStyle(
//                              fontSize: 15.0,
////                          fontStyle: FontStyle.italic,
//                              fontFamily: 'Montserrat'),
//                        ),
                      ],
                    ),
//                    Text(
//                      'Zheng Ye',
//                      style: TextStyle(
//                          fontSize: 30.0,
//                          fontWeight: FontWeight.bold,
//                          fontFamily: 'Montserrat'),
//                    ),
//                    //SizedBox(height: 15.0),
//                    Chip(backgroundColor: Colors.blue, label: Text("Mentee"),),
//
//                    Text(
//                      'Institution: Lousiana State University',
//                      style: TextStyle(
//                          fontSize: 15.0,
////                          fontStyle: FontStyle.italic,
//                          fontFamily: 'Montserrat'),
//                    ),
//                    //SizedBox(height: 5.0),
//
//                    Text(
//                      'Major: Computer Science',
//                      style: TextStyle(
//                          fontSize: 15.0,
////                          fontStyle: FontStyle.italic,
//                          fontFamily: 'Montserrat'),
//                    ),
//
//                    Text(
//                      'College: College of Engineering',
//                      style: TextStyle(
//                          fontSize: 15.0,
////                          fontStyle: FontStyle.italic,
//                          fontFamily: 'Montserrat'),
//                    ),
//
//                    Text(
//                      'Department: Computer Science',
//                      style: TextStyle(
//                          fontSize: 15.0,
////                          fontStyle: FontStyle.italic,
//                          fontFamily: 'Montserrat'),
//                    ),
//
//                    Text(
//                      'Research Interest(s): '
//                          'Software Development, '
//                          ' Mobile Application Development, '
//                          ' Web Application Development, '
//                          ' Mobile and Web Security ',
//                      style: TextStyle(
//                          fontSize: 15.0,
////                          fontStyle: FontStyle.italic,
//                          fontFamily: 'Montserrat'),
//                    ),
                    //SizedBox(height: 2.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.edit),
                          tooltip: 'Tap to edit profile',
                          onPressed: () {

                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.power_settings_new),
                          tooltip: 'Tap to logout',
                          onPressed: () {
                            AuthService.signOut();
                            Navigator.of(context).pushReplacement(FadePageRoute(
                                builder: (context) => LoginScreen()
                            ));
                          },
                        ),
                      ],
                    ),
//                    Container(
//                        height: 30.0,
//                        width: 95.0,
//                        child: Material(
//                          borderRadius: BorderRadius.circular(20.0),
//                          shadowColor: Colors.greenAccent,
//                          color: Colors.green,
//                          elevation: 7.0,
//                          child: GestureDetector(
//                            onTap: () {},
//                            child: Center(
//                              child: Text(
//                                'Edit Name',
//                                style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
//                              ),
//                            ),
//                          ),
//                        )),
                    SizedBox(height: 25.0),
//                    Container(
//                        height: 30.0,
//                        width: 95.0,
//                        child: Material(
//                          borderRadius: BorderRadius.circular(20.0),
//                          shadowColor: Colors.redAccent,
//                          color: Colors.red,
//                          elevation: 7.0,
//                          child: GestureDetector(
//                            onTap: () {},
//                            child: Center(
//                              child: Text(
//                                'Log out',
//                                style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
//                              ),
//                            ),
//                          ),
//                        ))
                  ],
                ))
          ],
        ));
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height/ 3.05);
    path.lineTo(size.height + 15000, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}