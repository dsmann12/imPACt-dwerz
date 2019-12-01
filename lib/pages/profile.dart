import 'package:flutter/material.dart';
import 'package:impact/pages/login.dart';
import 'package:impact/services/authentication.dart';
import 'package:impact/pages/routes.dart';
import 'package:impact/models/user.dart';
import 'package:impact/services/user_service.dart';


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
                            Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                              return new ProfileEdit();
                              }));
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

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEdit createState() => _ProfileEdit();
}
class _ProfileEdit extends State<ProfileEdit> {
  var avatarController = TextEditingController(text: AuthService.getCurrentUser().avatarURL);
  var collegeController = TextEditingController(text: AuthService.getCurrentUser().college);
  var departmentController = TextEditingController(text: AuthService.getCurrentUser().department);
  var descriptionController = TextEditingController(text: AuthService.getCurrentUser().description);
  var firstnameController = TextEditingController(text: AuthService.getCurrentUser().firstName);
  var lastnameController = TextEditingController(text: AuthService.getCurrentUser().lastName);
  var institutionController = TextEditingController(text: AuthService.getCurrentUser().institution);
  // var interestsController = TextEditingController(text: AuthService.getCurrentUser().interests.toString());
  var majorController = TextEditingController(text: AuthService.getCurrentUser().major);
  bool roleChecked = (AuthService.getCurrentUser().role == 1);

  @override
  Widget build(BuildContext context) {
    User user = AuthService.getCurrentUser();
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(10.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextFormField(
              controller: firstnameController,
              decoration: InputDecoration(
                labelText: 'First Name',
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
            ),
            Spacer(flex: 1),
            TextFormField(
              controller: lastnameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
            ),
            Spacer(flex: 1),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
            ),
            Spacer(flex: 1),
            TextFormField(
              controller: avatarController,
              decoration: InputDecoration(
                labelText: 'Avatar URL',
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
            ),
            Spacer(flex: 1),
            TextFormField(
              controller: majorController,
              decoration: InputDecoration(
                labelText: 'Major',
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
            ),
            Spacer(flex: 1),
            TextFormField(
              controller: institutionController,
              decoration: InputDecoration(
                labelText: 'Institution',
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
            ),
            Spacer(flex: 1),
            TextFormField(
              controller: collegeController,
              decoration: InputDecoration(
                labelText: 'College',
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
            ),
            Spacer(flex: 1),
            TextFormField(
              controller: departmentController,
              decoration: InputDecoration(
                labelText: 'Department',
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
            ),

            // Spacer(flex: 1),
            // TextFormField(
            //   controller: interestsController,
            //   decoration: InputDecoration(
            //     labelText: 'Interests',
            //     border: new OutlineInputBorder(
            //       borderRadius: new BorderRadius.circular(25.0),
            //       borderSide: new BorderSide(),
            //     ),
            //   ),
            // ),

            CheckboxListTile (
               value: roleChecked,
               title: Text("Mentor"),
               onChanged: (value) {
                setState(() {
                  roleChecked = value;
                });
              },
            ),

            Spacer(flex: 8),
            FlatButton(
              color: Colors.orange,
              textColor: Colors.white,
              padding: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
              ),
              onPressed: () {
                user.institution = institutionController.text;
                user.major = majorController.text;
                user.avatarURL = avatarController.text;
                user.college = collegeController.text;
                user.department = departmentController.text;
                user.description = descriptionController.text;
                user.firstName = firstnameController.text;
                user.lastName = lastnameController.text;
                
                // user.interests = interestsController; 
                if(roleChecked) {
                  user.role = 1;
                } else {
                  user.role = 0;
                }

                UserService.updateUser(user);
              },
              child: Text(
                "Save Changes",
                style: TextStyle(fontSize: 25.0),
              ),
            ),
          ],
        ),
      )
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
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