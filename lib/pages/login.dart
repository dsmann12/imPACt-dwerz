import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:impact/pages/root.dart';
import 'package:impact/pages/routes.dart';
import 'package:impact/services/authentication.dart';
import 'package:impact/pages/intro_page.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/auth';

  //Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  // Future<String> _loginUser(LoginData data) {
  //   // return Future.delayed(loginTime).then((_) {
  //   //   if (!mockUsers.containsKey(data.name)) {
  //   //     return 'Username not exists';
  //   //   }
  //   //   if (mockUsers[data.name] != data.password) {
  //   //     return 'Password does not match';
  //   //   }
  //   //   return null;
  //   // });
  //   return AuthService.signIn(data.name, data.password).then((value) {
  //     return value;
  //   });
  // }

  // Future<String> _signUpUser(LoginData data) {
  //   // return Future.delayed(loginTime).then((_) {
  //   //   if (!mockUsers.containsKey(data.name)) {
  //   //     return 'Username not exists';
  //   //   }
  //   //   if (mockUsers[data.name] != data.password) {
  //   //     return 'Password does not match';
  //   //   }
  //   //   return null;
  //   // });
  //   return AuthService.signUp(data.name, data.password).then((value) {
  //     return value;
  //   });
  // }

//  Future<String> _recoverPassword(String name) {
//    return Future.delayed(loginTime).then((_) {
//      if (!mockUsers.containsKey(name)) {
//        return 'Username not exists';
//      }
//      return null;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return FlutterLogin(
      title: 'imPACt',
      emailValidator: (value) {
        if (!value.contains('@') || (!value.endsWith('.com') && !value.endsWith('.edu'))) {
          return "Email must contain '@' and end with .edu";
        }
        return null;
      },
      passwordValidator: (value) {
        if (value.isEmpty) {
          return 'Password is empty';
        }
        return null;
      },
      onLogin: (loginData) {
        print('Login info');
        print('Name: ${loginData.name}');
        print('Password: ${loginData.password}');
        // return _loginUser(loginData);
        return AuthService.signIn(loginData.name, loginData.password);
      },
      onSignup: (loginData) {
        print('Signup info');
        print('Name: ${loginData.name}');
        print('Password: ${loginData.password}');
        // return _loginUser(loginData);
        // return _signUpUser(loginData);
        return AuthService.signUp(loginData.name, loginData.password);
      },
      onSubmitAnimationCompleted: () {
        print(AuthService.newSignUp);
        Navigator.of(context).pushReplacement(FadePageRoute(
          builder: (context) => (AuthService.newSignUp) ? IntroScreen() : RootPage(),
        ));
      },
//      onRecoverPassword: (name) {
//        print('Recover password info');
//        print('Name: $name');
//        return _recoverPassword(name);
//        // Show new password dialog
//      },
    );
  }
}