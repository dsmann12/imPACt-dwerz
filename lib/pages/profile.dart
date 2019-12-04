import 'package:flutter/material.dart';
import 'package:impact/pages/login.dart';
import 'package:impact/services/authentication.dart';
import 'package:impact/pages/routes.dart';
import 'package:impact/models/user.dart';
import 'package:impact/services/user_service.dart';
import 'package:impact/pages/root.dart';


class PersonalProfile extends StatefulWidget {
  @override
  _PersonalProfileState createState() => new _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {

  User user = AuthService.getCurrentUser();

  Widget labelTag()
  {
    return (user.isMentor()) ?
        Chip(backgroundColor: Colors.deepPurple, label: Text('Mentor', style: TextStyle(color: Colors.white),)) :
        Chip(backgroundColor: Colors.amber[900], label: Text('Mentee', style: TextStyle(color: Colors.white)));
  }

  Widget majorOrDepartment()
  {
    return (user.isMentor()) ?
        Text(
          user.department,
            style: TextStyle(
              fontSize: 15.0,
              fontFamily: 'Montserrat'
            ),
            textAlign: TextAlign.center,
        ) :
        Text(
          user.major,
          style: TextStyle(
            fontSize: 15.0,
            fontFamily: 'Montserrat'
          ),
          textAlign: TextAlign.center,
        );
  }

  ImageProvider displayProfilePic()
  {
    return (user.avatarURL == "") ?
        AssetImage('assets/profile_placeholder.png') :
        NetworkImage(user.avatarURL);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
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
                            image: DecorationImage(
                                image: displayProfilePic(),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(Radius.circular(75.0)),

                            )),
                    ])),
            Container(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.fromLTRB(5.0, 300.0, 10.0, 0.0),
                  children: <Widget>[
                    Text(
                      user.firstName + " " + user.lastName,
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                      textAlign: TextAlign.center,
                    ),
                    labelTag(), //Mentor/Mentee Tag
                    Text(
                      user.description,
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Montserrat'),
                      textAlign: TextAlign.center,
                    ),

                    Text(
                      user.institution,
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Montserrat'),
                      textAlign: TextAlign.center,
                    ),

                    Text(
                      user.college,
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Montserrat'),
                      textAlign: TextAlign.center,
                    ),

                    majorOrDepartment(),


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

                  ],
                )),
          ],

        ),
    );
  }
}

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEdit createState() => _ProfileEdit();
}
class _ProfileEdit extends State<ProfileEdit> {

  User user = AuthService.getCurrentUser();

  var avatarController = TextEditingController(text: AuthService.getCurrentUser().avatarURL);
  var collegeController = TextEditingController(text: AuthService.getCurrentUser().college);
  var departmentController = TextEditingController(text: AuthService.getCurrentUser().department);
  var descriptionController = TextEditingController(text: AuthService.getCurrentUser().description);
  var firstnameController = TextEditingController(text: AuthService.getCurrentUser().firstName);
  var lastnameController = TextEditingController(text: AuthService.getCurrentUser().lastName);
  var institutionController = TextEditingController(text: AuthService.getCurrentUser().institution);
  var majorController = TextEditingController(text: AuthService.getCurrentUser().major);
  bool roleChecked = (AuthService.getCurrentUser().isMentor());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(10.0),
        child: new ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: firstnameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: lastnameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: avatarController,
                decoration: InputDecoration(
                  labelText: 'Avatar URL',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: majorController,
                decoration: InputDecoration(
                  labelText: 'Major',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: institutionController,
                decoration: InputDecoration(
                  labelText: 'Institution',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: collegeController,
                decoration: InputDecoration(
                  labelText: 'College',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: departmentController,
                decoration: InputDecoration(
                  labelText: 'Department',
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: CheckboxListTile (
               value: roleChecked,
               title: Text("Mentor"),
               onChanged: (value) {
                setState(() {
                  roleChecked = value;
                });
              },
              )
            ),

            RaisedButton(
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
                
                if(roleChecked) {
                  user.role = 1;
                } else {
                  user.role = 0;
                }

                UserService.updateUser(user);
                Navigator.of(context).pushReplacement(FadePageRoute(
                  builder: (context) => RootPage(),
                ));
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